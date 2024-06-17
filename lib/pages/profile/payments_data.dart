import 'package:cliplaza/components/input.dart';
import 'package:flutter/material.dart';

class PaymentData extends StatefulWidget {
  const PaymentData({super.key});
  static const route = 'user/edit/payments';
  @override
  State<PaymentData> createState() => _PaymentDataState();
}

// class CreditCardNumberFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     String text = newValue.text.replaceAll(RegExp(r'\D'), '');
//     String formatted = '';

//     for (int i = 0; i < text.length; i++) {
//       if (i != 0 && i % 4 == 0) {
//         formatted += ' ';
//       }
//       formatted += (i < 4) ? text[i] : '**';
//     }

//     return TextEditingValue(
//       text: formatted,
//       selection: TextSelection.collapsed(offset: formatted.length),
//     );
//   }
// }

class _PaymentDataState extends State<PaymentData> {
  int _selectedMethod = 0;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedMethod = value!;
    });
  }

  TextEditingController nameController =
      TextEditingController(text: 'Susanna Rossi');
  TextEditingController cardController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
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
          'Dati pagamento',
          style: TextStyle(
              color: Color(0xFF0C0C0C), fontSize: 16, fontFamily: 'bold'),
        ),
        InkWell(
          onTap: () => _handleRadioValueChange(0),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: .5,
                        color: _selectedMethod == 0
                            ? Colors.transparent
                            : const Color(0xFFD1D1D1)))),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Transform.scale(
                  scale: 1.5, // Scale up the radio button
                  child: SizedBox(
                    width: 24,
                    child: Radio<int>(
                      activeColor: const Color(0xFFA13BA7),
                      value: 0,
                      groupValue: _selectedMethod,
                      onChanged: _handleRadioValueChange,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Carta di credito o di debito',
                  style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontFamily: 'semibold',
                      fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        if (_selectedMethod == 0)
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: .5, color: Color(0xFFD1D1D1)))),
            child: Column(
              children: [
                const CustomInput(hintText: 'Titolare della carta'),
                CustomInput(
                  controller: cardController,
                  type: TextInputType.number,
                  hintText: 'Numero della carta',
                ),
                const CustomInput(hintText: 'Data di scadenza'),
                const CustomInput(hintText: 'Codice di sicurezza'),
              ],
            ),
          ),
        InkWell(
          onTap: () => _handleRadioValueChange(1),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: _selectedMethod == 1
                            ? Colors.transparent
                            : const Color(0xFFD1D1D1)))),
            child: Row(
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: SizedBox(
                    width: 24,
                    child: Radio<int>(
                      activeColor: const Color(0xFFA13BA7),
                      value: 1,
                      groupValue: _selectedMethod,
                      onChanged: _handleRadioValueChange,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Apple Pay',
                  style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontFamily: 'semibold',
                      fontSize: 15),
                ),
                const Spacer(),
                Container(
                  width: 60,
                  height: 35,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    color: const Color(0xFFF3F3F3),
                  ),
                  child: Center(
                    child: Image.asset('assets/images/applepay.png'),
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => _handleRadioValueChange(2),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: _selectedMethod == 2
                            ? Colors.transparent
                            : const Color(0xFFD1D1D1)))),
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Transform.scale(
                  scale: 1.5, // Scale up the radio button
                  child: SizedBox(
                    width: 24,
                    child: Radio<int>(
                      activeColor: const Color(0xFFA13BA7),
                      value: 2,
                      groupValue: _selectedMethod,
                      onChanged: _handleRadioValueChange,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Google Pay',
                  style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontFamily: 'semibold',
                      fontSize: 15),
                ),
                const Spacer(),
                Container(
                  width: 60,
                  height: 35,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    color: const Color(0xFFF3F3F3),
                  ),
                  child: Center(
                    child: Image.asset('assets/images/googlepay.png'),
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => _handleRadioValueChange(3),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: _selectedMethod == 3
                            ? Colors.transparent
                            : const Color(0xFFD1D1D1)))),
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Transform.scale(
                  scale: 1.5, // Scale up the radio button
                  child: SizedBox(
                    width: 24,
                    child: Radio<int>(
                      activeColor: const Color(0xFFA13BA7),
                      value: 3,
                      groupValue: _selectedMethod,
                      onChanged: _handleRadioValueChange,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Klarna',
                  style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontFamily: 'semibold',
                      fontSize: 15),
                ),
                const Spacer(),
                Container(
                  width: 60,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                  ),
                  child: Center(
                    child: Image.asset('assets/images/klarna.png'),
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => _handleRadioValueChange(4),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: _selectedMethod == 4
                            ? Colors.transparent
                            : const Color(0xFFD1D1D1)))),
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: SizedBox(
                    width: 24,
                    child: Radio<int>(
                      activeColor: const Color(0xFFA13BA7),
                      value: 4,
                      groupValue: _selectedMethod,
                      onChanged: _handleRadioValueChange,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'PayPal',
                  style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontFamily: 'semibold',
                      fontSize: 15),
                ),
                const Spacer(),
                Container(
                  width: 60,
                  height: 35,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    color: const Color(0xFFF3F3F3),
                  ),
                  child: Center(
                    child: Image.asset('assets/images/PayPal.png'),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
