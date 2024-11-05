import 'package:fake_products/src/controllers/cart_controller.dart';
import 'package:fake_products/src/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    return ResponsiveSizer(
      builder: (buildContext, orientation, screenType) {
        return GetMaterialApp(
          defaultTransition: Transition.cupertino,
          transitionDuration: Duration(seconds: 1),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade600),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
