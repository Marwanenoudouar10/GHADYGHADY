import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/screens/home/home_screen.dart';
import 'package:myapp/screens/login/signup/driver/sign_up_documents_first_screen.dart';
import 'package:myapp/screens/login/signup/driver/sign_up_driver_services.dart';
import 'package:myapp/widgets/button.dart';
import 'package:myapp/widgets/dynamic_input_list.dart';
import 'package:myapp/widgets/go_to.dart';
import 'package:myapp/widgets/text_input_config.dart';
import 'package:myapp/widgets/top_bar.dart';

class SignUpDriver extends StatefulWidget {
  const SignUpDriver({super.key});

  @override
  State<SignUpDriver> createState() => _SignUpDriverState();
}

class _SignUpDriverState extends State<SignUpDriver> {
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  SignUpDriverServices signUpHandler = SignUpDriverServices();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width *
                0.078), // 8% padding on each side
        child: Form(
          key: _globalFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TopBar(text: 'Hi!', secondText: 'Create a new Account'),
              const SizedBox(height: 10),
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              DynamicInputList(
                inputConfigs: [
                  TextInputConfig(
                      labelText: 'Full name', controller: _usernameController),
                  TextInputConfig(
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController),
                  TextInputConfig(
                      labelText: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      controller: _phoneController),
                  TextInputConfig(
                      labelText: 'Password',
                      icon: Icons.lock,
                      isObsecure: true,
                      controller: _passwordController),
                ],
              ),
              const SizedBox(height: 20),
              Button(
                text: 'Next',
                onPressed: () {
                  if (_globalFormKey.currentState!.validate()) {
                    signUpHandler
                        .handleSignUp(_emailController.text.toString().trim(),
                            _passwordController.text.toString())
                        .then((value) => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SignUpFirstDocuments(signInInfos: [
                                            _usernameController.text,
                                            _phoneController.text
                                          ])))
                            })
                        // ignore: body_might_complete_normally_catch_error
                        .catchError((e) {
                      Fluttertoast.showToast(msg: e!.message);
                    });
                  }
                },
                fontSize: 20,
                color: const Color(0xFFFF5700),
                colorText: Colors.white,
              ),
              const SizedBox(height: 30),
              const GoTo(
                text: 'You have an Account?   ',
                secondText: 'Sign In',
                linkTo: '/SignIn',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome!'),
      ),
    );
  }
}
