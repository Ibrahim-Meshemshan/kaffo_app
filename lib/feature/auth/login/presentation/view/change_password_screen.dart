// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kaffo/core/di/di.dart';
// import 'package:kaffo/feature/auth/login/data/model/signup_request/signup_request.dart';
// import 'package:kaffo/feature/auth/login/presentation/view_model/signup_cubit.dart';
// import 'package:kaffo/core/app_consts/app_validators.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider(
//         create: (_) => getIt<LoginCubit>()..login(LoginRequest()),
//         child: Builder(
//           builder: (context) {
//             final loginCubit = context.read<LoginCubit>();
//
//             return Stack(
//               children: [
//                 // Fullscreen background image
//                 SizedBox.expand(
//                   child: Image.asset(
//                     'assets/images/login.png', // <-- your uploaded image
//
//                   ),
//                 ),
//
//                 // Optional overlay to make text readable
//                 Container(
//                   color: Colors.black.withOpacity(0.4),
//                 ),
//
//                 // Login form
//                 Column(mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Hey There!",
//                       style: TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     const Text(
//                       "Welcome back to KAFU",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black54,
//                       ),
//                     ),
//                     Center(
//                       child: SingleChildScrollView(
//                         padding: const EdgeInsets.symmetric(horizontal: 24),
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(24),
//                           ),
//                           elevation: 8,
//                           color: Colors.white70,
//                           child: Padding(
//                             padding: const EdgeInsets.all(24),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//
//                                 const SizedBox(height: 24),
//                                 TextFormField(
//                                   controller: loginCubit.emailController,
//                                   validator: (value) => AppValidators.validateEmail(value),
//                                   decoration: const InputDecoration(
//                                     prefixIcon: Icon(Icons.email),
//                                     hintText: "Email",
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.all(Radius.circular(12)),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 TextFormField(
//                                   controller: loginCubit.passwordController,
//                                   obscureText: true,
//                                   validator: (value) => AppValidators.validatePassword(value),
//                                   decoration: InputDecoration(
//                                     prefixIcon: const Icon(Icons.lock),
//                                     hintText: "Password",
//                                     border: const OutlineInputBorder(
//                                       borderRadius: BorderRadius.all(Radius.circular(12)),
//                                     ),
//                                     suffixIcon: IconButton(
//                                       icon: const Icon(Icons.visibility),
//                                       onPressed: () {
//                                         // Optional: toggle password visibility
//                                       },
//                                     ),
//                                   ),
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {
//                           // TODO: Navigate to forgot password
//                         },
//                         child: const Text("Forgot Password?",style: TextStyle(color: Colors.white),),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white70,foregroundColor: Colors.black,
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         onPressed: () {
//                           loginCubit.login(LoginRequest(
//                             email: loginCubit.emailController.text,
//                             password: loginCubit.passwordController.text,
//                           ));
//                         },
//                         child: const Text(
//                           "Login",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Don't have an account? "),
//                         GestureDetector(
//                           onTap: () {
//                             // TODO: Navigate to register
//                           },
//                           child: const Text(
//                             "Register",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaffo/core/di/di.dart';
import 'package:kaffo/core/utils/status.dart';
import 'package:kaffo/core/widgets/main_scaffold.dart';
import 'package:kaffo/feature/auth/login/data/model/login_request/login_request.dart';
import 'package:kaffo/feature/auth/login/presentation/view_model/login_cubit.dart';
import 'package:kaffo/core/app_consts/app_validators.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: BlocProvider(
        create: (_) => getIt<LoginCubit>()..login(LoginRequest()),
        child: Builder(
          builder: (context) {
            final loginCubit = context.read<LoginCubit>();

            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
               color: Color(0xFFC5C5C5),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                      "تغيير كلمة المرور",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: loginCubit.emailController,
                        validator: (value) => AppValidators.validateEmail(value),
                        decoration: const InputDecoration(
                          hintText: "كلمة المرور الحالية",
                          hintStyle: TextStyle(
                            fontFamily: "Cairo",

                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: loginCubit.emailController,
                        validator: (value) => AppValidators.validateEmail(value),
                        decoration: const InputDecoration(
                          hintText: "كلمة المرور الجديدة",
                          hintStyle: TextStyle(
                            fontFamily: "Cairo",

                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: loginCubit.emailController,
                        validator: (value) => AppValidators.validateEmail(value),
                        decoration: const InputDecoration(
                          hintText: "تأكييد كلمة المرور ",
                          hintStyle: TextStyle(
                            fontFamily: "Cairo",

                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,foregroundColor:Colors.white ,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            loginCubit.login(LoginRequest(
                              email: loginCubit.emailController.text,
                              password: loginCubit.passwordController.text,
                            ));
                          },
                          child: const Text(
                            "حفظ التغيير",
                            style: TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 18),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
