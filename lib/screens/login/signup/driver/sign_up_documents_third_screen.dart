import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/screens/home/home_screen.dart';
import 'package:myapp/screens/login/signup/driver/sign_up_driver_services.dart';
import 'package:myapp/widgets/button.dart';
import 'package:myapp/widgets/file_input.dart';
import 'package:myapp/widgets/top_bar.dart';

class SignUpThirdDocuments extends StatefulWidget {
  final List<Object?> signInInfos;

  const SignUpThirdDocuments({
    super.key,
    required this.signInInfos,
  });

  @override
  State<SignUpThirdDocuments> createState() => _SignUpThirdDocumentsState();
}

class _SignUpThirdDocumentsState extends State<SignUpThirdDocuments> {
  late String _selectedItem = "Marque 1";
  File? image;
  final picker = ImagePicker();
  SignUpDriverServices signUpHandler = SignUpDriverServices();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  final List<String> _items = [
    'Marque 1',
    'Marque 2',
    'Marque 3',
    'Marque 4',
  ];

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
            const Text(
              "Choisir la marque de votre moteur",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFEFEDED),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: const SizedBox(),
                      value: _selectedItem,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedItem = newValue!;
                        });
                      },
                      items: _items.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            UploadFile(
                iconAsset: image == null
                    ? Image.asset('assets/icons/galerie-icon.png')
                    : Image.file(image!),
                buttonText: 'Ajouter une photo',
                textDesc:
                    'Prenez une photo de votre moteur de façon à ce que le numéro de plaque d’immatriculation soit visible',
                getImageFunction: getImage),
            const SizedBox(height: 14),
            Button(
              text: 'Submit',
              onPressed: () async {
                List<Object?> signInInfos = [
                  ...widget.signInInfos,
                  image,
                  _selectedItem
                ];

                await signUpHandler.postDetailsToFirestore(signInInfos).then(
                    (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen())));
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
