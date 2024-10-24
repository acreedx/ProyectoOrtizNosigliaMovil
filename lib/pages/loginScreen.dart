import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/Auth_text_field.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/Password_text_field.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/menuScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/login.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/JwtTokenHandler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Flexible(
          child: Text(
            "Bienvenido al centro Ortiz Nosiglia",
            style: GoogleFonts.inter(
              color: Colors.black87,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0,
            ),
            textAlign: TextAlign.center,
            maxLines: 3, // Ajusta el número máximo de líneas
            overflow:
                TextOverflow.ellipsis, // Maneja el desbordamiento del texto
          ),
        ),
        toolbarHeight: 110,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<bool>(
        future: isUserLogged(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const MenuScreen()),
              );
            });
            return Container();
          }
          return _body(context);
        }
      )
    );
  }
}
Widget _body(context) {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Column(children: [
      const Spacer(),
      Auth_text_field(
          text: "Ingrese tu Usuario",
          icon: const Icon(Icons.person),
          controller: usernameController
      ),
      const SizedBox(
        height: 5,
      ),
      //Text field Password
      PasswordTextField(
        text: "Ingresa tu Contraseña",
        icon: const Icon(Icons.lock),
        controller: passwordController,
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ElevatedButton(
          onPressed: () {
            // Perform verification or other actions here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: GestureDetector(
            onTap: () async {
              String username = usernameController.text;
              String password = passwordController.text;
              _handleLogin(username, password, context);
            },
            child: Text(
              "Iniciar Sesión",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No tienes una cuenta? ",
            style:
            GoogleFonts.poppins(fontSize: 15.sp, color: Colors.black87),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const Placeholder()));
            },
            child: Text(
              "Crear cuenta",
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      const Spacer(),
    ]),
  );
}
void _handleLogin(String username, String password, BuildContext context) async {
  try {
    if(username == null || username.isEmpty || password == '' || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rellene los campos necesarios'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    var token = await login(username, password);
    var decodedToken = await getTokenInfo();
    print(decodedToken['access_token']['id']);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bienvenido de nuevo'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pushReplacement(
      context,
      PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const MenuScreen()),
    );
  } catch (e) {
    print('$e');
    String errorMessage;
    if(e is Exception) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } else {
      errorMessage = 'Error inesperado';
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );
  }
}
