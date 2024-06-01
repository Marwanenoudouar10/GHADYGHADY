import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/widgets/button.dart';

class CodeVerificationScreen extends StatefulWidget {
  final String verificationId;

  const CodeVerificationScreen({super.key, required this.verificationId});

  @override
  _CodeVerificationScreenState createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _codeController = TextEditingController();

  void _verifyCode() async {
    String smsCode = _codeController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: smsCode,
    );

    try {
      await _auth.signInWithCredential(credential);
      // Navigate to the next screen after successful verification
    } catch (e) {
      print('Failed to verify code: $e');
      // Show error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter Verification Code',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'Enter the code sent to your phone',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFD9D9D9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Button(
                text: 'Verify Code',
                onPressed: _verifyCode,
                fontSize: 20.0,
                color: const Color(0xFFFF5700),
                colorText: Colors.white,
                border: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
