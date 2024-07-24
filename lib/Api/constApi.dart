// const URLHTTP = '192.168.1.23:3000';
const URLHTTP = '192.168.1.3:3000';
// const URLHTTP = '10.0.2.2:3000';
// const URLHTTP = '10.0.2.2:3000';

const Loginuser = '/api/user/login';
const REGISTERJOUER = '/api/user/register';
const GETMYINFORMATIONJOUEUR = '/api/user/myinformation';
const GETMYINFORMATIONADMIN = '/api/admin/myinformation';
const UPDATEJOUEUR = '/api/user';
const UPDATEADMIN = '/api/admin';
const UPDATEMDPADMIN = '/api/admins/password';
const RECOVERPASSWORD = '/api/user/recoverpassword';
const RECOVERPASSWORDADMIN = '/api/admin/recoverpassword';
const RESETPASSWORD = '/api/user/resetpassword';
const RESETPASSWORDADMIN = '/api/admin/resetpassword';
const VERIFYJOUEURCODE = '/api/users/verifytoken';
const VERIFYADMINCODE = '/api/admins/verifytoken';

//----------------------Section---------------------
const GETALLSECTION = '/api/sections';
const GETSECTIONBYID = '/api/section/';

const COMPLETLESSONPROGRESS = '/api/lesson/complete';
const ADDCOMMENTTOLESSON = '/api/lesson/comment/';
const GETCOMMENTS = '/api/lesson/comments/';
const GETQUIZ = '/api/lesson/quiz/';
const DELETECOMMENT = '/api/lesson/comment/';
const UPDATEQUIZ = '/api/lesson/quiz/';

const Loginadmin = '/api/admin/login';
const getJouerById = '/api/user/';
String PATH = Loginuser;
String PATH1 = RECOVERPASSWORD;
String PATH2 = VERIFYJOUEURCODE;
String PATH3 = RESETPASSWORD;
