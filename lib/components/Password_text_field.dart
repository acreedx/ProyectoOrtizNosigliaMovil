import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final String text;
  final Icon icon;
  final TextEditingController controller; // Add this line

  const PasswordTextField({super.key, required this.text, required this.icon, required this.controller}); // Update constructor

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obsecurePass = true;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            controller: widget.controller, // Set the controller here
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