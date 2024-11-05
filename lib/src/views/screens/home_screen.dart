import 'package:fake_products/api/app_api.dart';
import 'package:fake_products/src/controllers/cart_controller.dart';
import 'package:fake_products/src/models/products_model.dart';
import 'package:fake_products/src/views/screens/cart_screen.dart';
import 'package:fake_products/src/views/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> cartItems = [];
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    print("------${dotenv.env['baseUrl']}");
    return Scaffold(
        appBar: AppBar(
          title: Text("Products"),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => CartScreen());
                },
                icon: Icon(Icons.shopping_bag)),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: FutureBuilder<List<ProductsModel>>(
          future: AppApi().products(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ProductsModel>> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 38.h, crossAxisCount: 2),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  ProductsModel product = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ProductScreen(
                            product: product,
                          ));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.green.shade600)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(160.sp),
                                  border:
                                      Border.all(color: Colors.green.shade600)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(160),
                                child: Image.network(
                                  product.image,
                                  height: 12.h,
                                  width: 24.w,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text("Category: " + product.category),
                          SizedBox(width: 10),
                          Text(
                            "Rating " + product.rating["rate"].toString(),
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          Row(
                            children: [
                              Text(
                                "Only at -/₹" + product.price.toString(),
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.green.shade600),
                              ),
                              Spacer(),
                            ],
                          ),
                          Obx(() => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: cartController.cartItems
                                          .contains(product.id)
                                      ? Colors.green.shade600
                                      : null),
                              onPressed: () {
                                !cartController.cartItems.contains(product.id)
                                    ? cartController.addItems(
                                        product.id, product)
                                    : null;
                              },
                              child: Text(
                                cartController.cartItems.contains(product.id)
                                    ? "ADDED TO CART"
                                    : "ADD TO CART",
                                style: TextStyle(
                                    color: cartController.cartItems
                                            .contains(product.id)
                                        ? Colors.white
                                        : null),
                              )))
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
