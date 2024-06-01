import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/screens/login/signup/driver/driver_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpDriverServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> handleSignUp(String email, String password) async {
    String? errorMessage;
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;
      return user;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "invalid-credential":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage);
      print(error.code);
    }
    return null;
  }

  Future<String> uploadFile(File file) async {
    String fileName = file.path.split('/').last;
    Reference ref = FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<void> postDetailsToFirestore(signInInfos) async {
    List<String?> imageUrls = [];
    for (var element in signInInfos) {
      if (element != null && element is File) {
        try {
          String imageUrl = await uploadFile(element);
          imageUrls.add(imageUrl);
        } catch (e) {
          print('Failed to upload image: $e');
        }
      }
    }
    // print(imageUrls);

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    DriverModel driverModel = DriverModel();
    driverModel.email = user!.email;
    driverModel.uid = user.uid;
    driverModel.fullName = signInInfos[0];
    driverModel.phoneNumber = signInInfos[1];
    driverModel.expDate = signInInfos[7];
    driverModel.marqueMotor = signInInfos[9];
    driverModel.picPerso = imageUrls[0];
    driverModel.cinRecto = imageUrls[1];
    driverModel.cinVerso = imageUrls[2];
    driverModel.permisRecto = imageUrls[3];
    driverModel.permisVerso = imageUrls[4];
    driverModel.picMotor = imageUrls[5];

    await firebaseFirestore
        .collection("driver_user")
        .doc(user.uid)
        .set(driverModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
  }
}
