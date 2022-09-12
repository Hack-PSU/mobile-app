import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../secrets.dart';

class SignUpWithEmailAndPasswordError implements Exception {
  const SignUpWithEmailAndPasswordError([
    this.message = "An unknown error occurred",
  ]);

  factory SignUpWithEmailAndPasswordError.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordError(
          "An account already exists for this email.",
        );
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordError(
          "Email is not valid or badly formatted.",
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordError(
          "This user has been disabled.",
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordError(
          "Operation is not allowed.",
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordError(
          "Please enter a stronger password.",
        );
      default:
        return const SignUpWithEmailAndPasswordError();
    }
  }

  final String message;
}

class SignInWithEmailAndPasswordError implements Exception {
  const SignInWithEmailAndPasswordError(
      [this.message = "An unknown error has occurred."]);

  factory SignInWithEmailAndPasswordError.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInWithEmailAndPasswordError(
          "Email is not valid or badly formatted.",
        );
      case 'user-disabled':
        return const SignInWithEmailAndPasswordError(
          "This user has been disabled.",
        );
      case 'user-not-found':
        return const SignInWithEmailAndPasswordError(
          "Email is not found, create an account.",
        );
      case 'wrong-password':
        return const SignInWithEmailAndPasswordError(
          "Incorrect password.",
        );
      default:
        return const SignInWithEmailAndPasswordError();
    }
  }

  final String message;
}

enum CredentialType { GOOGLE, GITHUB, APPLE, UNKNOWN }

class SignInWithCredentialError implements Exception {
  const SignInWithCredentialError([
    this.message = "An unknown error has occurred.",
    this.credential = CredentialType.UNKNOWN,
  ]);

  final String message;
  final CredentialType credential;

  static String fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return "Account already exists with another credential.";
      case 'invalid-credential':
        return "Invalid credentials.";
      case 'operation-not-allowed':
        return "Operation is not allowed.";
      case 'user-disabled':
        return "This user has been disabled.";
      case 'user-not-found':
        return "User is not found.";
      case 'wrong-password':
        return "Incorrect password.";
      case 'invalid-verification-code':
        return "Verification code is invalid. Please try again.";
      case 'invalid-verification-id':
        return "Verification ID is invalid.";
      default:
        return "An unknown error has occurred.";
    }
  }
}

class SignInWithGoogleError extends SignInWithCredentialError {
  const SignInWithGoogleError([
    String message = "An unknown error has occurred.",
    CredentialType credential = CredentialType.GOOGLE,
  ]) : super(message, credential);

  factory SignInWithGoogleError.fromCode(String code) {
    return SignInWithGoogleError(
      SignInWithCredentialError.fromCode(code),
    );
  }
}

class SignInWithGithubError extends SignInWithCredentialError {
  const SignInWithGithubError([
    String message = "An unknown error has occurred.",
    CredentialType credential = CredentialType.GITHUB,
  ]) : super(message, credential);

  factory SignInWithGithubError.fromCode(String code) {
    return SignInWithGithubError(
      SignInWithCredentialError.fromCode(code),
    );
  }
}

class SignInWithAppleError extends SignInWithCredentialError {
  const SignInWithAppleError([
    String message = "An unknown error has occurred.",
    CredentialType credential = CredentialType.APPLE,
  ]) : super(message, credential);

  factory SignInWithAppleError.fromCode(String code) {
    return SignInWithAppleError(
      SignInWithCredentialError.fromCode(code),
    );
  }
}

class SignOutError implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    GitHubSignIn? gitHubSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _githubSignIn = gitHubSignIn ??
            GitHubSignIn(
              // Input the staging info from the Teams app channel
              clientId: Secrets.gitHubClientIdProd,
              clientSecret: Secrets.gitHubClientSecretProd,
              redirectUrl: Secrets.gitHubCallbackUrlProd,
            );

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final GitHubSignIn _githubSignIn;

  Stream<User?> get user => _firebaseAuth.authStateChanges();
  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignInWithEmailAndPasswordError.fromCode(e.code);
    } catch (_) {
      throw const SignInWithEmailAndPasswordError();
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordError.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordError();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw SignInWithGoogleError.fromCode(e.code);
    } catch (_) {
      throw const SignInWithGoogleError();
    }
  }

  Future<void> signInWithGitHub(BuildContext context) async {
    try {
      final githubAuth = await _githubSignIn.signIn(context);
      switch (githubAuth.status) {
        case GitHubSignInResultStatus.ok:
          final OAuthCredential githubAuthCredential =
              GithubAuthProvider.credential(githubAuth.token!);

          await _firebaseAuth.signInWithCredential(githubAuthCredential);
          break;
        case GitHubSignInResultStatus.cancelled:
          throw const SignInWithGithubError("Status Cancelled");
          break;
        case GitHubSignInResultStatus.failed:
          throw const SignInWithGithubError("Status failed");
          break;
      }
    } on FirebaseAuthException catch (e) {
      throw SignInWithGithubError.fromCode(e.code);
    } catch (e) {
      throw const SignInWithGithubError();
    }
  }

  Future<void> signInWithApple() async {
    final AuthorizationResult result = await TheAppleSignIn.performRequests(
      [
        const AppleIdRequest(
          requestedScopes: [Scope.email, Scope.fullName],
        ),
      ],
    );

    switch (result.status) {
      case AuthorizationStatus.authorized:
        final AppleIdCredential appleIdCredential = result.credential!;
        final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
        final OAuthCredential credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );

        try {
          final UserCredential userCredential =
              await _firebaseAuth.signInWithCredential(credential);

          final user = userCredential.user;
          final fullName = appleIdCredential.fullName;

          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName} ${fullName.familyName}';
            await user!.updateDisplayName(displayName);
          }
        } on FirebaseAuthException catch (e) {
          throw SignInWithAppleError.fromCode(e.code);
        } catch (e) {
          throw const SignInWithAppleError();
        }
        break;
      case AuthorizationStatus.cancelled:
        throw const SignInWithAppleError("Status Cancelled");
        break;
      case AuthorizationStatus.error:
        throw const SignInWithAppleError("Status Error");
        break;
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw SignOutError();
    }
  }

  Future<void> launchURLApp() async {
    const url = 'https://app.hackpsu.org/forgot';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.inAppWebView,
      );
    } else {
      throw Exception('Could not launch $url');
    }
  }
}
