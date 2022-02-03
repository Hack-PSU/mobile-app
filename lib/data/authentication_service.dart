import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'dart:io' show Platform;
import 'package:hackpsu/utils/flavor_constants.dart';

class AuthenticationService {
  // Dependencies
  final _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  // TODO: Remove print statements

  Future<void> signOut() async {
    print("signing out");
    await _firebaseAuth.signOut();
  }

  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future<User> signInWithGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final User user = authResult.user;
    return user;
  }

  Future<UserCredential> signInWithGitHub(BuildContext context) async {
    // Create a GitHubSignIn instance
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        // Input the staging info from the Teams app channel
        clientId: Config.gitHubClientId,
        clientSecret: Config.gitHubClientSecret,
        redirectUrl: Config.gitHubCallbackUrl);

    // Trigger the sign-in flow
    var result = await gitHubSignIn.signIn(context);

    // Create a credential from the access token

    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        print(result.token);
        final githubAuthCredential =
            GithubAuthProvider.credential(result.token);
            
        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance
            .signInWithCredential(githubAuthCredential);

      case GitHubSignInResultStatus.cancelled:
      case GitHubSignInResultStatus.failed:
        print(result.errorMessage);
        break;
    }

    return null;

  }
  launchURLApp() async {
    const url = 'https://app.hackpsu.org/forgot';

    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true, enableDomStorage: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
