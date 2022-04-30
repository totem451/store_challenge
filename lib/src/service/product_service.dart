import 'dart:convert';

import 'package:store_challenge/src/model/models.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String url =
      'https://createthrivestore-default-rtdb.firebaseio.com/product.json';
  Future<List<ProductModel>> listProducts() async {
    List<ProductModel> products = [];
    var resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final Map<String, dynamic> productsMap = json.decode(resp.body);
      productsMap.forEach((key, value) {
        final tempProduct = ProductModel.fromMap(value);
        products.add(tempProduct);
      });
    }
    return products;
  }
}
