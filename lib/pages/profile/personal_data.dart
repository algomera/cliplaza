import 'package:cliplaza/components/input.dart';
import 'package:flutter/material.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});
  static const route = 'user/profile/edit';
  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  TextEditingController nameController = TextEditingController(text: 'Susanna');
  TextEditingController surnameController =
      TextEditingController(text: 'Rossi');
  TextEditingController emailController =
      TextEditingController(text: 'susanna.rossi@gmail.com');
  TextEditingController addressController =
      TextEditingController(text: 'Via Giovanni Pacini');
  TextEditingController addressNumberController =
      TextEditingController(text: '30');
  TextEditingController capController = TextEditingController(text: '20131');
  TextEditingController cityController = TextEditingController(text: 'Milano');
  TextEditingController provinceController =
      TextEditingController(text: 'Milano');
  TextEditingController nationController =
      TextEditingController(text: 'Italia');
  TextEditingController passwordController =
      TextEditingController(text: 'asdasdasdasd');

  bool obscureText = true;
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
            'Dati personali',
            style: TextStyle(
                color: Color(0xFF0C0C0C), fontSize: 16, fontFamily: 'bold'),
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 36),
          Row(
            children: [
              Expanded(
                  child: CustomInput(
                      hintText: 'Nome', controller: nameController)),
              const SizedBox(width: 10),
              Expanded(
                  child: CustomInput(
                      hintText: 'Cognome', controller: surnameController))
            ],
          ),
          CustomInput(hintText: 'Email', controller: emailController),
          CustomInput(
            obscureText: obscureText,
            hintText: 'Password',
            controller: passwordController,
            type: TextInputType.visiblePassword,
            suffix: InkWell(
                onTap: () => setState(() => obscureText = !obscureText),
                child: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off)),
          ),
          CustomInput(hintText: 'Via', controller: addressController),
          Row(
            children: [
              Expanded(
                  child: CustomInput(
                      hintText: 'N. Civico',
                      controller: addressNumberController)),
              const SizedBox(width: 10),
              Expanded(
                  child:
                      CustomInput(hintText: 'Cap', controller: capController))
            ],
          ),
          CustomInput(hintText: 'Città', controller: cityController),
          CustomInput(hintText: 'Provincia', controller: provinceController),
          CustomInput(hintText: 'Nazione', controller: nationController),
        ]));
  }
}
