import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart';
import '../ui/bottomActivities/home_screen.dart';

class RegisterService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference().child("biovitality_users");
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> registerToFb(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserDetail userDetail = UserDetail(
        uid: result.user!.uid,
        email: email,
        name: name,
      );
      await _dbRef.child(result.user!.uid).set(userDetail.toMap());

      await result.user!.sendEmailVerification();

      // Show dialog to inform user to check inbox for verification email
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Check Your Inbox"),
            content: Text(
              "A verification email has been sent to ${result.user!.email}. Please verify your email to continue.",
            ),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      // Optionally sign out user after registration to wait for email verification
      await _firebaseAuth.signOut();
    } catch (error) {
      _showErrorDialog(error.toString(), context);
    }
  }

  Future<void> registerWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user != null) {
        bool userExists = await checkIfUserExists(userCredential.user!.email!);
        if (!userExists) {
          UserDetail userDetail = UserDetail(
            uid: userCredential.user!.uid,
            email: userCredential.user!.email ?? '',
            name: userCredential.user!.displayName ?? '',
            contact: userCredential.user!.phoneNumber,
          );
          await _dbRef.child(userCredential.user!.uid).set(userDetail.toMap());
        }
        String uid = userCredential.user!.uid;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(uid: uid)));
      } else {
        _showErrorDialog("User information not found.", context);
      }
    } catch (error) {
      _showErrorDialog(error.toString(), context);
    }
  }

  Future<bool> checkIfUserExists(String email) async {
    try {
      DatabaseEvent snapshot = await _dbRef.orderByChild("email").equalTo(email).once();

      if (snapshot.snapshot.value != null) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print("Error checking user existence: $error");
      return false;
    }
  }

  void _showErrorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}