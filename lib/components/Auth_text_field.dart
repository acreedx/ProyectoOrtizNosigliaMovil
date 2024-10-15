import 'package:flutter/material.dart';

class Auth_text_field extends StatelessWidget {
  final String text;
  final Icon icon;

  const Auth_text_field({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextField(
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.none,
          obscureText: false,
          keyboardType: TextInputType.name,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              focusColor: Colors.black26,
              fillColor: const Color.fromARGB(255, 247, 247, 247),
              filled: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Container(
                  child: icon,
                ),
              ),
              prefixIconColor: Colors.orange,
              hintText: "Nombre de Usuario",
              labelText: text,
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30),
              )),
        ),
      ),
    );
  }
}
