import 'package:cliplaza/components/button.dart';
import 'package:cliplaza/components/input.dart';
import 'package:cliplaza/pages/home.dart';
import 'package:cliplaza/pages/register.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const route = 'login';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 40),
          Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('assets/images/X.svg'),
                  ))),
          const SizedBox(height: 20),

          SvgPicture.asset('assets/images/logo_viola.svg'),
          const SizedBox(height: 12),
          Image.asset('assets/images/CLIPLAZA scritta nera.png', height: 20),
          const SizedBox(height: 62),
          const Text('Accedi al tuo account',
              style: TextStyle(
                  color: Color(0xFF0C0C0C),
                  fontFamily: 'semibold',
                  fontSize: 15)),
          const SizedBox(height: 16),
          const CustomInput(
            hintText: 'Email',
            hintStyle: TextStyle(color: Color(0xFF171717), fontSize: 13),
          ),
          CustomInput(
            hintStyle: const TextStyle(color: Color(0xFF171717), fontSize: 13),
            obscureText: obscureText,
            controller: passwordController,
            type: TextInputType.visiblePassword,
            suffix: InkWell(
                onTap: () => setState(() => obscureText = !obscureText),
                child: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off)),
            hintText: 'Password',
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Password dimenticata?',
                  style: TextStyle(
                      color: Color(0xFF747474),
                      fontSize: 13,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF747474),
                      decorationThickness: 2),
                )),
          ),
          const SizedBox(height: 6),
          CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, HomePage.route);
              },
              center: const Text(
                'Avanti',
                style: TextStyle(
                    color: Colors.white, fontSize: 16, fontFamily: 'semibold'),
              ),
              bg: const Color(0xFFA13BA7)),
          const SizedBox(height: 42),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Expanded(
              //     child: Container(
              //         margin: const EdgeInsets.only(right: 10),
              //         height: .5,
              //         color: const Color(0xFFD1D1D1))),
              Text('Oppure', style: TextStyle(color: Color(0xFF747474))),
              // Expanded(
              //     child: Container(
              //         margin: const EdgeInsets.only(left: 10),
              //         height: .5,
              //         color: const Color(0xFFD1D1D1)))
            ],
          ),
          const SizedBox(height: 30),
          // const Text(
          //   'Accedi tramite social',
          //   style: TextStyle(
          //       color: Color(0xFF0C0C0C), fontSize: 16, fontFamily: 'semibold'),
          //   textAlign: TextAlign.center,
          // ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset('assets/images/apple.svg'),
            SvgPicture.asset('assets/images/google.svg'),
            SvgPicture.asset('assets/images/faceebook.svg'),
          ]),
          const SizedBox(height: 80),
          InkWell(
            onTap: () => Navigator.pushNamed(context, RegisterPage.route),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Non hai un account? ',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    TextSpan(
                      text: 'Registrati gratuitamente',
                      style: TextStyle(
                          color: Color(0xFFDC4CE3),
                          fontSize: 15,
                          fontFamily: 'bold'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
