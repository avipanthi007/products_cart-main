import 'package:fake_products/src/models/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList cartItems = [].obs;
  List<ProductsModel> cart = [];
  RxInt total = 0.obs;
  addItems(int productId, ProductsModel product) {
    cartItems.add(productId);
    cart.add(product);
    update();
  }

  updateTotal() {
    total.value = 0;
    for (var item in cart) {
      total += item.price.toInt() * item.quantity;
    }
    update();
  }

  removeItems(int productId, ProductsModel product) {
    cartItems.remove(productId);
    cart.remove(product);

    update();
  }
}
