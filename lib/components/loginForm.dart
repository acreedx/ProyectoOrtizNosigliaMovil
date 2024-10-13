import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.blue,
            decoration: const InputDecoration(
              hintText: 'Nombre de Usuario',
              labelText: 'Usuario',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 16.0), // Espaciado entre los campos
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Colors.blue,
            obscureText: obsecurePass,
            decoration: InputDecoration(
                hintText: 'Contraseña',
                labelText: 'Contraseña',
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecurePass = !obsecurePass;
                      });
                    },
                    icon: obsecurePass
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            color: Colors.blue,
                          ))),
          ),
          const SizedBox(height: 16.0), // Espaciado entre el campo y el botón
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print('Usuario: ${_emailController.text}');
                print('Contraseña: ${_passController.text}');
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50), // Ancho completo
            ),
            child: const Text('Iniciar Sesión'),
          ),
        ],
      ),
    );
  }
}