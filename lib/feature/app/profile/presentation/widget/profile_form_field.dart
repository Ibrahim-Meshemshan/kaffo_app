import 'package:flutter/material.dart';
import 'package:kaffo/core/app_consts/app_validators.dart';

class ProfileFormField extends StatelessWidget {
  String title;
  String labelText;
  TextEditingController filedText;
  bool isEnable;
   ProfileFormField({super.key,required this.title,required this.labelText,required this.filedText,required  this.isEnable});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch,mainAxisSize: MainAxisSize.min,children: [
      Text(title),
      TextFormField(
        validator: (value) => AppValidators.validateFullName(value),
        controller: filedText,enabled: isEnable,
        decoration: InputDecoration(
          hintText: labelText
        ),
      ),
    ],);
  }
}
