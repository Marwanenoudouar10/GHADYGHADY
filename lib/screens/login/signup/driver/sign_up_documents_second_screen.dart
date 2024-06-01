import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/screens/login/signup/driver/sign_up_documents_third_screen.dart';
import 'package:myapp/widgets/button.dart';
import 'package:myapp/widgets/file_input.dart';
import 'package:myapp/widgets/top_bar.dart';

class SignUpSecondDocuments extends StatefulWidget {
  final List<Object?> signInInfos;
  const SignUpSecondDocuments({super.key, required this.signInInfos});

  @override
  State<SignUpSecondDocuments> createState() => _SignUpSecondDocumentsState();
}

class _SignUpSecondDocumentsState extends State<SignUpSecondDocuments> {
  late String _selectedItem = "2019";
  List<File?> images = [null, null];
  final picker = ImagePicker();

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

  List<String> _items = [
    '2019',
    '2020',
    '2021',
    '2023',
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
            UploadFile(
                iconAsset: images[0] == null
                    ? Image.asset('assets/images/image_cin.png')
                    : SizedBox(height: 150, child: Image.file(images[0]!)),
                buttonText: 'Ajouter Recto de permis de conduire',
                getImageFunction: (source) => getImage(source, 0)),
            const SizedBox(height: 14),
            UploadFile(
                iconAsset: images[1] == null
                    ? Image.asset('assets/images/image_cin.png')
                    : SizedBox(height: 150, child: Image.file(images[1]!)),
                buttonText: 'Ajouter Verso de permis de conduire',
                getImageFunction: (source) => getImage(source, 1)),
            const SizedBox(height: 14),
            Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: const Color(0xFFEFEDED),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Date d’expiration",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
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
                  const Text(
                    "Veuillez indiquer la date d’expiration de votre document",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 14),
            Button(
              text: 'Next',
              onPressed: () {
                List<Object?> signInInfos = [
                  ...widget.signInInfos,
                  ...images,
                  _selectedItem
                ];

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SignUpThirdDocuments(signInInfos: signInInfos),
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
