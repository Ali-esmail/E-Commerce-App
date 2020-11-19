import 'package:flutter/material.dart';
import 'package:isa_app/models/products.dart';
import 'package:isa_app/screens/product_info.dart';

import '../functions.dart';

Widget productView(String pCategory,List<Product> allproduct) {
  List<Product> products = [];
  products = getProductByCategory(pCategory,allproduct);
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
        onTap: (){
          Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
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
                          ' \$${products[index].pPrice}',
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