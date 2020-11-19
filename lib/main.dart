import 'package:firebase_auth/firebase_auth.dart';
import 'package:isa_app/admin/admin_home.dart';
import 'package:isa_app/admin/edit_product.dart';
import 'package:isa_app/admin/manage_product.dart';
import 'package:isa_app/admin/order_details.dart';
import 'package:isa_app/admin/order_screen.dart';
import 'package:isa_app/constants.dart';
import 'package:isa_app/provider/admin_mode.dart';
import 'package:isa_app/provider/cart_item.dart';
import 'package:isa_app/provider/modelHud.dart';
import 'package:isa_app/screens/cart_screen.dart';
import 'package:isa_app/screens/homepage.dart';
import 'package:isa_app/screens/login_screen.dart';
import 'package:isa_app/screens/product_info.dart';
import 'package:isa_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin/add_product.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                  'Loading...'
                ),
              ),
            ),
          );
        }
        else{
          isUserLoggedIn = snapshot.data.getBool(kKeepMeLoggedIn) ?? false;
         return MultiProvider(
            providers: [
              ChangeNotifierProvider<ModelHud>(
                  create: (context) => ModelHud()),

              ChangeNotifierProvider<AdminMode>(
                  create: (context) => AdminMode()),

              ChangeNotifierProvider<CartItem>(
                  create: (context) => CartItem()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: isUserLoggedIn ? HomePage.id :LoginScreen.id,
              routes: {
                LoginScreen.id : (context) => LoginScreen(),
                SignupScreen.id : (context) => SignupScreen(),
                HomePage.id : (context) => HomePage(),
                AdminHome.id : (context) => AdminHome(),
                AddProduct.id : (context) => AddProduct(),
                ManageProduct.id : (context) => ManageProduct(),
                EditProduct.id : (context) => EditProduct(),
                ProductInfo.id : (context) => ProductInfo(),
                CartScreen.id : (context) => CartScreen(),
                OrdersScreen.id : (context) => OrdersScreen(),
                OrderDetails.id : (context) => OrderDetails(),
              },
            ),
          );
        }
      },
    );
  }
}