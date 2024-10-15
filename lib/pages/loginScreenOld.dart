import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/loginForm.dart';

class LoginScreenOld extends StatefulWidget {
  const LoginScreenOld({super.key});

  @override
  State<LoginScreenOld> createState() => _LoginScreenOldState();
}

class _LoginScreenOldState extends State<LoginScreenOld> {
  final _formKey = GlobalKey<FormState>();
  final String _username = '';
  final String _password = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Aquí podrías añadir la lógica para autenticar al usuario
      print('Usuario: $_username');
      print('Contraseña: $_password');
      // Simulación de redirección después del login exitoso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Iniciando sesión...')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Spacer(),
                const Text(
                  'Bienvenido al centro Ortiz Nosiglia', // Texto por defecto en lugar de AppText
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent
                  ),
                ),
                const SizedBox(height: 10), // Config.spaceSmall eliminado
                const Text(
                  'Iniciar Sesión', // Texto por defecto en lugar de AppText
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10), // Espacio por defecto
                // LoginForm o SignUpForm se reemplaza por un Container
                Container(
                  color: Colors.grey.shade200,
                  width: double.infinity,
                  child: const LoginForm(),
                ),
                const SizedBox(height: 10), 
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}