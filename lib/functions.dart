import 'package:isa_app/constants.dart';

import 'models/products.dart';

List<Product> getProductByCategory(String kJackets,List<Product> allproduct) {
  List<Product> products = [];
  try {
    for (var product in allproduct) {
      if (product.pCategory == kJackets) {
        products.add(product);
      }
    }
  }
  on Error catch(ex){
    print(ex);
  }
  return products;
}