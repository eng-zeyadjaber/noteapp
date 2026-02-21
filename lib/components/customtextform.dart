import 'package:flutter/material.dart';

class CustTextFormSign extends StatelessWidget {
  final String hint;
  final TextEditingController mycontroller;
  const CustTextFormSign({
    super.key,
    required this.hint,
    required this.mycontroller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      child: TextFormField(
        controller: mycontroller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          hintText: hint,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
