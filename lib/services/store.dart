import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isa_app/constants.dart';
import 'package:isa_app/models/products.dart';

class Store{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  addproduct(Product product){

_firestore.collection(kProductCollection).add(
  {
    kProductName : product.pName,
    kProductPrice: product.pPrice,
    kProductDescription : product.pDescription,
    kProductCategory : product.pCategory,
    kProductLocation : product.pLocation,
  }
);
  }

  Stream<QuerySnapshot>loadProducts() {
   return _firestore.collection(kProductCollection).snapshots();
  }

  Stream<QuerySnapshot> loadOrders(){
    return _firestore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId){
    return _firestore.collection(kOrders).document(documentId).collection
      (kOrderDetails).snapshots();
  }

  deleteProduct(documentId){
    _firestore.collection(kProductCollection).document(documentId).delete();
  }

  editProduct(documentId,data){
    _firestore.collection(kProductCollection).document(documentId).updateData(data);
  }

  storeOrders(data,List<Product> products){
    var documentref = _firestore.collection(kOrders).document();
    documentref.setData(data);
    for(var product in products){
      documentref.collection(kOrderDetails).document().setData(
        {
          kProductName : product.pName,
          kProductPrice :product.pPrice,
          kProductQuantity : product.pQuantity,
          kProductLocation : product.pLocation,
          kProductCategory : product.pCategory,
          kProductDescription : product.pDescription,
        }
      );
    }
  }
}