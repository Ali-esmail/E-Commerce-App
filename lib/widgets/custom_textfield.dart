import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onclick;

  const CustomTextField({Key key, this.hint, this.icon, this.onclick}) : super(key: key);


  String _ErrorMessage(String str){
    switch(hint){
      case 'Product Price' : return 'Enter price';
      case 'Product Name' : return 'Name is reqired';
      case 'Product Description' : return 'Description is Requird';
      case 'Product Category' : return 'category is Requird';
      case 'Product Location' : return 'location is Requird';
      case 'Enter Your Name' : return 'Name is Requird';
      case 'Enter Your Email' : return 'Email is Requird';
      case 'Enter Your Password' : return 'Password is Requird';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value){
          if(value.isEmpty){
            return _ErrorMessage(hint);
          }
        },
        onSaved: onclick,
        obscureText: hint == 'Enter Your Password' ? true : false,
        cursorColor: kMainColor,
        decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: kMainColor,
            ),
            filled: true,
            fillColor: kSecondaryColor,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.white
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.white
                )
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.white
                )
            )
        ),
      ),
    );
  }
}