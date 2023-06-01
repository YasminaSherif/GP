import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';
Widget buildTextFormField({
  required String hintText,
  required bool obscureText,
  String? Function(String?)? validator,
  required void Function(String?) onSaved,
  required Icon icon,
  bool isSuffix = false,
})
{
  return Padding(
    padding: const EdgeInsets.only(left:15 ,right: 15),
    child: TextFormField(
      textAlign: TextAlign.right,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        prefixIcon: isSuffix ? null : icon,
        suffixIcon: isSuffix ? IconButton(onPressed: (){}, icon: icon) : null,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 0.7,
          ),
        ),
        hintText: hintText,

        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
