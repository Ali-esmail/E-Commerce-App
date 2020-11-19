import 'package:isa_app/admin/admin_home.dart';
import 'package:isa_app/constants.dart';
import 'package:isa_app/provider/admin_mode.dart';
import 'package:isa_app/provider/modelHud.dart';
import 'package:isa_app/screens/homepage.dart';
import 'package:isa_app/screens/signup_screen.dart';
import 'package:isa_app/services/auth.dart';
import 'package:isa_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String _email,_password;

  final _auth = Auth();

  bool isAdmin = false;

  final AdminPassword = 'admin1234';

  bool keepMeLoggedIn = false;

  void keepUserLoggedin() async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isloading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height*.2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(
                          image: AssetImage('images/icons/buyicon.png')
                      ),
                      Positioned(
                          bottom: 0,
                          child: Text(
                            'Buy It',
                            style: TextStyle(
                                fontFamily: 'Pacifico',
                                fontSize: 25
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              CustomTextField(
                onclick: (value){
                  _email = value;
                },
                hint: 'Enter Your Email',
                icon: Icons.email,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: <Widget>[
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                        checkColor: kSecondaryColor,
                        activeColor: kMainColor,
                        value: keepMeLoggedIn,
                        onChanged: (value){
                          setState(() {
                            keepMeLoggedIn = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      'Remember me',
                      style: TextStyle(color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
              CustomTextField(
                onclick: (value){
                  _password = value;
                },
                hint: 'Enter Your Password',
                icon: Icons.lock,
              ),
              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder:(context) => FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      color: Colors.black,
                      onPressed: (){
                        if(keepMeLoggedIn == true){
                          keepUserLoggedin();
                        }
                        _validate(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'dont have an account ? ',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(
                      ' Sign Up',
                      style: TextStyle(
                          fontSize: 25
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30 , vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Provider.of<AdminMode>(context,listen: false).changeisAdmin(true);
                          },
                          child: Text(
                            'iam an admin',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Provider.of<AdminMode>(context).isAdmin ?
                                kMainColor
                                  :Colors.white,
                              fontSize: 20
                            ),
                          ),
                        )
                    ),
                    Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Provider.of<AdminMode>(context,listen: false).changeisAdmin(false);
                          },
                          child: Text(
                            'iam an user',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Provider.of<AdminMode>(context).isAdmin ? Colors.white : kMainColor,
                              fontSize: 20
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async{
    final modelhud= Provider.of<ModelHud>(context,
        listen: false);
    modelhud.changeisLoading(true);

    if(_globalKey.currentState.validate()){
      _globalKey.currentState.save();
      if(Provider.of<AdminMode>(context,listen: false).isAdmin){

        if(_password == AdminPassword){
          try {
            final user = await _auth.Signin(_email, _password);
            modelhud.changeisLoading(false);
            Navigator.pushNamed(context, AdminHome.id,arguments: user.user.email);
          } catch(e){
            modelhud.changeisLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 10),
              backgroundColor: Colors.red,
              content: Text(
                  e.message
              ),
            ));
          }
        }
        else{
          modelhud.changeisLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 10),
            backgroundColor: Colors.red,
            content: Text(
                'something went wrong !'
            ),
          ));
        }
      }
      else{
        try {
         final user= await _auth.Signin(_email, _password);
          modelhud.changeisLoading(false);
          Navigator.pushNamed(context, HomePage.id,arguments: user.user.email);
        } catch(e){
          modelhud.changeisLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 6),
            backgroundColor: Colors.red,
            content: Text(
                e.message
            ),
          ));
        }
      }
    }
    modelhud.changeisLoading(false);

  }


}