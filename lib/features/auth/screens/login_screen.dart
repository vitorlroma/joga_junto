import 'package:flutter/material.dart';
import 'package:joga_junto/core/common/signin_google_button.dart';
import 'package:joga_junto/theme/pallete.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();
  // ignore: prefer_final_fields
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Pallete.orangeColor,),
      body: LoadingOverlay(
        isLoading: _saving,
        child: SafeArea(
          child: Padding(
          padding: const EdgeInsets.only(top: 100),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  const Text(
                    'titulo',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: TextFormField(
                      controller: email,
                      decoration:const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o email corretamente!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: TextFormField(
                      controller: senha,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
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
                    padding: const EdgeInsets.all(24.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {

                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: (_saving)
                            ? [
                                const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ]
                            : [
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    'actionButton',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                      ),
                    ),
                  ),
                  const SignInGoogle(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('toggleButton'),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}