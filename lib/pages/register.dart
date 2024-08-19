import 'package:cliplaza/components/button.dart';
import 'package:cliplaza/components/input.dart';
import 'package:cliplaza/components/interessi_card.dart';
import 'package:cliplaza/components/loader.dart';
import 'package:cliplaza/helpers/password_formatter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const route = 'register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double progress = 0.0;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  int currentFormIndex = 0;
  bool loading = false;
  String title = 'Iniziamo...';
  List selectedInterests = [];
  List selectedServices = [];
  late List<Widget> forms;
  late Widget content;
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cognomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController viaController = TextEditingController();
  final TextEditingController numeroCivicoController = TextEditingController();
  final TextEditingController capController = TextEditingController();
  final TextEditingController cittaController = TextEditingController();
  final TextEditingController provinciaController = TextEditingController();
  final TextEditingController nazioneController = TextEditingController();
  final TextEditingController cellulareController = TextEditingController();

  @override
  void initState() {
    super.initState();
    forms = [
      Form1(
        formKey: _formKey,
        nomeController: nomeController,
        cognomeController: cognomeController,
        emailController: emailController,
        passwordController: passwordController,
        cellulareController: cellulareController,
      ),
      AddressForm(
          formKey: _formKey2,
          viaController: viaController,
          numeroCivicoController: numeroCivicoController,
          capController: capController,
          cittaController: cittaController,
          provinciaController: provinciaController,
          nazioneController: nazioneController),
      Form2(selectedInterests: selectedInterests),
      Form3(selectedServices: selectedServices),
      Form4(selectedInterests: selectedInterests),
      Form5(selectedInterests: selectedInterests)
    ];
    content = forms[currentFormIndex];
  }

//incrementa la barra del progresso viola del 25% se lo step è validato
  void incrementProgress() {
    setState(() {
      progress += 0.25;
      if (progress > 1) {
        progress = 1;
      }
    });
  }

//decrementa la barra del progresso viola del 25% se lo step è validato
  void decrementProgress() {
    setState(() {
      progress -= 0.25;
      if (progress < 0) {
        progress = 0;
      }
    });
  }

//aggiorna il titolo della registrazione basato sullo step corrente
  void updateContent(int index) {
    setState(() {
      currentFormIndex = index;
      content = forms[currentFormIndex];
      switch (currentFormIndex) {
        case 1:
          title = 'Conosciamoci...';
          break;
        case 2:
          title = 'Approfondiamo...';
          break;
        case 3:
          title = 'Ancora una...';
          break;
        case 4:
          title = 'Abbiamo concluso...';
          break;
        default:
          title = 'Iniziamo...';
          break;
      }
    });
  }

//funzione di handle e validazione dei vari form per questo widget
  void handleNext() {
    if (currentFormIndex == 0 && !_formKey.currentState!.validate()) {
      return;
    }
    if (currentFormIndex == 1 && !_formKey2.currentState!.validate()) {
      return;
    }
    if (currentFormIndex == forms.length - 1) {
      setState(() {
        loading = true;
      });
      return;
    }
    incrementProgress();
    updateContent(currentFormIndex + 1);
  }

//handle del back button in alto a sinistra
//se ci troviamo al primo step, torna alla pagina precedente
//altrimenti decrementa di 1 lo step
  void handleBack() {
    if (currentFormIndex == 0) {
      Navigator.pop(context);
      return;
    }
    decrementProgress();
    updateContent(currentFormIndex - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const RegistrationLoader()
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: handleBack,
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF0C0C0C),
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 18),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF1FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(5),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      height: 5,
                      width: MediaQuery.of(context).size.width * progress,
                      decoration: BoxDecoration(
                        color: const Color(0xFFA13BA7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
                content,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 130, vertical: 40),
                  child: CustomButton(
                    onPressed: handleNext,
                    center: const Text(
                      "Avanti",
                      style: TextStyle(color: Colors.white),
                    ),
                    bg: const Color(0xFFA13BA7),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
    );
  }
}

class Form1 extends StatefulWidget {
  const Form1(
      {super.key,
      required this.formKey,
      required this.nomeController,
      required this.cognomeController,
      required this.emailController,
      required this.passwordController,
      required this.cellulareController});

  final GlobalKey formKey;
  final TextEditingController nomeController;
  final TextEditingController cognomeController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final TextEditingController cellulareController;
  @override
  State<Form1> createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          const Text(
            'Inserici i tuoi dati',
            style: TextStyle(
                color: Color(0xFF0C0C0C), fontSize: 16, fontFamily: 'semibold'),
          ),
          const SizedBox(height: 16),
          Center(
            child: DottedBorder(
                strokeWidth: 1.2,
                color: const Color(0xFFD1D1D1),
                borderType: BorderType.Circle,
                dashPattern: const [3, 5],
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      color: Color(0xFFE4B9E6),
                    ),
                  ),
                )),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomInput(
                  controller: widget.nomeController,
                  hintText: 'Nome',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Per favore inserisci il nome';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomInput(
                  controller: widget.cognomeController,
                  hintText: 'Cognome',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Per favore inserisci il cognome';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          CustomInput(
            controller: widget.emailController,
            type: TextInputType.emailAddress,
            hintText: 'Email',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Per favore inserisci l\'email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Per favore inserisci un\'email valida';
              }
              return null;
            },
          ),
          CustomInput(
            controller: widget.cellulareController,
            type: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            hintText: 'Cellulare',
            maxLength: 10,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Per favore inserisci il numero di telefono';
              }
              if (value.length < 6) {
                return 'il numero deve contenere almeno 10 numeri';
              }
              return null;
            },
          ),
          CustomInput(
            controller: widget.passwordController,
            obscureText: obscureText,
            hintText: 'Password',
            suffix: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: obscureText
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Per favore inserisci la password';
              } else if (!PasswordValidator.isPasswordValid(value)) {
                return 'La password deve contenere almeno 6 caratteri, un numero, un carattere speciale, una lettera minuscola e una maiuscola.';
              }
              return null;
            },
            errorMaxLines: 3,
          ),
        ],
      ),
    );
  }
}

class AddressForm extends StatelessWidget {
  const AddressForm(
      {super.key,
      required this.viaController,
      required this.numeroCivicoController,
      required this.capController,
      required this.cittaController,
      required this.provinciaController,
      required this.nazioneController,
      required this.formKey});
  final TextEditingController viaController;
  final TextEditingController numeroCivicoController;
  final TextEditingController capController;
  final TextEditingController cittaController;
  final TextEditingController provinciaController;
  final TextEditingController nazioneController;
  final GlobalKey formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          const Text(
            'Inserici il tuo indirizzo',
            style: TextStyle(
                color: Color(0xFF0C0C0C), fontSize: 16, fontFamily: 'semibold'),
          ),
          const SizedBox(height: 16),
          CustomInput(
            controller: viaController,
            hintText: 'Via',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Per favore inserisci la via';
              }
              return null;
            },
          ),
          Row(
            children: [
              Expanded(
                child: CustomInput(
                  controller: numeroCivicoController,
                  type: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  hintText: 'N. Civico',
                  maxLength: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Per favore inserisci il numero civico';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomInput(
                  controller: capController,
                  type: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 5,
                  hintText: 'Cap',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Per favore inserisci il CAP';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          CustomInput(
            controller: cittaController,
            hintText: 'Città',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Per favore inserisci la città';
              }
              return null;
            },
          ),
          CustomInput(
            controller: provinciaController,
            hintText: 'Provincia',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Per favore inserisci la provincia';
              }
              return null;
            },
          ),
          CustomInput(
            controller: nazioneController,
            hintText: 'Nazione',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Per favore inserisci la nazione';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class Form2 extends StatefulWidget {
  const Form2({super.key, required this.selectedInterests});
  final List selectedInterests;
  @override
  State<Form2> createState() => _Form2State();
}

class _Form2State extends State<Form2> {
  void addOrRemoveToList(list, item) =>
      setState(() => list.contains(item) ? list.remove(item) : list.add(item));
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        const Text(
          'Seleziona i tuoi interessi',
          style: TextStyle(
              color: Color(0xFF0C0C0C),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: InteressiCard(
                  condition:
                      widget.selectedInterests.contains('Professionisti'),
                  onTap: () => addOrRemoveToList(
                      widget.selectedInterests, 'Professionisti'),
                  image: 'assets/images/AdobeStock_228965780_Preview.webp',
                  title: 'Professionisti'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InteressiCard(
                  condition: widget.selectedInterests.contains('Shopping'),
                  onTap: () =>
                      addOrRemoveToList(widget.selectedInterests, 'Shopping'),
                  image: 'assets/images/AdobeStock_333810258.webp',
                  title: 'Shopping'),
            )
          ],
        ),
        const SizedBox(height: 16),
        InteressiCard(
            condition: widget.selectedInterests.contains('Food'),
            onTap: () => addOrRemoveToList(widget.selectedInterests, 'Food'),
            image: 'assets/images/AdobeStock_109039496.webp',
            title: 'Food')
      ],
    );
  }
}

class Form3 extends StatefulWidget {
  const Form3({super.key, required this.selectedServices});
  final List selectedServices;
  @override
  State<Form3> createState() => _Form3State();
}

class _Form3State extends State<Form3> {
  void addOrRemoveToList(list, item) =>
      setState(() => list.contains(item) ? list.remove(item) : list.add(item));
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        const Text(
          'Quali servizi preferisci',
          style: TextStyle(
              color: Color(0xFF0C0C0C),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: InteressiCard(
                  condition: widget.selectedServices.contains('Immobiliari'),
                  onTap: () =>
                      addOrRemoveToList(widget.selectedServices, 'Immobiliari'),
                  image: 'assets/images/AdobeStock_319415634.webp',
                  title: 'Immobiliari'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InteressiCard(
                  condition: widget.selectedServices.contains('Turistici'),
                  onTap: () =>
                      addOrRemoveToList(widget.selectedServices, 'Turistici'),
                  image: 'assets/images/AdobeStock_275668773.webp',
                  title: 'Turistici'),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: InteressiCard(
                  condition: widget.selectedServices.contains('Green'),
                  onTap: () =>
                      addOrRemoveToList(widget.selectedServices, 'Green'),
                  image: 'assets/images/AdobeStock_367128539.webp',
                  title: 'Green'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InteressiCard(
                  condition: widget.selectedServices.contains('Idraulici'),
                  onTap: () =>
                      addOrRemoveToList(widget.selectedServices, 'Idraulici'),
                  image: 'assets/images/AdobeStock_129568081.webp',
                  title: 'Idraulici'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: InteressiCard(
                  condition: widget.selectedServices.contains('Psicologi'),
                  onTap: () =>
                      addOrRemoveToList(widget.selectedServices, 'Psicologi'),
                  image: 'assets/images/AdobeStock_481431172_Preview.webp',
                  title: 'Psicologi'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InteressiCard(
                  condition: widget.selectedServices.contains('Terapisti'),
                  onTap: () =>
                      addOrRemoveToList(widget.selectedServices, 'Terapisti'),
                  image: 'assets/images/AdobeStock_228965780_Preview.webp',
                  title: 'Terapisti'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        InteressiCard(
            condition: widget.selectedServices.contains('Consulenti'),
            onTap: () =>
                addOrRemoveToList(widget.selectedServices, 'Consulenti'),
            image: 'assets/images/AdobeStock_647100544_Preview.webp',
            title: 'Consulenti')
      ],
    );
  }
}

class Form4 extends StatefulWidget {
  const Form4({super.key, required this.selectedInterests});
  final List selectedInterests;
  @override
  State<Form4> createState() => _Form4State();
}

class _Form4State extends State<Form4> {
  void addOrRemoveToList(list, item) =>
      setState(() => list.contains(item) ? list.remove(item) : list.add(item));
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        const Text(
          'Cosa ti piace di più',
          style: TextStyle(
              color: Color(0xFF0C0C0C),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: InteressiCard(
                  condition:
                      widget.selectedInterests.contains('Articoli sportivi'),
                  onTap: () => addOrRemoveToList(
                      widget.selectedInterests, 'Articoli sportivi'),
                  image: 'assets/images/AdobeStock_533222663.webp',
                  title: 'Articoli sportivi'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InteressiCard(
                  condition: widget.selectedInterests.contains('Collezionismo'),
                  onTap: () => addOrRemoveToList(
                      widget.selectedInterests, 'Collezionismo'),
                  image: 'assets/images/AdobeStock_394274351_Preview.webp',
                  title: 'Collezionismo'),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: InteressiCard(
                  condition: widget.selectedInterests.contains('Shopping'),
                  onTap: () =>
                      addOrRemoveToList(widget.selectedInterests, 'Shopping'),
                  image: 'assets/images/AdobeStock_333810258.webp',
                  title: 'Shopping'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InteressiCard(
                  condition: widget.selectedInterests.contains('Lusso'),
                  onTap: () =>
                      addOrRemoveToList(widget.selectedInterests, 'Lusso'),
                  image: 'assets/images/AdobeStock_236082850.webp',
                  title: 'Lusso'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        InteressiCard(
            condition: widget.selectedInterests.contains('Telefonia'),
            onTap: () =>
                addOrRemoveToList(widget.selectedInterests, 'Telefonia'),
            image: 'assets/images/AdobeStock_429015029_Preview.webp',
            title: 'Telefonia')
      ],
    );
  }
}

class Form5 extends StatefulWidget {
  const Form5({super.key, required this.selectedInterests});
  final List selectedInterests;

  @override
  State<Form5> createState() => _Form5State();
}

class _Form5State extends State<Form5> {
  void addOrRemoveToList(list, item) =>
      setState(() => list.contains(item) ? list.remove(item) : list.add(item));
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        const Text(
          'Cosa ti piace di più',
          style: TextStyle(
              color: Color(0xFF0C0C0C),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: InteressiCard(
                  condition: widget.selectedInterests.contains('Lorem1'),
                  onTap: () =>
                      addOrRemoveToList(widget.selectedInterests, 'Lorem1'),
                  image: 'assets/images/AdobeStock_22307550.webp',
                  title: 'Lorem1'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InteressiCard(
                  condition: widget.selectedInterests.contains('Lorem2'),
                  onTap: () =>
                      addOrRemoveToList(widget.selectedInterests, 'Lorem2'),
                  image: 'assets/images/AdobeStock_539909881.webp',
                  title: 'Lorem2'),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: InteressiCard(
                  condition: widget.selectedInterests.contains('Lorem3'),
                  onTap: () =>
                      addOrRemoveToList(widget.selectedInterests, 'Lorem3'),
                  image: 'assets/images/AdobeStock_46015742.webp',
                  title: 'Lorem3'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InteressiCard(
                  condition: widget.selectedInterests.contains('Lorem4'),
                  onTap: () =>
                      addOrRemoveToList(widget.selectedInterests, 'Lorem4'),
                  image: 'assets/images/AdobeStock_109039496.webp',
                  title: 'Lorem4'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        InteressiCard(
            condition: widget.selectedInterests.contains('Lorem5'),
            onTap: () => addOrRemoveToList(widget.selectedInterests, 'Lorem5'),
            image: 'assets/images/AdobeStock_109039496.webp',
            title: 'Lorem5')
      ],
    );
  }
}
