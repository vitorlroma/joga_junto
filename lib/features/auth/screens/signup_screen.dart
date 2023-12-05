import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/common/loader.dart';
import 'package:joga_junto/features/auth/controller/auth_controller.dart';
import 'package:joga_junto/features/auth/screens/login_screen.dart';
import 'package:joga_junto/theme/pallete.dart';

const formPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 12);

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'signup_screen';

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _profilePic = 'TextEditingController()';
  final _name = TextEditingController();
  final _surname = TextEditingController();
  final _cpf = TextEditingController();
  final _country = TextEditingController();
  final _state = TextEditingController();
  final _city = TextEditingController();
  final _district = TextEditingController();
  final _cep = TextEditingController();
  final _street = TextEditingController();
  final _houseNumber = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _passwordConfirm = TextEditingController();
  int currentStep = 0;
  // ignore: prefer_final_fields
  List<String> _address = [];

  @override
  void dispose() {
    super.dispose();
  }

  void signUp(BuildContext context) {
    ref.read(authControllerProvider.notifier).signUp(
        context,
        _profilePic,
        _name.text,
        _email.text,
        _password.text,
        _cpf.text,
        _address,
    );
  }

  @override
  Widget build(BuildContext context,) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: ()  {
            Navigator.popAndPushNamed(context, LoginScreen.id);
          },
        ),
        backgroundColor: Pallete.orangeColor,
      ),
      body: isLoading
        ? const Loader() 
        :Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
        child: Form(
          key: _formKey,
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepCancel: () => currentStep == 0
                ? null
                : setState(() {
                    currentStep -= 1;
                  }),
            onStepContinue: () {
              bool isLastStep = (currentStep == _getSteps().length - 1);
              if (isLastStep) {
              } else {
                setState(() {
                  currentStep += 1;
                });
              }
            },
            onStepTapped: (step) => setState(() {
              currentStep = step;
            }),
            steps: _getSteps(),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: formPadding,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {}
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Pallete.orangeColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )
          ),
          child: const Padding(
            padding: formPadding,
            child: Text(
              'Cadastrar',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  List<Step> _getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text('Dados Pessoais',
          style: TextStyle(fontSize: 12,
          ),
        ),
        content: Column(
          children: [
            Padding(
              padding: formPadding,
              child: TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'Nome',
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o nome corretamente!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: formPadding,
              child: TextFormField(
                controller: _surname,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'Sobrenome',
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o sobrenome corretamente!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: formPadding,
              child: TextFormField(
                controller: _cpf,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'CPF',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o CPF corretamente!';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text('Endereço',
          style: TextStyle(fontSize: 12,),
        ),
        content: Column(
          children: [
            Padding(
              padding: formPadding,
              child: TextFormField(
                controller: _country,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'País',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o país corretamente!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: formPadding,
              child: TextFormField(
                controller: _state,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'Estado',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o estado corretamente!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: formPadding,
              child: TextFormField(
                controller: _city,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'Cidade',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o cidade corretamente!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: formPadding,
              child: TextFormField(
                controller: _district,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'Bairro',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o bairro corretamente!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: formPadding,
              child: TextFormField(
                controller: _cep,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'CEP',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o CEP corretamente!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: formPadding,
              child: TextFormField(
                controller: _street,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'Rua',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe a rua corretamente!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: formPadding,
              child: TextFormField(
                controller: _houseNumber,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'Nº da casa',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o número corretamente!';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text('Conta',
          style: TextStyle(fontSize: 12,),
        ),
        content: Column(
          children: [
            Padding(
              padding: formPadding,
              child: TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'E-mail',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o e-mail corretamente!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: formPadding,
              child: TextFormField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'Senha',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informa sua senha!';
                  } else if (value.length < 6) {
                    return 'Sua senha deve ter no mínimo 6 caracteres';
                  } else if (value.toString() != _passwordConfirm.text) {
                    return 'As senhas devem ser iguais';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: formPadding,
              child: TextFormField(
                controller: _passwordConfirm,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                  labelText: 'Confirme sua senha',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informa sua senha!';
                  } else if (value.toString() != _password.text) {
                    return 'As senhas devem ser iguais';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
