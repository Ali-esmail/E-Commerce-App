import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isa_app/models/products.dart';
import 'package:isa_app/services/store.dart';
import 'package:isa_app/widgets/custom_textfield.dart';

import '../constants.dart';
import 'edit_product.dart';

class ManageProduct extends StatefulWidget {
  static String id = 'ManageProduct';

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder:(context,snapshot){
          if(snapshot.hasData){
            List<Product> products = [];
            for(var doc in snapshot.data.documents){
              var data = doc.data;
              products.add(Product(
                pId: doc.documentID,
                pName: data()[kProductName].toString(),
                pPrice: data()[kProductPrice].toString(),
                pDescription: data()[kProductDescription].toString(),
                pCategory: data()[kProductCategory].toString(),
                pLocation: data()[kProductLocation],
              )
              );
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8
              ),
              itemBuilder:
                  (context,index)=> Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,
                        vertical: 10),
                    child: GestureDetector(
                      onTapUp: (details)async{
                        double dx = details.globalPosition.dx;
                        double dy = details.globalPosition.dy;
                        double dx2 = MediaQuery.of(context).size.width-dx;
                        double dy2 = MediaQuery.of(context).size.width-dy;
                       await showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(dx, dy, dx2,
                                dy2),
                            items: [
                              MyPopupMenuItem(
                                child: Text(
                                  'Edit'
                                ),
                                onclick: (){
                                  Navigator.pushNamed(context, EditProduct
                                      .id, arguments: products[index]);
                                },
                              ),
                              MyPopupMenuItem(
                                  child: Text(
                                      'Delete'
                                  ),
                                onclick: (){
                                  _store.deleteProduct(products[index].pId);
                                  Navigator.pop(context);
                                },
                              ),
                            ]
                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                              child: Image(
                                fit: BoxFit.fill,
                                  image: products[index].pLocation ==null
                                      ? Container() :AssetImage
                          (products[index].pLocation)
                              )
                          ),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: .6,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric
                                    (horizontal: 10,vertical: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        products[index].pName,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        ' \$ ${products[index].pPrice}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              itemCount: products.length,
            );
          }
          else{
           return Center(
              child: Text(
                'Loading..........'
              ),
            );
          }
        }
      )
    );
  }
}

class MyPopupMenuItem<T> extends PopupMenuItem<T>{
  final Widget child;
  final Function onclick;
  MyPopupMenuItem({this.child,this.onclick}) : super(child : child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    // TODO: implement createState
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T,PopupMenuItem> extends PopupMenuItemState<T, MyPopupMenuItem<T>>{

  @override
  void handleTap() {
    widget.onclick();

  }
}
