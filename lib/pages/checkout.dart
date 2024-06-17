import 'package:cliplaza/components/button.dart';
import 'package:cliplaza/components/input.dart';
import 'package:cliplaza/pages/home.dart';
import 'package:cliplaza/state/user.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});
  static const route = 'checkout';
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int currentStep = 0;

  late List steps = [const AddressStep(), const PaymentSection(), thirdStep()];
  late Widget step = steps[currentStep];
  late String buttonText =
      'Continua : ${calculateTotalPrice().toStringAsFixed(2)}€';

  Color getBorderColor(int index) {
    // if (currentStep == index) {
    //   return Colors.transparent;
    // } else if (currentStep >= (index + 1)) {
    //   return const Color(0xFF7A5DCB);
    // }
    if (currentStep == index) {
      return const Color(0xFF7A5DCB);
    }
    return const Color(0xFFD1D1D1);
  }

  double calculateTotalPrice() {
    double total = 0.0;

    for (var item in userState.value.cartItems) {
      double price = double.parse(item['price'].replaceAll(',', '.'));
      int quantity = item['quantity'];

      total += price * quantity;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 65)),
          SliverToBoxAdapter(
            child: Row(
              children: [
                const SizedBox(width: 80),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: getBorderColor(0)),
                          color: currentStep == 0
                              ? const Color(0xFF7A5DCB)
                              : Colors.transparent,
                          shape: BoxShape.circle),
                      child: currentStep > 0
                          ? const Icon(
                              Icons.check,
                              size: 12,
                              color: Color(0xFF7A5DCB),
                            )
                          : Text(
                              '1',
                              style: TextStyle(
                                  color: currentStep == 0
                                      ? Colors.white
                                      : const Color(0xFFD1D1D1),
                                  fontSize: 13),
                            ),
                    ),
                    Positioned(
                        left: -10,
                        bottom: -20,
                        child: Text(
                          'I tuoi dati',
                          style: TextStyle(
                              fontSize: 12,
                              color: currentStep >= 0
                                  ? const Color(0xFF7A5DCB)
                                  : const Color(0xFFD1D1D1)),
                        ))
                  ],
                ),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 1,
                  color: currentStep == 0
                      ? const Color(0xFFD1D1D1)
                      : const Color(0xFF7A5DCB),
                )),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: getBorderColor(1)),
                          color: currentStep == 1
                              ? const Color(0xFF7A5DCB)
                              : Colors.transparent,
                          shape: BoxShape.circle),
                      child: currentStep > 1
                          ? const Icon(
                              Icons.check,
                              size: 12,
                              color: Color(0xFF7A5DCB),
                            )
                          : Text(
                              '2',
                              style: TextStyle(
                                  color: currentStep == 1
                                      ? Colors.white
                                      : const Color(0xFFD1D1D1),
                                  fontSize: 13),
                            ),
                    ),
                    Positioned(
                        left: -15,
                        bottom: -20,
                        child: Text('Pagamento',
                            style: TextStyle(
                                fontSize: 12,
                                color: currentStep >= 1
                                    ? const Color(0xFF7A5DCB)
                                    : const Color(0xFFD1D1D1))))
                  ],
                ),
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 1,
                        color: currentStep == 2
                            ? const Color(0xFF7A5DCB)
                            : const Color(0xFFD1D1D1))),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: currentStep == 2
                                  ? Colors.transparent
                                  : const Color(0xFFD1D1D1)),
                          color: currentStep == 2
                              ? const Color(0xFF7A5DCB)
                              : Colors.transparent,
                          shape: BoxShape.circle),
                      child: Text(
                        '3',
                        style: TextStyle(
                            color: currentStep == 2
                                ? Colors.white
                                : const Color(0xFFD1D1D1),
                            fontSize: 13),
                      ),
                    ),
                    Positioned(
                        left: -2,
                        bottom: -20,
                        child: Text('Fatto!',
                            style: TextStyle(
                                fontSize: 12,
                                color: currentStep == 2
                                    ? const Color(0xFF7A5DCB)
                                    : const Color(0xFFD1D1D1))))
                  ],
                ),
                const SizedBox(width: 80),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: 16, vertical: currentStep == 2 ? 20 : 30),
            sliver: SliverToBoxAdapter(child: step),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Riepilogo ordine',
                style: TextStyle(
                    fontSize: 16, fontFamily: 'bold', color: Color(0xFF0C0C0C)),
              ),
            ),
          ),
          SliverList.builder(
              itemCount: userState.value.cartItems.length,
              itemBuilder: (context, index) {
                final product = userState.value.cartItems[index];
                return Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFD1D1D1),
                            width: .6,
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/${product['image']}',
                                  ),
                                )),
                          ),
                          const SizedBox(width: 10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'],
                                  style: const TextStyle(
                                      color: Color(0xFF0C0C0C),
                                      fontFamily: 'semibold',
                                      fontSize: 15),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product['subtitle'] ?? '',
                                  style: const TextStyle(
                                      color: Color(0xFF747474), fontSize: 13),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Quantità: ${product['quantity']}',
                                  style: const TextStyle(
                                      color: Color(0xFF747474), fontSize: 13),
                                ),
                                const SizedBox(height: 10),
                              ]),
                        ],
                      ),
                      // const SizedBox(height: 12),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Text(
                        product['price'],
                        style: const TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontFamily: 'semibold',
                            fontSize: 15),
                        // textAlign: TextAlign.end,
                      ),
                    )
                  ],
                );
              }),
          currentStep == 2
              ? const SliverToBoxAdapter()
              : SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Totale',
                          style:
                              TextStyle(fontSize: 17, color: Color(0xFF747474)),
                        ),
                        Text(
                          '${calculateTotalPrice().toStringAsFixed(2)}€',
                          style: const TextStyle(
                              fontSize: 17,
                              color: Color(0xFF0C0C0C),
                              fontFamily: 'bold'),
                        )
                      ],
                    ),
                  ),
                )
        ],
      ),
      bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
        CustomButton(
            //  EdgeInsets.only(bottom: 27, left: 16, right: 16, top: 20)
            marginX: currentStep == 2 ? 99 : 16,
            marginY: 20,
            paddingY: 12,
            onPressed: () {
              if (currentStep == 2) {
                Navigator.pushNamed(context, HomePage.route);
                userState.value.cartItems.clear();
                return;
              }
              setState(() {
                currentStep++;
                step = steps[currentStep];
                buttonText =
                    (currentStep == 2) ? 'Torna alla home' : 'Paga ora';
              });
            },
            center: Text(
              buttonText,
              style: const TextStyle(
                  fontSize: 16, fontFamily: 'semibold', color: Colors.white),
            ),
            bg: currentStep == 2
                ? const Color(0xFF171717)
                : const Color(0xFF7A5DCB)),
      ]),
    );
  }
}

Widget thirdStep() => const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          'Ordine completato!',
          style: TextStyle(
              color: Color(0xFF0C0C0C), fontSize: 16, fontFamily: 'bold'),
        ),
        SizedBox(height: 12),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis at vestibulum nulla. Ut viverra eu quam quis porttitor.',
          style: TextStyle(color: Color(0xFF3A3A3A), fontSize: 14),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.watch_later_outlined, color: Color(0xFF7A5DCB)),
            SizedBox(width: 8),
            Text(
              'Consegna il 20/09/24 alle 17:00',
              style: TextStyle(color: Color(0xFF7A5DCB)),
            )
          ],
        )
      ],
    );

class AddressStep extends StatefulWidget {
  const AddressStep({super.key});

  @override
  State<AddressStep> createState() => _AddressStepState();
}

class _AddressStepState extends State<AddressStep> {
  List addresses = [
    {
      'via': 'Via Giovanni Pacini, 30',
      'cap': '20131',
      'city': 'Milano, Italia'
    },
  ];
  int _selectedAddressIndex = 0;
  final _formKey = GlobalKey<FormState>();

  Future _showAddAddressDialog(BuildContext context) async {
    TextEditingController addressController = TextEditingController();
    TextEditingController addressNumberController = TextEditingController();
    TextEditingController capController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController provinceController = TextEditingController();
    TextEditingController nationController = TextEditingController();
    return await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0.0)),
      ),
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Scaffold(
          body: Form(
            key: _formKey, // Assigning the GlobalKey to the Form
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                const SizedBox(height: 30),
                const Text(
                  'Aggiungi un indirizzo',
                  style: TextStyle(
                      fontFamily: 'semibold',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF171717)),
                ),
                const SizedBox(height: 12),
                CustomInput(
                  hintText: 'Via',
                  controller: addressController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Questo campo è obbligatorio.';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomInput(
                        hintText: 'N. Civico',
                        type: TextInputType.number,
                        controller: addressNumberController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Questo campo è obbligatorio.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomInput(
                        hintText: 'Cap',
                        type: TextInputType.number,
                        controller: capController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Questo campo è obbligatorio.';
                          } else if (value.length != 5) {
                            return 'Il CAP deve essere composto da 5 cifre.';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
                CustomInput(
                  hintText: 'Città',
                  controller: cityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Questo campo è obbligatorio.';
                    }
                    return null;
                  },
                ),
                CustomInput(
                  hintText: 'Provincia',
                  controller: provinceController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Questo campo è obbligatorio.';
                    }
                    return null;
                  },
                ),
                CustomInput(
                  hintText: 'Nazione',
                  controller: nationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Questo campo è obbligatorio.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                marginX: 20,
                marginY: 10,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newAddress = {
                      'via': addressController.text,
                      'cap': capController.text,
                      'city': cityController.text,
                    };
                    Navigator.of(context).pop(newAddress);
                  }
                },
                center: const Text(
                  "Salva",
                  style: TextStyle(color: Colors.white),
                ),
                bg: const Color(0xFFA13BA7),
              ),
            ],
          ),
        );
      },
    );
  }

  TextEditingController nameController = TextEditingController(text: 'Susanna');
  TextEditingController surnameController =
      TextEditingController(text: 'Rossi');
  TextEditingController emailController =
      TextEditingController(text: 'susanna.rossi@gmail.com');
  TextEditingController cellController =
      TextEditingController(text: '340 2738193');
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'I tuoi dati',
          style: TextStyle(
              color: Color(0xFF0C0C0C), fontSize: 16, fontFamily: 'bold'),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child:
                    CustomInput(hintText: 'Nome', controller: nameController)),
            const SizedBox(width: 10),
            Expanded(
                child: CustomInput(
                    hintText: 'Cognome', controller: surnameController))
          ],
        ),
        CustomInput(hintText: 'Email', controller: emailController),
        CustomInput(hintText: 'Cellulare', controller: cellController),
        ListView.builder(
          shrinkWrap: true,
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD1D1D1)),
                  borderRadius: BorderRadius.circular(5)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                leading: Transform.scale(
                  scale: 1.5,
                  child: Radio<int>(
                    value: index,
                    groupValue: _selectedAddressIndex,
                    onChanged: (value) {
                      setState(() {
                        _selectedAddressIndex = value!;
                      });
                    },
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addresses[index]['via'],
                      style: const TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontFamily: 'semibold',
                          fontSize: 13),
                    ),
                    Text(
                      addresses[index]['cap'],
                      style: const TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontFamily: 'semibold',
                          fontSize: 13),
                    ),
                    Text(
                      addresses[index]['city'],
                      style: const TextStyle(
                          color: Color(0xFF0C0C0C),
                          fontFamily: 'semibold',
                          fontSize: 13),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        InkWell(
          onTap: () async {
            final newAddress = await _showAddAddressDialog(context);
            if (newAddress != null && newAddress is! Function) {
              setState(() {
                addresses.add(newAddress);
                print(addresses);
              });
              // Check if it's not a function
              // Handle the new address
            } else {
              // Handle the case where the dialog was dismissed without adding an address
            }
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: const Row(
              children: [
                Icon(
                  Icons.add,
                  color: Color(0xFFE3B957),
                ),
                Text(
                  'Aggiungi indirizzo',
                  style: TextStyle(
                      color: Color(0xFFE3B957),
                      fontSize: 14,
                      fontFamily: 'semibold'),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class PaymentSection extends StatefulWidget {
  const PaymentSection({super.key});

  @override
  State<PaymentSection> createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  int _selectedMethod = 0;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedMethod = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Metodo di pagamento',
          style: TextStyle(
              color: Color(0xFF0C0C0C), fontSize: 16, fontFamily: 'bold'),
        ),
        const SizedBox(height: 16),
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
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Row(
              children: [
                Transform.scale(
                  scale: 1.5, // Scale up the radio button
                  child: SizedBox(
                    width: 24,
                    child: Radio<int>(
                      activeColor: const Color(0xFF7A5DCB),
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
                    bottom:
                        BorderSide(width: .5, color: const Color(0xFFD1D1D1)))),
            child: const Column(
              children: [
                CustomInput(hintText: 'Titolare della carta'),
                CustomInput(hintText: 'Numero della carta'),
                CustomInput(hintText: 'Data di scadenza'),
                CustomInput(hintText: 'Codice di sicurezza'),
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
    );
  }
}
