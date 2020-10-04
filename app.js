//App configuration
var express = require('express');
var bodyParser = require('body-parser');
var mysql = require('mysql');
var session = require('express-session');
var bcrypt = require('bcrypt');
var app = express();
//const request = require('request');
var methodOverride = require('method-override');

app.use(methodOverride('_method'));
app.set("view engine","ejs");
app.use(express.static('public')); //specify folder for images,css,js
app.use(bodyParser.urlencoded({extended: true}));

app.use(session({
    secret: 'top secret code!',
    resave: true,
    saveUninitialized: true
}));

//PERMISSIONS FOR DATABASE ADMIN ACCOUNT
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'cristian',
    password: 'cristian',
    database: 'video_game_db'
});

module.exports = {
  HOST: "us-cdbr-east-02.cleardb.com",
  USER: "b106186f8dedb8",
  PASSWORD: "24a96bfd",
  DB: "heroku_8b16e6334be95e8"
};

/*
username:b106186f8dedb8
password:24a96bfd
host:us-cdbr-east-02.cleardb.com
database:heroku_8b16e6334be95e8
*/

connection.connect();

//INITIAL ROUTES
//-------------------------------------------------------------------------------------
app.get("/homeSignedIn", async function(req,res){
    res.render("homeSignedIn"); //sends array of parsedData to the home.ejs view
});

//AUTHENTICATION FOR HOME
app.get('/home', isAuthenticatedHome, function(req, res){
   res.redirect('/');
});

//DEFAULT HOME
app.get('/', isAuthenticatedHome, function(req, res){
   res.render('homeSignedIn', {user: req.session.user}); 
});

app.get('/login', function(req, res){
    res.render('login');
});

app.get('/logout', function(req, res){
   req.session.destroy();
   res.redirect('/');
});

app.get('/create_account', function(req,res){
    res.render('create_account');
});

app.get('*', function(req, res){
    res.render('error');
});

//INSERTS THE NEW ACCOUNT INTO THE USERS TABLE BY TAKING INFO FROM CREATE ACCOUNT EJS
app.post('/create_account', function(req, res){
    let salt = 10;
    bcrypt.hash(req.body.password, salt, function(error, hash){
        if(error) throw error;
        let stmt = 'INSERT INTO users (firstname,lastname,username,password) VALUES (?,?,?,?)';
        let data = [req.body.firstname,req.body.lastname,req.body.username,hash];
        connection.query(stmt, data, function(error, result){
           if(error) throw error;
           console.log(stmt);
           res.redirect('/login');
        });
    });
});

//CHECKS IF USERNAME AND PASSWORD ARE IN THE DATABASE USER TABLE
app.post('/login', async function(req, res){
    let isUserExist = await checkUsername(req.body.username);
    let hashedPasswd = isUserExist.length > 0 ? isUserExist[0].password : '';
    let passwordMatch = await checkPassword(req.body.password, hashedPasswd);
    if(passwordMatch){
        
        req.session.authenticated = true;
        req.session.user = isUserExist[0].username;
        
        res.redirect('/home');
    }
    else{
        res.render('login', {error: true});
    }
});

//FUNCTIONS
//-------------------------------------------------------------------------------------------

function isAuthenticatedHome(req, res, next){
    if(!req.session.authenticated) res.render('home');
    else next();
}

//FUNCTION TO CHECK USERNAME AT LOGIN USING USERNAME PASSED INTO FUNCTION
function checkUsername(username){
    let stmt = 'SELECT * FROM users WHERE username=?';
    return new Promise(function(resolve, reject){
       connection.query(stmt,[username],function(error, results){
           if(error) throw error;
           resolve(results);
       }); 
    });
}

//FUNCTION TO CHECK PASSWORD AT LOGIN
function checkPassword(password, hash){
    return new Promise(function(resolve, reject){
       bcrypt.compare(password, hash, function(error, result){
          if(error) throw error;
          resolve(result);
       }); 
    });
}

//LISTENER
app.listen(process.env.PORT,process.env.IP,function(){
    console.log("Running Express Server...");
});
