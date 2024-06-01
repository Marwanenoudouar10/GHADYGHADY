import 'package:flutter/material.dart';
import 'package:myapp/screens/login/signin/sign_in_screen.dart';
import 'package:myapp/screens/numberPhone/phone_number_screen.dart';
import 'package:myapp/widgets/button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2), // Flexible spacing at the top
              Image.asset(
                  'assets/images/imageStarted.png'), // Adjusted image position
              const SizedBox(height: 24), // Space between image and headline
              const Row(
                // Custom headline widget, now directly included
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Ghady Ghady',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins-ExtraLight',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Center(
                // Ensure the large text is centered
                child: Text(
                  'Connecting riders and drivers with a click. Together, let\'s explore the road ahead!',
                  textAlign: TextAlign.center, // Center text horizontally
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Poppins-ExtraLight',
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Button(
                text: 'Get Started',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PhoneNumberScreen()));
                },
                fontSize: 20.0,
                color: const Color(0xFFFF5700),
                colorText: Colors.white,
                border: 4,
              ),
              const Spacer(), // Flexible spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
