import 'package:flutter/material.dart';
import 'package:isa_app/admin/add_product.dart';
import 'package:isa_app/admin/manage_product.dart';
import 'package:isa_app/admin/order_screen.dart';
import 'package:isa_app/constants.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    String user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
              Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: user !=null ? ClipOval(
          child: Container(
            child: Center(
              child: Text('${user}',
                style: TextStyle(
                    fontSize: 27,
                    fontFamily: 'pacifico',
                  color: Colors.black
                ),
              ),
            ),
          ),
        )
            : Container(color: Colors.white,),
      ),
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Container(
            alignment: Alignment.bottomRight,
            child: ButtonTheme(
              height: 80,
              child: RaisedButton(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                child: Text('Add Product',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                  onPressed: (){
                  Navigator.pushNamed(context, AddProduct.id);
              }
              ),
            ),
          ),
          SizedBox(height: 23,),
          Container(
            child: Center(
              child: ButtonTheme(
                height: 80,
                child: RaisedButton(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                    child: Text('Edit Product',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, ManageProduct.id);
                    }
                ),
              ),
            ),
          ),
          SizedBox(height: 23,),
          Container(
            alignment: Alignment.bottomLeft,
            child: ButtonTheme(
              height: 80,
              child: RaisedButton(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: Text('View Orders',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, OrdersScreen.id);
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}

