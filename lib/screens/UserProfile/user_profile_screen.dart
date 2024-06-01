import 'package:flutter/material.dart';
import 'package:myapp/screens/login/signup/driver/driver_model.dart';

class UserProfileScreen extends StatelessWidget {
  final DriverModel driver;

  const UserProfileScreen({Key? key, required this.driver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(driver.fullName ?? 'Driver Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${driver.email}'),
            Text('Phone Number: ${driver.phoneNumber}'),
            Text('Motorbike Brand: ${driver.marqueMotor}'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
