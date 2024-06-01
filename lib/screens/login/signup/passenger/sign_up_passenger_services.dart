import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/screens/login/signup/passenger/passenger_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPassagerServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> postDetailsToFirestore(
      String fullName, String phoneNumber) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    PassengerModel passengerModel = PassengerModel();

    // Writing all the values
    passengerModel.email = user!.email;
    passengerModel.uid = user.uid;
    passengerModel.fullName = fullName;
    passengerModel.phoneNumber = phoneNumber;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(passengerModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
  }

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
}
