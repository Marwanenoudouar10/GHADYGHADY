import 'package:flutter/material.dart';
import 'package:myapp/widgets/button.dart';
import 'package:image_picker/image_picker.dart';

class UploadFile extends StatefulWidget {
  final Widget iconAsset;
  final String buttonText;
  final String? textDesc;
  final Function(ImageSource) getImageFunction;

  const UploadFile({
    super.key,
    required this.iconAsset,
    required this.buttonText,
    this.textDesc,
    required this.getImageFunction,
  });

  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEDED),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.textDesc ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          widget.iconAsset,
          const SizedBox(height: 10),
          Button(
            text: widget.buttonText,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Choose an option'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          GestureDetector(
                            child: const Text('Take a picture'),
                            onTap: () {
                              Navigator.of(context).pop();
                              widget.getImageFunction(ImageSource.camera);
                            },
                          ),
                          const Padding(padding: EdgeInsets.all(8.0)),
                          GestureDetector(
                            child: const Text('Choose from gallery'),
                            onTap: () {
                              Navigator.of(context).pop();
                              widget.getImageFunction(ImageSource.gallery);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            fontSize: 18,
            color: const Color(0xFFEFEDED),
            colorText: const Color(0xFFFF5700),
            side: "side",
          ),
        ],
      ),
    );
  }
}
