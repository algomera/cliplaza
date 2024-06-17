import 'package:cliplaza/pages/cart.dart';
import 'package:cliplaza/pages/chat/index.dart';
import 'package:cliplaza/pages/favourites.dart';
import 'package:cliplaza/pages/home.dart';
import 'package:cliplaza/pages/profile/index.dart';
import 'package:cliplaza/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void _onItemTapped(int index) {
    if (userState.value.bottomNavIndex != index) {
      setState(() {
        userState.value.bottomNavIndex = index;
      });
      switch (index) {
        case 0:
          Navigator.pushNamed(context, HomePage.route);
          break;
        case 1:
          Navigator.pushNamed(context, Chats.route);
          break;
        case 2:
          Navigator.pushNamed(context, FavouritesPage.route);
          break;
        case 3:
          Navigator.pushNamed(context, MyCart.route);
          break;
        case 4:
          Navigator.pushNamed(context, PersonalProfilePage.route);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: userState.value.bottomNavIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: userState.value.bottomNavIndex == 0
                ? SvgPicture.asset('assets/images/casa nera.svg')
                : SvgPicture.asset('assets/images/icona casa.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: userState.value.bottomNavIndex == 1
                ? SvgPicture.asset('assets/images/chat nero.svg')
                : SvgPicture.asset('assets/images/icona messaggi.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: userState.value.bottomNavIndex == 2
                ? SvgPicture.asset('assets/images/preferiti nero.svg')
                : SvgPicture.asset('assets/images/Icon heart-empty.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: userState.value.bottomNavIndex == 3
                ? SvgPicture.asset('assets/images/carrello nero.svg')
                : SvgPicture.asset('assets/images/icona carrello.svg'),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: CircleAvatar(),
            label: '',
          ),
        ],
      ),
    );
  }
}
