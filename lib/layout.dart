import 'package:cliplaza/components/appbar.dart';
import 'package:cliplaza/pages/cart.dart';
import 'package:cliplaza/pages/chat/index.dart';
import 'package:cliplaza/pages/chat/show.dart';
import 'package:cliplaza/pages/checkout.dart';
import 'package:cliplaza/pages/favourites.dart';
import 'package:cliplaza/pages/filters/index.dart';
import 'package:cliplaza/pages/filters/order_by.dart';
import 'package:cliplaza/pages/filters/price.dart';
import 'package:cliplaza/pages/filters/recommended.dart';
import 'package:cliplaza/pages/home.dart';
import 'package:cliplaza/pages/landing.dart';
import 'package:cliplaza/pages/login.dart';
import 'package:cliplaza/pages/profile/faq.dart';
import 'package:cliplaza/pages/profile/index.dart';
import 'package:cliplaza/pages/profile/payments_data.dart';
import 'package:cliplaza/pages/profile/personal_data.dart';
import 'package:cliplaza/pages/profile/security.dart';
import 'package:cliplaza/pages/register.dart';
import 'package:cliplaza/pages/show_product.dart';
import 'package:cliplaza/state/user.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);
  static String currentRoute = LandingPage.route;

  @override
  State<MainNavigator> createState() => MainNavigatorState();
}

class MainNavigatorState extends State<MainNavigator>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Add this class as an observer to listen for system events
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Remove this class as an observer when no longer needed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool showBottomBar = true;
  bool showAppBar = true;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _updateBottomBarVisibility(String? routeName) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          final List<String> routesToHideBottomBar = [
            '/example',
            LoginPage.route,
            LandingPage.route,
            RegisterPage.route,
            Chat.route
          ];
          showBottomBar = !routesToHideBottomBar.contains(routeName);
          final List<String> routesToHideAppBar = [
            'test',
            RegisterPage.route,
            LandingPage.route,
            LoginPage.route,
            MyCart.route,
            ShowProduct.route,
            PersonalDataPage.route,
            SecurityData.route,
            CheckoutPage.route,
            Chat.route,
            PaymentData.route,
            FilterPage.route,
            RecommendedPage.route,
            FilterByPrice.route,
            OrderByPage.route
          ];
          showAppBar = !routesToHideAppBar.contains(routeName);
        });
      }
    });
  }

  void toggleAppBar(bool isVisible) {
    setState(() {
      showAppBar = isVisible;
    });
  }

  int currentIndex = 0;
  void _onItemTapped(int index) {
    final navigator = navigatorKey.currentState;
    if (navigator == null) return;

    final currentRoute = MainNavigator.currentRoute;

    final routes = [
      HomePage.route,
      Chats.route,
      FavouritesPage.route,
      MyCart.route,
      PersonalProfilePage.route
    ];

    if (currentRoute == routes[index]) {
      return;
    }

    setState(() {
      currentIndex = index;
    });

    navigator.pushNamed(routes[index]);
  }

  List<String> pagesToAvoidPop = [
    RegisterPage.route,
    HomePage.route,
    LoginPage.route,
    LandingPage.route
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (popHandled) {
        if (pagesToAvoidPop.contains(MainNavigator.currentRoute)) {
          return;
        }
        navigatorKey.currentState?.pop((route) {
          _updateBottomBarVisibility(route.settings.name);
        });
      },
      child: SafeArea(
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: showAppBar
              ? CustomAppBar(
                  scaffoldKey: _scaffoldKey,
                  navigatorKey: navigatorKey,
                )
              : null,
          endDrawer: Drawer(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/CLIPLAZA scritta nera.png'),
                    InkWell(
                        onTap: () =>
                            _scaffoldKey.currentState!.closeEndDrawer(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset('assets/images/X.svg'),
                        ))
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState!.closeEndDrawer();
                    navigatorKey.currentState!.pushNamed(FavouritesPage.route,
                        arguments: {'args': 'pro'});
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF3884F9)),
                        child: SvgPicture.asset(
                          'assets/images/icona professionisti.svg',
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'PROFESSIONISTI',
                        style: TextStyle(
                            color: Color(0xFF3884F9),
                            fontSize: 17,
                            fontFamily: 'bold'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState!.closeDrawer();
                    navigatorKey.currentState!.pushNamed(FavouritesPage.route,
                        arguments: {'args': 'shop'});
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF5DCBA9)),
                        child: SvgPicture.asset(
                          'assets/images/icona shopping.svg',
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'SHOPPING',
                        style: TextStyle(
                            color: Color(0xFF5DCBA9),
                            fontSize: 17,
                            fontFamily: 'bold'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState!.closeDrawer();
                    navigatorKey.currentState!.pushNamed(FavouritesPage.route,
                        arguments: {'args': 'food'});
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFE3B957)),
                        child: SvgPicture.asset(
                          'assets/images/icona food.svg',
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'FOOD',
                        style: TextStyle(
                            color: Color(0xFFE3B957),
                            fontSize: 17,
                            fontFamily: 'bold'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Navigator(
            observers: [
              BottomNavBarObserver(updateVisibility: _updateBottomBarVisibility)
            ],
            key: navigatorKey,
            initialRoute: LandingPage.route,
            onGenerateRoute: (settings) {
              WidgetBuilder builder;
              switch (settings.name) {
                case '/': // Handle root route
                case LandingPage.route:
                  builder = (_) => const LandingPage();
                  break;
                case LoginPage.route:
                  builder = (_) => const LoginPage();
                  break;
                case RegisterPage.route:
                  builder = (_) => const RegisterPage();
                  break;
                case HomePage.route:
                  builder = (_) => const HomePage();
                  break;
                case FilterPage.route:
                  builder = (_) => const FilterPage();
                  break;
                case OrderByPage.route:
                  builder = (_) => const OrderByPage();
                  break;
                case FilterByPrice.route:
                  builder = (_) => const FilterByPrice();
                  break;
                case RecommendedPage.route:
                  builder = (_) => const RecommendedPage();
                  break;
                case Chats.route:
                  builder = (_) => const Chats();
                  break;
                case Chat.route:
                  builder = (_) => const Chat();
                  break;
                case FavouritesPage.route:
                  builder = (_) => const FavouritesPage();
                  break;
                case PersonalProfilePage.route:
                  builder = (_) => const PersonalProfilePage();
                  break;
                case MyCart.route:
                  builder = (_) => const MyCart();
                  break;
                case CheckoutPage.route:
                  builder = (_) => const CheckoutPage();
                  break;
                case ShowProduct.route:
                  builder = (_) => const ShowProduct();
                  break;
                case PersonalDataPage.route:
                  builder = (_) => const PersonalDataPage();
                  break;
                case PaymentData.route:
                  builder = (_) => const PaymentData();
                  break;
                case SecurityData.route:
                  builder = (_) => const SecurityData();
                  break;
                case FaqPage.route:
                  builder = (_) => const FaqPage();
                  break;
                default:
                  throw Exception('Invalid route: ${settings.name}');
              }
              return MaterialPageRoute(
                builder: builder,
                settings: settings,
              );
            },
          ),
          bottomNavigationBar: showBottomBar
              ? SizedBox(
                  height: 80,
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: currentIndex,
                    onTap: (index) => _onItemTapped(index),
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: MainNavigator.currentRoute == HomePage.route
                            ? SvgPicture.asset('assets/images/casa nera.svg')
                            : SvgPicture.asset('assets/images/icona casa.svg'),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: MainNavigator.currentRoute == Chats.route
                            ? SvgPicture.asset('assets/images/chat nero.svg')
                            : SvgPicture.asset(
                                'assets/images/icona messaggi.svg'),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: MainNavigator.currentRoute == FavouritesPage.route
                            ? SvgPicture.asset(
                                'assets/images/preferiti nero.svg')
                            : SvgPicture.asset(
                                'assets/images/Icon heart-empty.svg'),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            MainNavigator.currentRoute == MyCart.route
                                ? SvgPicture.asset(
                                    'assets/images/carrello nero.svg')
                                : SvgPicture.asset(
                                    'assets/images/icona carrello.svg'),
                            Positioned(
                              top: -5,
                              right: -6,
                              child: Obx(() => userState.value.cartItems.isEmpty
                                  ? const SizedBox.shrink()
                                  : Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFFDCE63)),
                                      width: 16,
                                      height: 16,
                                      child: Center(
                                        child: Text(
                                          userState.value.cartItems.length
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily: 'semibold',
                                              fontSize: 13,
                                              color: Color(0xFF171717)),
                                        ),
                                      ),
                                    )),
                            )
                          ],
                        ),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                          icon: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2,
                                      color: MainNavigator.currentRoute ==
                                              PersonalProfilePage.route
                                          ? const Color(0xFFA13BA7)
                                          : Colors.transparent)),
                              child: const CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/pexels-oziel-gómez-1755385.webp'),
                                  backgroundColor: Colors.black54)),
                          label: ''),
                    ],
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class BottomNavBarObserver extends NavigatorObserver {
  final Function(String?) updateVisibility;

  BottomNavBarObserver({required this.updateVisibility});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _updateVisibility(route);
    print(MainNavigator.currentRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _updateVisibility(previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _updateVisibility(newRoute);
  }

  void _updateVisibility(Route<dynamic>? route) {
    if (route is ModalRoute && route.settings.name == null) {
      return;
    }
    updateVisibility(route?.settings.name);
    MainNavigator.currentRoute = route?.settings.name ?? '/example';
  }
}
