import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/common/common_style.dart';
import 'package:joga_junto/core/common/loader.dart';
import 'package:joga_junto/features/auth/controller/auth_controller.dart';
import 'package:joga_junto/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

const formPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 12);

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final List<GlobalKey<FormState>> _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];
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
  
  void navigateToLoginScreen(BuildContext context) {
    Routemaster.of(context).push('/');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void signUp(BuildContext context) {
    ref.read(authControllerProvider.notifier).signUp(
        context,
        _email.text,
        _password.text,
    );
  }

  @override
  Widget build(BuildContext context,) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: ()  {
            navigateToLoginScreen(context);
          },
        ),
        backgroundColor: Pallete.orangeColor,
      ),
      body: isLoading
        ? const Loader() 
        :Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
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
            bool formValidation = (_formKeys[currentStep].currentState!.validate());
            isLastStep
            ? null
            : setState(() {
                if(formValidation && isLastStep){

                } else if (formValidation && isLastStep==false) {
                  currentStep += 1;
                } else {
                  currentStep = 0;
                }
              });
          },
          onStepTapped: (step) => setState(() {
            currentStep = step;
          }),
          steps: _getSteps(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: formPadding,
        child: ElevatedButton(
          onPressed: () {
            if (_formKeys.every((element) => true)) {}
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
        content: Form(
          key: _formKeys[0],
          child: Column(
            children: [
              Padding(
                padding: formPadding,
                child: TextFormField(
                  controller: _name,
                  decoration: CommonStyle.textFieldStyle(
                    labelText:'Nome', 
                    hintText: 'Insira seu nome'
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
                  decoration: CommonStyle.textFieldStyle(
                    labelText:'Sobrenome', 
                    hintText: 'Insira seu sobrenome'
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
                  decoration: CommonStyle.textFieldStyle(
                    labelText:'CPF', 
                    hintText: 'Insira seu CPF'
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
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text('Endereço',
          style: TextStyle(fontSize: 12,),
        ),
        content: Form(
          key: _formKeys[1],
          child: Column(
            children: [
              Padding(
                padding: formPadding,
                child: TextFormField(
                  controller: _country,
                  decoration: CommonStyle.textFieldStyle(
                    labelText:'País', 
                    hintText: 'Insira seu país'
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
                  decoration: CommonStyle.textFieldStyle(
                    labelText:'Estado', 
                    hintText: 'Insira seu estado'
                  ),
                  keyboardType: TextInputType.text,
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
                  decoration: CommonStyle.textFieldStyle(
                    labelText:'Cidade', 
                    hintText: 'Insira sua cidade'
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe a cidade corretamente!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: formPadding,
                child: TextFormField(
                  controller: _district,
                  decoration: CommonStyle.textFieldStyle(
                    labelText:'Bairro', 
                    hintText: 'Insira seu bairro'
                  ),
                  keyboardType: TextInputType.text,
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
                  decoration: CommonStyle.textFieldStyle(
                    labelText:'CEP', 
                    hintText: 'Insira seu CEP'
                  ),
                  keyboardType: TextInputType.number,
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
                  decoration: CommonStyle.textFieldStyle(
                    labelText:'Rua', 
                    hintText: 'Insira sua rua'
                  ),
                  keyboardType: TextInputType.streetAddress,
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
                  decoration: CommonStyle.textFieldStyle(
                    labelText:'Nº da casa', 
                    hintText: 'Nº da casa'
                  ),
                  keyboardType: TextInputType.number,
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
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text('Conta',
          style: TextStyle(fontSize: 12,),
        ),
        content: Form(
          key: _formKeys[2],
          child: Column(
            children: [
              Padding(
                padding: formPadding,
                child: TextFormField(
                  controller: _email,
                  decoration: CommonStyle.textFieldStyle(
                    labelText:'E-mail', 
                    hintText: 'Informe seu e-mail'
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
                  decoration: CommonStyle.textFieldStyle(
                    labelText:'Senha', 
                    hintText: 'Informe sua senha'
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
                  decoration: CommonStyle.textFieldStyle(
                    labelText:'Confirme sua senha', 
                    hintText: 'Repita a senha'
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
      ),
    ];
  }
}
