// controllers/auth.controller.js
import AuthModel from '../models/auth.model.js';

export const register = async (req, res) => {
  try {
    const authInstance = new AuthModel();
    authInstance.register(req, res);
  } catch (error) {
    res.status(500).json({ 
      error: "Error registering user", 
      details: error.message 
    });
  }
};

export const login = async (req, res) => {
  try {
    const authInstance = new AuthModel();
    authInstance.login(req, res);
  } catch (error) {
    res.status(500).json({ 
      error: "Error logging in", 
      details: error.message 
    });
  }
};