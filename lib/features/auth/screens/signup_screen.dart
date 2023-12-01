import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/features/auth/controller/auth_controller.dart';
import 'package:joga_junto/theme/pallete.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static String id = 'signup_screen';

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();

}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _profilePic = 'TextEditingController()';
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _cpf = TextEditingController();
  final _street = TextEditingController();
  final _houseNumber = TextEditingController();
  final _district = TextEditingController();
  final _cityState = 'TextEditingController()';
  final _statistics = 'TextEditingController()';
  // ignore: prefer_final_fields
  bool _saving = false;
  // ignore: prefer_final_fields
  List<String> _address = [];

  @override
  void dispose() {
    super.dispose();
  }

  void signUp(BuildContext context){
    ref.read(authControllerProvider).signUp(
      context,
      _profilePic, 
      _name.text, 
      _email.text, 
      _password.text, 
      _cpf.text, 
      _address, 
      _cityState, 
      _statistics, 
      0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Pallete.orangeColor,),
      body: LoadingOverlay(
        isLoading: _saving,
        child: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                    child: TextFormField(
                      controller: _cpf,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(),
                        ),
                        labelText: 'cpf',
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
                ],
              ),
            ),
          ),
        )
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Pallete.orangeColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
            )
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text(
              'Cadastrar',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}