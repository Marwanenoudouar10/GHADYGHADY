import 'package:flutter/material.dart';
import 'package:myapp/screens/login/signup/passenger/sign_up_passenger_screen.dart';
import 'package:myapp/screens/login/signup/driver/sign_up_driver_screen.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  Widget _buildUserTypeButton(
      BuildContext context, String userType, String iconPath) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        onPressed: () {
          if (userType == 'Passenger') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SignUpPassenger()));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpDriver()));
          }
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 11),
          side: const BorderSide(
            color: Color(0xFF444444),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              iconPath,
              width: 71,
              height: 35,
            ),
            const SizedBox(width: 30),
            Text(
              userType,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 87, 0, 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Are you a driver or a passenger?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Poppins-ExtraLight',
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              _buildUserTypeButton(
                  context, 'Passenger', 'assets/icons/driver_icon.png'),
              const SizedBox(height: 20),
              _buildUserTypeButton(
                  context, 'Driver', 'assets/icons/driver_icon.png'),
            ],
          ),
        ),
      ),
    );
  }
}
