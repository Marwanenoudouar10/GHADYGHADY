import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/screens/login/signup/driver/sign_up_documents_second_screen.dart';
import 'package:myapp/screens/login/signup/driver/sign_up_driver_services.dart';
import 'package:myapp/widgets/button.dart';
import 'package:myapp/widgets/file_input.dart';
import 'package:myapp/widgets/top_bar.dart';

class SignUpFirstDocuments extends StatefulWidget {
  final List<String?> signInInfos;
  const SignUpFirstDocuments({super.key, required this.signInInfos});

  @override
  State<SignUpFirstDocuments> createState() => _SignUpFirstDocumentsState();
}

class _SignUpFirstDocumentsState extends State<SignUpFirstDocuments> {
  List<File?> images = [null, null, null];
  final picker = ImagePicker();
  SignUpDriverServices signUpHandler = SignUpDriverServices();

  Future getImage(ImageSource source, int index) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        images[index] = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
            horizontal: MediaQuery.of(context).size.width * 0.078),
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
            UploadFile(
                iconAsset: images[0] == null
                    ? Image.asset('assets/icons/galerie-icon.png')
                    : SizedBox(height: 150, child: Image.file(images[0]!)),
                buttonText: 'Ajouter votre photo',
                getImageFunction: (source) => getImage(source, 0)),
            const SizedBox(height: 14),
            UploadFile(
                iconAsset: images[1] == null
                    ? Image.asset('assets/images/image_cin.png')
                    : SizedBox(height: 150, child: Image.file(images[1]!)),
                buttonText: 'Ajouter une photo de carte nationale',
                getImageFunction: (source) => getImage(source, 1)),
            const SizedBox(height: 14),
            UploadFile(
                iconAsset: images[2] == null
                    ? Image.asset('assets/images/image_cin.png')
                    : SizedBox(height: 150, child: Image.file(images[2]!)),
                buttonText: 'Ajouter Recto de permis de conduire',
                getImageFunction: (source) => getImage(source, 2)),
            const SizedBox(height: 14),
            Button(
              text: 'Next',
              onPressed: () {
                List<Object?> signInInfos = [...widget.signInInfos, ...images];

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SignUpSecondDocuments(signInInfos: signInInfos),
                  ),
                );
              },
              fontSize: 20,
              color: const Color(0xFFFF5700),
              colorText: Colors.white,
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
