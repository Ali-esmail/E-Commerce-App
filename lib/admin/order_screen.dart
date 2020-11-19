import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isa_app/constants.dart';
import 'package:isa_app/models/order.dart';
import 'package:isa_app/services/store.dart';

import 'order_details.dart';

class OrdersScreen extends StatelessWidget {
  static String id = 'OrdersScreen';
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(
              child: Text('There is no Orders'),
            );
          }
          else{
            List<Order> orders = [];
            for(var doc in snapshot.data.documents){
              orders.add(Order(
                documentId: doc.documentID,
               totalPrice: doc.data()[kTotalPrice],
               adress: doc.data()[kAdress],
              ));
            }
            return ListView.builder(
              itemCount: orders.length,
                itemBuilder: (context,index)=>
                    Padding(
                      padding: const EdgeInsets.all(17),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, OrderDetails.id,
                              arguments: orders[index].documentId);
                        },
                        child: Container(
                          color: kSecondaryColor,
                          height: MediaQuery.of(context).size.height*.2,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Total Price \$${orders[index].totalPrice}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Adress is  ${orders[index].adress}',
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
                    )
            );
          }
        },
      ),
    );
  }
}
