// ignore_for_file: invalid_return_type_for_catch_error

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/screens/Destination/destination_screen.dart';
import 'package:myapp/screens/home/home_screen.dart';
import 'package:myapp/screens/login/signin/sign_in_services.dart';
import 'package:myapp/widgets/button.dart';
import 'package:myapp/widgets/dynamic_input_list.dart';
import 'package:myapp/widgets/go_to.dart';
import 'package:myapp/widgets/text_input_config.dart';
import 'package:myapp/widgets/top_bar.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  var authHandler = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0, // Optional: remove elevation for a flatter appearance
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        // Allows the keyboard to not push layout up
        padding: const EdgeInsets.symmetric(
            horizontal: 24), // Consistent horizontal padding

        child: Form(
          key: _globalFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TopBar(
                text: 'Welcome!',
                secondText: 'Sign in to continue',
              ),
              const SizedBox(height: 20),
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              DynamicInputList(
                inputConfigs: [
                  TextInputConfig(
                      labelText: 'Email',
                      controller:
                          _emailController), // Assuming it's email rather than full name
                  TextInputConfig(
                      labelText: 'Password',
                      icon: Icons.lock,
                      isObsecure: true,
                      controller: _passwordController),
                ],
              ),
              const SizedBox(height: 20),
              Button(
                text: 'Sign In',
                onPressed: () {
                  if (_globalFormKey.currentState!.validate()) {
                    authHandler
                        .handleSignInEmail(
                            _emailController.text, _passwordController.text)
                        .then((user) {
                      if (user != null) {
                        Fluttertoast.showToast(msg: "Login Successful");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DestinationScreen()));
                      }
                      // ignore: avoid_print
                    }).catchError((e) => print('une erreur se produit! $e'));
                  }
                },
                fontSize: 20.0,
                color: const Color(0xFFFF5700),
                colorText: Colors.white,
              ),
              const SizedBox(height: 10),
              Button(
                text: 'Continue with Google',
                onPressed: () async {
                  authHandler.signInWithGoogle().then((credential) {
                    if (credential != null) {
                      Fluttertoast.showToast(msg: "Login Successful");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    }
                  });
                },
                fontSize: 16.0,
                color: Colors.white,
                colorText: Colors.black,
                iconAsset: 'assets/icons/google.ico',
                iconSize: 30,
              ),
              const SizedBox(height: 40),
              const GoTo(
                text: 'Don\'t have an account?   ',
                secondText: 'Sign Up',
                linkTo: '/UserType',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
