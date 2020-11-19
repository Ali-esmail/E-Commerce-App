import 'package:isa_app/provider/modelHud.dart';
import 'package:isa_app/screens/homepage.dart';
import 'package:isa_app/screens/login_screen.dart';
import 'package:isa_app/services/auth.dart';
import 'package:isa_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  static String id = 'SignupScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _email,_password;
  final _auth = Auth();

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
                hint: 'Enter Your Name',
                icon: Icons.perm_identity,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onclick: (value){
                  _email = value;
                },
                hint: 'Enter Your Email',
                icon: Icons.email,
              ),
              SizedBox(
                height: height * .02,
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
                      onPressed: ()async{
                        final modelhud= Provider.of<ModelHud>(context,
                            listen: false);
                        modelhud.changeisLoading(true);
                        if(_globalKey.currentState.validate()){
                          try {
                            _globalKey.currentState.save();
                            final authresult = await _auth.Signup(_email,
                                _password);
                            modelhud.changeisLoading(false);
                            Navigator.pushNamed(context, LoginScreen.id);
                          } catch(e){
                            modelhud.changeisLoading(false);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 10),
                                backgroundColor: Colors.red,
                                content : Text(e.message))
                            );
                          }
                        }
                        modelhud.changeisLoading(false);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'do have an account ? ',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      ' Login',
                      style: TextStyle(
                          fontSize: 25
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}