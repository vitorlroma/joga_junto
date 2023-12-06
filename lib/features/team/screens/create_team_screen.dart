import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/common/common_style.dart';

class CreateTeamScreen extends ConsumerStatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends ConsumerState<CreateTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar equipe!'),
      ),
      body: Padding(
        padding: bodyPading,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: formFieldPadding,
                child: TextFormField(
                  controller: _name,
                  decoration: CommonStyle.textFieldStyle(
                    labelText:'Nome da equipe', 
                    hintText: 'Insira o nome da equipe'
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o nome da equipe corretamente!';
                    }
                    return null;
                  },
                  maxLength: 21,
                ),
              ),
              Padding(
                padding: buttonPadding,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                    }
                  },
                  style: CommonStyle.buttonStyle(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Text(
                      'Criar equipe',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}