import 'package:cliplaza/pages/filters/index.dart';
import 'package:cliplaza/state/user.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, required this.scaffoldKey, required this.navigatorKey});
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<NavigatorState> navigatorKey;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset('assets/images/CLIPLAZA scritta nera.png'),
          const SizedBox(width: 10),
          Obx(() => userState.value.hasConnection
              ? const SizedBox.shrink()
              : const Icon(
                  Icons.signal_wifi_connected_no_internet_4_rounded,
                  color: Colors.red,
                )),
          const SizedBox(width: 10),
          Obx(() => userState.value.airplaneMode
              ? const Icon(
                  Icons.airplanemode_on_outlined,
                  color: Colors.red,
                )
              : const SizedBox.shrink()),
        ],
      ),
      actions: [
        InkWell(
            onTap: () =>
                widget.navigatorKey.currentState!.pushNamed(FilterPage.route),
            child: SvgPicture.asset('assets/images/Icon ionic-ios-search.svg')),
        const SizedBox(width: 20),
        InkWell(
            onTap: () => widget.scaffoldKey.currentState!.openEndDrawer(),
            child: SvgPicture.asset('assets/images/Icon ionic-ios-menu.svg')),
        const SizedBox(width: 17)
      ],
    );
  }
}
