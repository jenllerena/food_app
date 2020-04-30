import 'dart:convert';
import 'package:eatos_app/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  static final _formKey = GlobalKey<FormState>();
   TextEditingController emailController =  TextEditingController();
   TextEditingController passwordController =  TextEditingController();
  String email;
  String password;
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {

    Future signIn(String email, String password) async {
      print(email);
      print(password);
      Map <String,String> data = {
        'username': email,
        'password' : password
      };

      var response = await http.post("https://d.browserapi.eatos.co/user/login",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },body:json.encode(data));
      var jsonData = json.decode(response.body);
      print(jsonData);
      var isLogin = jsonData['success'];
      if(isLogin == 1){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }else{
        Fluttertoast.showToast(
            msg: "username incorrect",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }

    final pageTitle = Container(
        margin: EdgeInsets.only(top: 30),
        //crossAxisAlignment: CrossAxisAlignment.start,
        child: Column(//direction: Axis.vertical,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                "eatOs",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 40.0,
                ),
              )
            ),
            Container(
              child: Text(
                "Point of Sale",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            )
          ],
        )
    );

    final loginForm = Container(
      width: MediaQuery.of(context).size.width/2.5,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(color: Color(0xfff5f5f5),
          borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
              Container(
                  color: Color(0xfff5f5f5),
                  child:Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 10  , 0),
                      child:TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        //onSaved: (value)=> email = value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email or Mobile',
                          hintStyle: TextStyle(color: Colors.grey[400],
                              fontWeight: FontWeight.w600,
                            fontFamily:'Italic'
                          ),
                          labelStyle: TextStyle(color: Colors.blueGrey),
                        ),
                        //keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.grey[600]),
                        cursorColor: Colors.blueGrey,
                      )
                  )
          ),
            Divider(color: Colors.blueGrey[200]),
            Container(
                color: Color(0xfff5f5f5),
                child:Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: Icon(_showPassword ? Icons.visibility : Icons.visibility_off)
                        ),
                        hintStyle: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600),
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        border: InputBorder.none
                      ),
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.grey[600]),
                      cursorColor: Colors.blueGrey,
                      obscureText: !_showPassword,
                      validator: (String value){
                        if(value.isEmpty){return "Please enter your password" ;}
                      },
                    )
                )
            )],
        ),
      ),
    );

    final loginBtn = Padding(
      padding: EdgeInsets.all(25),
      child: Container(
          //margin: EdgeInsets.all(30),
          height: 40,
          width: MediaQuery.of(context).size.width/2.5,
          child: MaterialButton(
            onPressed: (){signIn(emailController.text,passwordController.text);},
            elevation: 5.0,
            //onPressed: (){},// => Navigator.pushNamed(context, homeViewRoute),
            color: Color(0xffE52897),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8),
            ),
            child: Text(
              'SIGN IN',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            textColor: Colors.white,
          )
      ),
    );

    final forgotPassword = Container(
      //padding: EdgeInsets.only(top: 10.0),
      child: InkWell(
        child: Center(
          child: Text(
            'Forgot your Password?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );

    Widget newUser = Container(
        margin: EdgeInsets.fromLTRB(0,10,0,50),
        height: 40,
        width: MediaQuery.of(context).size.width/2.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(8),
        ),
        child: OutlineButton(
          onPressed: (){},// => Navigator.pushNamed(context, homeViewRoute),
          color: Color(0xffE52897),
          borderSide: BorderSide(color:Color(0xffE52897),width: 2.0),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8),
          ),
          child: Text(
            'CREATE AN ACCOUNT',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          textColor: Color(0xffE52897),
        )
      );

    return Scaffold(
      body:
      DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/cocina.jpg'),
              fit: BoxFit.cover,
            )
        ),
        child:SingleChildScrollView(child:
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                pageTitle,
                loginForm,
                loginBtn,
                forgotPassword,
                newUser
              ],
            ),
          )
        )
      ),

    );
  }
}