import 'package:flutter/material.dart';
import 'package:isa_app/admin/manage_product.dart';
import 'package:isa_app/constants.dart';
import 'package:isa_app/models/products.dart';
import 'package:isa_app/provider/cart_item.dart';
import 'package:isa_app/screens/product_info.dart';
import 'package:isa_app/services/store.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';
  var adress;

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider
        .of<CartItem>(context)
        .products;
    final double heightScreen = MediaQuery.of(context).size.height;
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightappbar = AppBar().preferredSize.height;
    final double heightStatusbar = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
        body: Column(
          children: <Widget>[
            LayoutBuilder(
              builder:(context,constrains) {
                if(products.isNotEmpty) {
                  return Container(
                    height: heightScreen - heightappbar - heightStatusbar -
                        (heightScreen*.08),
                    child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child: GestureDetector(
                              onTapUp: (details){
                                showCustMenu(details,context,products[index]);
                              },
                              child: Container(
                                color: Colors.black38,
                                height: heightScreen * .15,
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: heightScreen * .15 / 2,
                                      backgroundImage: AssetImage(
                                          products[index].pLocation),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: <Widget>[
                                                Text(
                                                  products[index].pName,
                                                  style: TextStyle(
                                                      fontSize: 18
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '\$ ${products[index].pPrice}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                  ),)
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Text(
                                              products[index].pQuantity
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  );
                }
                else{
                  return Container(
                    height: heightScreen -
                        (heightScreen*.08)-
                    heightappbar-
                    heightStatusbar,
                    child: Center(
                      child: Text(
                          'The Card Is Empty',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  );
                }
              }
            ),
            Builder(
              builder:(context) => ButtonTheme(
                minWidth: widthScreen,
                height: heightScreen *.08,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                    onPressed: (){
                    showCustomDialog(products,context);
                    },
                    child: Text(
                        'ORDER',
                      style: TextStyle(
                        fontSize: 25
                      ),
                    ),
                  color: kMainColor,
                ),
              ),
            )
          ],
        )
    );
  }

  void showCustMenu(details,context,product) async{
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
      Navigator.pop(context);
      Provider.of<CartItem>(context,listen: false).deleteProduct(product);
      Navigator.pushNamed(context, ProductInfo.id,arguments: product);
    },
    ),
    MyPopupMenuItem(
    child: Text(
    'Delete'
    ),
    onclick: (){
      Navigator.pop(context);
      Provider.of<CartItem>(context,listen: false).deleteProduct(product);
    },
    ),
    ]
    );
  }

  void showCustomDialog(List<Product> products,context) async{
    var price = getTotalPrice(products);
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: (){
            try {
              Store _store = Store();
              _store.storeOrders({
                kTotalPrice: price,
                kAdress: adress
              }, products);
              Scaffold.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 6),
                backgroundColor: Colors.red,
                content: Text(
                    'Order successfuly'
                ),
              ));
              Navigator.pop(context);
            }
            catch(ex){
              print(ex.message);
            }
          },
          child: Text(
              'Confirm',
            style: TextStyle(
            ),
          ),
        )
      ],
      content: TextFormField(
        onChanged: (value){
          adress =value;
        },
        decoration: InputDecoration(
          hintText: 'Enter Your Email Adress'
        ),
      ),
      title: Text('total price is \$ ${price}'),
    );
    await showDialog(
        context: context,
      builder: (context){
          return alertDialog;
      }
    );
  }

  getTotalPrice(List<Product> products) {
    var price = 0;
    for(var product in products){
      price +=product.pQuantity *int.parse(product.pPrice);
    }
    return price;
  }
}
