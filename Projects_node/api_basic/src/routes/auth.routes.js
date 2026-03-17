import { Router } from 'express';
import { register, login } from '../controllers/auth.controller.js';

const router = Router();
const apiName = '/auth';

router.route(`${apiName}/register`)
  .post(register) ;
  router.route(`${apiName}/login`).post(login); 


export default router;