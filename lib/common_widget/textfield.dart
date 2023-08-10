import 'package:project/const/import.dart';

Widget textform(
    {required String labeltext,
    required String hint,
    controller,
    validate,
    prefixIcon,
    suffixIcon,
    keyType}) {
  return TextFormField(
    controller: controller,
    validator: validate,
    keyboardType: keyType,
    decoration: InputDecoration(
        suffixIcon: Icon(
          suffixIcon,
          color: brownColor,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: brownColor,
        ),
        labelText: labeltext,
        labelStyle: TextStyle(color: Colors.purple, fontSize: 16),
        hintText: hint,
        disabledBorder: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        )),
  );
}
