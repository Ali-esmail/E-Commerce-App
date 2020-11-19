import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isa_app/constants.dart';
import 'package:isa_app/models/products.dart';
import 'package:isa_app/services/store.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrderDetails(documentId),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List<Product> products=[];
            for(var doc in snapshot.data.documents){
              products.add(Product(
                pName: doc.data()[kProductName],
                pQuantity: doc.data()[kProductQuantity],
                pCategory: doc.data()[kProductCategory],
                pPrice: doc.data()[kProductPrice].toString(),
                pLocation: doc.data()[kProductLocation],
              ));
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder:(context,index)=>
                           Padding(
                            padding: const EdgeInsets.all(20),
                              child: Container(
                      color: kSecondaryColor,
                      height: MediaQuery.of(context).size.height*.7,
                      child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size
                                        .height*.5,
                                    child: Image(
                                      image: AssetImage(products[index].pLocation),
                                    ),
                                  ),
                                  Text('product name is ${products[index].pName}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Quantity is ${products[index].pQuantity}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Price is \$${products[index].pPrice}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),

                          ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Builder(
                          builder: (context) =>ButtonTheme(
                            buttonColor: kMainColor,
                            child: RaisedButton(
                                onPressed: (){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    duration: Duration(seconds: 6),
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        'Order Confirmed'
                                    ),
                                  ));
                            },
                              child: Text('Confirm Order'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: ButtonTheme(
                          buttonColor: kMainColor,
                          child: RaisedButton(
                            onPressed: (){

                            },
                            child: Text('Delete Order'),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
          else{
           return Center(
              child: Text('loading Order Details'),
            );
          }
        }
      ),
    );
  }
}
