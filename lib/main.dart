import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:cliplaza/layout.dart';
import 'package:cliplaza/pages/cart.dart';
import 'package:cliplaza/pages/chat/index.dart';
import 'package:cliplaza/pages/chat/show.dart';
import 'package:cliplaza/pages/checkout.dart';
import 'package:cliplaza/pages/favourites.dart';
import 'package:cliplaza/pages/filters/index.dart';
import 'package:cliplaza/pages/filters/order_by.dart';
import 'package:cliplaza/pages/filters/price.dart';
import 'package:cliplaza/pages/home.dart';
import 'package:cliplaza/pages/filters/recommended.dart';
import 'package:cliplaza/pages/landing.dart';
import 'package:cliplaza/pages/login.dart';
import 'package:cliplaza/pages/profile/faq.dart';
import 'package:cliplaza/pages/profile/index.dart';
import 'package:cliplaza/pages/profile/payments_data.dart';
import 'package:cliplaza/pages/profile/personal_data.dart';
import 'package:cliplaza/pages/profile/security.dart';
import 'package:cliplaza/pages/register.dart';
import 'package:cliplaza/pages/show_product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'SourceSans',
      ),
      routes: {
        RegisterPage.route: (_) => const RegisterPage(),
        LandingPage.route: (_) => const LandingPage(),
        FilterPage.route: (_) => const FilterPage(),
        LoginPage.route: (_) => const LoginPage(),
        HomePage.route: (_) => const HomePage(),
        ShowProduct.route: (_) => const ShowProduct(),
        Chats.route: (_) => const Chats(),
        Chat.route: (_) => const Chat(),
        RecommendedPage.route: (_) => const RecommendedPage(),
        OrderByPage.route: (_) => const OrderByPage(),
        FilterByPrice.route: (_) => const FilterByPrice(),
        MyCart.route: (_) => const MyCart(),
        CheckoutPage.route: (_) => const CheckoutPage(),
        FavouritesPage.route: (_) => const FavouritesPage(),
        PersonalProfilePage.route: (_) => const PersonalProfilePage(),
        PersonalDataPage.route: (_) => const PersonalDataPage(),
        PaymentData.route: (_) => const PaymentData(),
        SecurityData.route: (_) => const SecurityData(),
        FaqPage.route: (_) => const FaqPage(),
      },
      debugShowCheckedModeBanner: false,
      home: const MainNavigator(),
    );
  }
}
