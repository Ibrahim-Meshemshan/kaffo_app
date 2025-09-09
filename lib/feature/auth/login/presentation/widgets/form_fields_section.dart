
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaffo/core/app_consts/app_validators.dart';
import 'package:kaffo/feature/auth/login/presentation/view_model/login_cubit.dart';

class FormFieldsSection extends StatefulWidget {
  const FormFieldsSection({super.key});

  @override
  State<FormFieldsSection> createState() => _FormFieldsSectionState();
}

class _FormFieldsSectionState extends State<FormFieldsSection> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          TextFormField(
            key: const ValueKey('emailField'),
            validator: (value) => AppValidators.validateEmail(value),
            controller: context.read<LoginCubit>().emailController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "context.loc.email",
              hintStyle: const TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.mail,color: Colors.white,size:40,) ,
             prefixIconColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            key: const ValueKey('passwordField'),
            validator: (value) => AppValidators.validatePassword(value),
            controller: context.read<LoginCubit>().passwordController,

            style: const TextStyle(color: Colors.white),
            obscureText: isObscure,
            decoration: InputDecoration(
              labelText:" context.loc.password",
              hintStyle: const TextStyle(color: Colors.white),
              suffixIcon: InkWell(
                onTap: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                child: const Icon(Icons.visibility_outlined),
              ),
              prefixIcon: Icon(Icons.lock,color: Colors.white,),
              prefixIconColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
