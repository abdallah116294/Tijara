import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tijara/feature/root.dart';
import 'package:tijara/services/app_methods.dart';
import 'package:tijara/services/assets_manager.dart';

class GoogleButton extends StatelessWidget {
  GoogleButton({super.key});
  AppMethods appMethods = AppMethods();
  final auth = FirebaseAuth.instance;
  Future<void> _goolgeSignIn({required BuildContext context}) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final authResults = await FirebaseAuth.instance
              .signInWithCredential(GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ));
          if(authResults.additionalUserInfo!.isNewUser){
          await FirebaseFirestore.instance
            .collection("users")
            .doc(authResults.user!.uid)
            .set({
          "userId": authResults.user!.uid,
          "userName":authResults.user!.displayName,
          "userImage": authResults.user!.photoURL,
          "userEmail": authResults.user!.email,
          "craetedAt": Timestamp.now(),
          "userCart": [],
          "userWish": []
        });
          }
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            Navigator.pushReplacementNamed(context, RootScreen.rootname);
          });
        } on FirebaseException catch (error) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            // await MyAppMethods.showErrorORWarningDialog(
            //   context: context,
            //   subtitle: "An error has been occured ${error.message}",
            //   fct: () {},
            // );
            await appMethods.dailogAlert(
                context: context,
                imagePathe: AssetsManager.warrning,
                title: "An error has been occured ${error.message}",
                fun: () {});
          });
        } catch (error) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            // await MyAppMethods.showErrorORWarningDialog(
            //   context: context,
            //   subtitle: "An error has been occured $error",
            //   fct: () {},
            // );
            await appMethods.dailogAlert(
                context: context,
                imagePathe: AssetsManager.warrning,
                title: "An error has been occured $error",
                fun: () {});
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
      icon: const Icon(
        Ionicons.logo_google,
        color: Colors.red,
      ),
      label: const Text(
        "Sign in with google",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      onPressed: () async {
        _goolgeSignIn(context: context);
      },
    );
  }
}
