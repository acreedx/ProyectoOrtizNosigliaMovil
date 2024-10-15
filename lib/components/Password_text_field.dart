import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final String text;
  final Icon icon;
  const PasswordTextField({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        controller: _passController,
        keyboardType: TextInputType.visiblePassword,
        textAlign: TextAlign.start,
        textInputAction: TextInputAction.none,
        obscureText: obsecurePass,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          focusColor: Colors.black26,
          fillColor: const Color.fromARGB(255, 247, 247, 247),
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: widget.icon,
          ),
          prefixIconColor: Colors.orange,
          hintText: "Contraseña",
          labelText: widget.text,
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
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
                    )),
        ),
      ),
    ));
  }
}
