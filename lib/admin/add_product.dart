import 'package:flutter/material.dart';
import 'package:isa_app/models/products.dart';
import 'package:isa_app/services/store.dart';
import 'package:isa_app/widgets/custom_textfield.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  String _name,_price,_description,_category,_imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height*.2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  hint: 'Product Name',
                  onclick: (value){
                    _name = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Product Price',
                  onclick: (value){
                    _price = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Product Description',
                  onclick: (value){
                    _description = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Product Category',
                  onclick: (value){
                    _category = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Product Location',
                  onclick: (value){
                    _imageLocation = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Builder(
                  builder:(context) => RaisedButton(
                    onPressed: (){
                      if(_globalKey.currentState.validate()){
                        _globalKey.currentState.save();
                        _store.addproduct(Product(
                          pName: _name,
                          pPrice: _price,
                          pDescription: _description,
                          pCategory: _category,
                          pLocation: _imageLocation,
                        ));
                        Scaffold.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 6),
                          backgroundColor: Colors.red,
                          content: Text(
                              ' ${_name} \n with \$ ${_price} '
                                  'added'
                          ),
                        ));
                      }
                    },
                    child: Text('Add Product'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
