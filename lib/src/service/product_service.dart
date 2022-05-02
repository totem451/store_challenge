import 'dart:convert';

import 'package:store_challenge/src/model/models.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String url = 'https://createthrivestore-default-rtdb.firebaseio.com/';
  Future<List<ProductModel>> listProducts() async {
    List<ProductModel> products = [];
    var resp = await http.get(Uri.parse(url + 'product.json'));
    if (resp.statusCode == 200) {
      final Map<String, dynamic> productsMap = json.decode(resp.body);
      productsMap.forEach((key, value) {
        final tempProduct = ProductModel.fromMap(value);
        products.add(tempProduct);
      });
    }
    return products;
  }

  deleteProducts(name) async {
    var resp = await http.delete(Uri.parse(url + 'product/$name.json'));
    return resp.statusCode;
  }
}
