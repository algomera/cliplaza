import 'package:get/get.dart';

final userState = UserState().obs;

class UserState {
  int bottomNavIndex = 0;
  bool firstTime = true;
  void changeIndex(int index) {
    bottomNavIndex = index;
    userState.refresh();
  }

  List chats = [
    {'name': 'Zara Milano'},
    {'name': 'Pizzium Milano'},
    {'name': 'User'},
  ];

  List cartItems = [
    {
      'company': 'Zara Test delete',
      'image': '4174170250_2_1_1.webp',
      'name': 'Maglietta',
      'subtitle': 'Taglia: S',
      'price': '19,99',
      'quantity': 3
    },
    {
      'company': 'Zara',
      'image': '4174170250_2_1_1.webp',
      'name': 'Maglietta',
      'subtitle': 'Taglia: S',
      'price': '19,99',
      'quantity': 3
    },
    {
      'company': 'Zara',
      'image': '4174170250_2_1_1.webp',
      'name': 'Maglietta',
      'subtitle': 'Taglia: S',
      'price': '19,99',
      'quantity': 3
    }
  ].obs;

  List laterCartItems = [
    {
      'company': 'Pizzium',
      'image': 'saahil-khatkhate-kfDsMDyX1K0-unsplash.webp',
      'name': 'Pizza Margherita',
      'subtitle': 'Familiare',
      'price': '19,99',
      'quantity': 3
    },
    {
      'company': 'Zara',
      'image': '4174170250_2_1_1.webp',
      'name': 'Maglietta',
      'subtitle': 'S',
      'price': '19,99',
      'quantity': 3
    },
    {
      'company': 'Zara',
      'image': '4174170250_2_1_1.webp',
      'name': 'Maglietta',
      'subtitle': 'S',
      'price': '19,99',
      'quantity': 3
    }
  ].obs;

  List liked = [];
}
