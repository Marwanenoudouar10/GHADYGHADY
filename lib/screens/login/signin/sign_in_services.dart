import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> handleSignInEmail(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email.toString().trim(), password: password.trim());
      final User user = result.user!;
      return user;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      // ignore: avoid_print
      print('une erreur se produit! $e');
    }
    return null;
  }

  Future<dynamic> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    GoogleSignIn().signOut();
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
