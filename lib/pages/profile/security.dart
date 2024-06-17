import 'package:cliplaza/components/input.dart';
import 'package:cliplaza/helpers/password_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecurityData extends StatefulWidget {
  const SecurityData({super.key});
  static const route = 'user/edit/security';
  @override
  State<SecurityData> createState() => _SecurityDataState();
}

class _SecurityDataState extends State<SecurityData> {
  TextEditingController passwordController =
      TextEditingController(text: 'Password123!');
  bool obscureText = true;

  final _formKey = GlobalKey<FormState>(); // Form key for validation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: const Row(children: [
            Icon(Icons.keyboard_arrow_left_rounded),
            Text(
              'Indietro',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF171717)),
            )
          ]),
        ),
        const SizedBox(height: 16),
        const Text(
          'Sicurezza',
          style: TextStyle(
              color: Color(0xFF0C0C0C), fontSize: 16, fontFamily: 'bold'),
        ),
        const SizedBox(height: 16),
        Form(
          key: _formKey,
          child: CustomInput(
            errorMaxLines: 2,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Questo campo è obbligatorio.';
              } else if (!PasswordValidator.isPasswordValid(value)) {
                return 'La password deve contenere almeno 6 caratteri, un numero, un carattere speciale, una lettera minuscola e una maiuscola.';
              }
              return null;
            },
            obscureText: obscureText,
            controller: passwordController,
            type: TextInputType.visiblePassword,
            suffix: InkWell(
                onTap: () => setState(() => obscureText = !obscureText),
                child: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off)),
            hintText: 'Password',
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password cambiata!')),
              );
            }
          },
          child: const Text(
            'Cambia Password',
            style: TextStyle(
                color: Color(0xFFA13BA7),
                fontSize: 13,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFA13BA7),
                decorationThickness: 2),
            textAlign: TextAlign.end,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis at vestibulum nulla. Ut viverra eu quam quis porttitor. Nam lobortis libero et enim vulputate, in pulvinar orci bibendum. Aliquam sodales convallis porta. Praesent varius semper dolor sit amet efficitur. Vestibulum posuere diam tortor, sed sollicitudin justo pretium id.',
          style: TextStyle(color: Color(0xFF3A3A3A)),
        ),
        const SizedBox(height: 8),
        const Text(
          'Informativa Privacy',
          style: TextStyle(
              color: Color(0xFFA13BA7),
              fontSize: 13,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFFA13BA7),
              decorationThickness: 2),
        ),
        const SizedBox(height: 16),
        const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis at vestibulum nulla. Ut viverra eu quam quis porttitor. Nam lobortis libero et enim vulputate, in pulvinar orci bibendum. Aliquam sodales convallis porta. Praesent varius semper dolor sit amet efficitur. Vestibulum posuere diam tortor, sed sollicitudin justo pretium id.',
          style: TextStyle(color: Color(0xFF3A3A3A)),
        ),
        const SizedBox(height: 8),
        const Text(
          'Elimina account',
          style: TextStyle(
              color: Color(0xFFA13BA7),
              fontSize: 13,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFFA13BA7),
              decorationThickness: 2),
        ),
      ],
    ));
  }
}
