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
//TO IMPORT SQL FILE DO THIS ONLY IF YOU DROP THE DATABASE AND RECREATE IT (BE CAREFUL WITH THIS)
//mysql --host=us-cdbr-east-02.cleardb.com --user=b106186f8dedb8 --password=24a96bfd --reconnect heroku_8b16e6334be95e8 < sql/video-game-db.sql

//TO USE THE DATABASE DO THIS IN THE TERMINAL
//mysql --host=us-cdbr-east-02.cleardb.com --user=b106186f8dedb8 --password=24a96bfd --reconnect heroku_8b16e6334be95e8

//THIS IS THE NAME OF OUR TABLE WHERE USERS AND VIDEO GAMES ARE IN
//heroku_8b16e6334be95e8

/*
INSERT INTO `users` (`userId`,`firstname`,`lastname`,`username`,`password`) VALUES
(1,'Cristian','Arredondo','CristianArredondo123','123'),
(2,'Christian','Jimenez','ChristianJimenez123','1234'),
(3,'Victor','Cuin','VictorCuin123','12345'),
(4,'Elijah','Hallera','ElijahHallera123','123456');
*/

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


app.get('/edit', async function(req,res){
    let current = req.session.user;
    // var stmt = 'SELECT * FROM users WHERE userId=' + req.params.userId + ';';
    // connection.query(stmt, function(error,result){
    //     if(error){
    //       console.log(stmt);
    //       throw error;   
    //     }
    //     if(result.length){
    //         var user = result[0];
    //     }
    //     res.render('edit', {user: user});
    // });
    
    
    res.render('edit', {user: req.session.user, username: req.session.firstname, last: req.session.lastname, password: req.session.password, userId: req.session.userId});
});



app.get('/user', function(req, res){
    var username = req.session.user;
    //var firstname;
    //var lastname;
    var statement = 'select firstname,lastname ' +
               'from users ' +
               'where users.username=\'' 
                + username + '\';'
                
    connection.query(statement,function(error, results){
        
        if(error) throw error;
        
        //firstname = results[0].firstname;
        //lastname = results[0].lastname;
        
        res.render('user', {user: req.session.user, firstname:req.session.firstname, lastname:req.session.lastname, password: req.session.password, userId: req.session.userId});
        
    });
});

app.put('/users/:userId', function(req, res){
    var first = req.body.firstname;
    var last = req.body.lastname;
    var username = req.body.username;
    
    var stmt = 'UPDATE users SET ' +
                'firstname = "' +
                req.body.firstname +
                '",' +
                'lastname = "' +
                req.body.lastname +
                '",' +
                'username = "' +
                req.body.username +
                '"' +
                'WHERE userId = ' +
                req.session.userId +
                ';';
    connection.query(stmt, function(error, result){
        if(error){
          console.log("didnt work");
          throw error;  
        } 
        res.redirect('/user');
    });
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
        req.session.firstname = isUserExist[0].firstname;
        req.session.lastname = isUserExist[0].lastname;
        req.session.password = req.body.password;
        req.session.userId = isUserExist[0].userId;
        
        //CHECK BACK HERE
        res.redirect('/');
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


//NEW ADD CART
app.get('/cart/:aid/add', function(req,res){
    
    var username = req.session.user;
    
    var statement = 'select userId ' +
               'from users ' +
               'where users.username=\'' 
                + username + '\';'
    
    connection.query(statement,function(error, results){
        
        if(error) throw error;
        
        var usersId = results[0].userId;
        
        connection.query('SELECT COUNT(*) FROM games', function(error,results){
        
        if(error) throw error;
        
        if(results.length){
            
            console.log(results);
            
            //RETRIEVING RECIPE
             var statement = 'select * ' +
               'from games ' +
               'where games.gameId=\'' 
                + req.params.aid + '\';'
        
            connection.query(statement,function(error,results){
                
                var games = results[0];
                
                var stmt = 'INSERT INTO games ' + 
                '(`userId`, `name`,`image`,`yearMade`,`genre`) ' +
                'VALUES ' +
                '(' +
                usersId + ',"' +
                games.name + '","' +
                games.image + '",' +
                games.yearMade + ',"' +
                games.genre + '"' +
                ');';
                
                console.log(stmt);
                
                connection.query(stmt, function(error, result) {
                    
                if(error) throw error;
                
               res.redirect('/');
            });
        });
    }
});
});
});

//DELETE A GAME FROM USER CART 
app.get('/cart/:aid/delete', function(req, res){
    var stmt = 'DELETE from games WHERE games.gameId='+ req.params.aid + ';';
    connection.query(stmt, function(error, result){
        if(error) throw error;
        res.redirect('/');
    });
});

//ROUTE TO SHOW USERS CART
app.get('/cart', isAuthenticatedHome, function(req,res){
    
    var username = req.session.user;
    var statement = 'select userId ' +
               'from users ' +
               'where users.username=\'' 
                + username + '\';'
    
    connection.query(statement,function(error, results){
        
        if(error) throw error;
        
        var usersId = results[0].userId;
               
        var stmt = 'select gameId, name, image, yearMade, genre ' +
               'from games ' +
               'where games.userId=\'' 
                + usersId + '\';'
               
    connection.query(stmt, function(error, results){
        
        if(error) throw error;
        
        res.render('cart', {gamesInfo:results});  //both name and quotes are passed to quotes view     
    });
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