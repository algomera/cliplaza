import 'package:cliplaza/components/button.dart';
import 'package:cliplaza/pages/landing.dart';
import 'package:cliplaza/pages/login.dart';
import 'package:cliplaza/pages/profile/faq.dart';
import 'package:cliplaza/pages/profile/payments_data.dart';
import 'package:cliplaza/pages/profile/personal_data.dart';
import 'package:cliplaza/pages/profile/security.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersonalProfilePage extends StatefulWidget {
  const PersonalProfilePage({super.key});
  static const route = 'user/profile';
  @override
  State<PersonalProfilePage> createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  @override
  Widget build(BuildContext context2) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const SizedBox(height: 28),
        Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const SizedBox(
                  width: 64,
                  height: 64,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/images/pexels-oziel-gómez-1755385.webp'),
                  )),
              Positioned(
                bottom: 4,
                right: -8,
                child: Container(
                  width: 23,
                  height: 23,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFA13BA7),
                    border: Border.all(color: Colors.white, width: 1.2),
                  ),
                  child: const Center(
                    child: Icon(Icons.edit_outlined,
                        color: Colors.white, size: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const ProfileTile(
            leading: Icon(Icons.person),
            route: PersonalDataPage.route,
            title: 'Dati personali'),
        ProfileTile(
            leading: SvgPicture.asset('assets/images/icona dati pagamento.svg'),
            route: PaymentData.route,
            title: 'Dati pagamento'),
        ProfileTile(
            leading: SvgPicture.asset('assets/images/icona sicurezza.svg'),
            route: SecurityData.route,
            title: 'Sicurezza'),
        ProfileTile(
            leading: SvgPicture.asset('assets/images/icona faq.svg'),
            route: FaqPage.route,
            title: 'Faq'),
        ProfileTile(
            leading: SvgPicture.asset('assets/images/icona esci.svg'),
            route: LoginPage.route,
            onTap: () => showAdaptiveDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Logout',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      CustomButton(
                          onPressed: () {},
                          center: const Text(
                            'Indietro',
                            style: TextStyle(color: Colors.white),
                          ),
                          bg: const Color(0xFFA13BA7)),
                      CustomButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context2, LandingPage.route);
                          },
                          center: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                          bg: Colors.red),
                    ],
                  );
                }),
            title: 'Esci')
      ],
    ));
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {super.key,
      required this.leading,
      required this.route,
      required this.title,
      this.onTap});
  final String route;
  final Widget leading;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.pushNamed(context, route),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(6)),
        child: Row(
          children: [
            SizedBox(width: 30, child: leading),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(
                  color: Color(0xFF0C0C0C), fontFamily: 'semibold'),
            ),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_right_rounded),
          ],
        ),
      ),
    );
  }
}
