import 'package:flutter/material.dart';
import 'package:myapp/screens/Commande/command_screen.dart';
import 'package:myapp/screens/Destination/destination_screen.dart';
import 'package:myapp/screens/MapScreen/map_screen.dart';
import 'package:myapp/screens/home/home_screen.dart';
import 'package:myapp/screens/login/signup/driver/sign_up_driver_screen.dart';
import 'package:myapp/screens/login/signup/passenger/sign_up_passenger_screen.dart';
import 'package:myapp/screens/presentation/introduction_screen.dart';
import 'package:myapp/screens/presentation/splash_screen.dart';
import 'package:myapp/screens/login/signin/sign_in_screen.dart';
import 'package:myapp/screens/presentation/user_type_screen.dart';
import 'package:myapp/screens/numberPhone/phone_number_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/IntroPage': (context) => const IntroPage(),
        '/SignIn': (context) => const SignIn(),
        '/SignUpDriver': (context) => const SignUpDriver(),
        '/SignUpPassenger': (context) => const SignUpPassenger(),
        '/UserType': (context) => const UserTypeScreen(),
        '/NumberPhone': (context) => const PhoneNumberScreen(),
        '/HomeScreen': (context) => const HomeScreen(),
        '/DestinationScreen': (context) => const DestinationScreen(),
        '/SignUp': (context) => const SignIn(),
        '/CommandScreen': (context) => const CommandScreen(),
        '/MapScreen': (context) => MapScreen(),
      },
    );
  }
}
