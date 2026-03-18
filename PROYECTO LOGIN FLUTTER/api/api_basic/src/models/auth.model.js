import { connect } from '../config/db/connect.js';
import { encryptPassword, comparePassword } from '../library/appBcrypt.js';
import jwt from "jsonwebtoken";

class AuthModel {
  constructor() {
  }

  async register(req, res) {
    try {
      const { username, email, name, password, profile_photo } = req.body;
      
      const defaultRole = 'Client'; 

      await connect.query('START TRANSACTION');

      // Hashear contraseña
      const hashedPassword = await encryptPassword(password);

      const [apiResult] = await connect.query(
        'INSERT INTO api_users (Api_user, Api_password, Api_role, Api_status) VALUES (?, ?, ?, ?)',
        [username, hashedPassword, defaultRole, 'Active']
      );

      const [profileResult] = await connect.query(
        'INSERT INTO profiles (Profile_email, Profile_name, Profile_photo, User_id_fk) VALUES (?, ?, ?, ?)',
        [email, name, profile_photo || null, apiResult.insertId]
      );

      await connect.query('COMMIT');

      res.status(201).json({ 
        success: true,
        message: "User registered successfully",
        user: {
          id: apiResult.insertId,
          username,
          email,
          name,
          role: defaultRole
        }
      });

    } catch (error) {
      await connect.query('ROLLBACK');
      res.status(500).json({ 
        error: "Error registering user", 
        details: error.message 
      });
    }
  }

  async login(req, res) {
    try {
      const { api_user, api_password } = req.body;
      let sqlQuery = "SELECT * FROM api_users WHERE Api_user= ?";
      const [result] = await connect.query(sqlQuery, api_user);
      
      if (result.length === 0) return res.status(400).json({ error: "user not found" });
      
      const user = result[0];
      const validPassword = await comparePassword(api_password, user.Api_password);
      
      if (!validPassword) return res.status(400).json({ error: "Incorrect password" });
      
      const token = jwt.sign(
        { 
          id: user.Api_user_id, 
          user: user.Api_user,
          role: user.Api_role, 
          status: user.Api_status 
        }, 
        process.env.JWT_SECRET, 
        { expiresIn: "1h" }
      );
      
      res.json({ 
        token,
        user: {
          id: user.Api_user_id,
          username: user.Api_user,
          role: user.Api_role,
          status: user.Api_status
        }
      });
      
    } catch (error) {
      res.status(500).json({ 
        error: "Error logging in", 
        details: error.message 
      });
    }
  }
}

export default AuthModel;