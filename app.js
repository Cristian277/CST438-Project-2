//App configuration
var express = require('express');
var bodyParser = require('body-parser');
var mysql = require('mysql');
var session = require('express-session');
var bcrypt = require('bcrypt');
var app = express();
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

var connection = mysql.createPool({
  host: "us-cdbr-east-02.cleardb.com",
  user: "b106186f8dedb8",
  password: "24a96bfd",
  database: "heroku_8b16e6334be95e8"
});

module.exports = connection;

//DATABASE INFO
/*
username:b106186f8dedb8
password:24a96bfd
host:us-cdbr-east-02.cleardb.com
database:heroku_8b16e6334be95e8
*/
//IF YOU NEED TO RESET THE DATABASE OR IF YOU UPDATED THE SQL FILE JUST PUT THIS INTO THE TERMINAL
//mysql --host=us-cdbr-east-02.cleardb.com --user=b106186f8dedb8 --password=24a96bfd --reconnect heroku_8b16e6334be95e8 < sql/video-game-db.sql

//TO USE THE DATABASE IF YOU WANT TO LOOK AT THE TABLES AND DATA DO THIS IN THE TERMINAL
//mysql --host=us-cdbr-east-02.cleardb.com --user=b106186f8dedb8 --password=24a96bfd --reconnect heroku_8b16e6334be95e8

//THIS IS THE NAME OF OUR TABLE WHERE USERS AND VIDEO GAMES ARE IN
//heroku_8b16e6334be95e8


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


app.get('/user', function(req,res){
    res.render('user', {user: req.session.user});
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

app.get('/productDetail', function(req, res){
    var sql = 'select * from games where name=\''  + req.query.title + '\';'
	connection.query(sql, function(error, found){
	    var title = null;
	    if(error) throw error;
	    if(found.length){
	        title = found[0];
	    }
	    res.render('productDetail', {title: title});
	});
});

//CART
app.get('/cart', function(req, res){
    res.render('cart');
});

//Search
app.get('/search', function(req, res){
    res.render('search');
});

app.get('/productDetail', function(req, res){
    res.render('productDetail');
});

app.get('*', function(req, res){
    res.render('error');
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
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});
