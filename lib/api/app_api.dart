import 'dart:convert';

import 'package:fake_products/src/models/products_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppApi {
  static String baseUrl = "https://fakestoreapi.com/";

  Future<List<ProductsModel>> products() async {
    Uri url = Uri.parse(baseUrl + "products");
    List<ProductsModel> products = [];
    try {
      http.Response response = await http.get(url);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var item in data) {
          products.add(ProductsModel.fromMap(item));
        }
      }
    } catch (e) {
      Get.snackbar("Message", e.toString());
    }
    return products;
  }
}
