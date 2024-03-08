import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_project/widgets/common_widgets.dart';

class Authentication {
  // TODO START GOOGLE LOGIN
  // TODO firebase initialize firebase
  static initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  // TODO firebase google sign in method
  static Future<User?> signInWithGoogle(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          CommonWidgets.printFunction("GS user exits error ${e.code}");
          if (context.mounted) {
            CommonWidgets.commonErrorToast('The account already exists with a different credential', context);
          }
        } else if (e.code == 'invalid-credential') {
          CommonWidgets.printFunction("GS invalid-credential error ${e.code}");
          if (context.mounted) {
            CommonWidgets.commonErrorToast('Error occurred while accessing credentials. Try again.', context);
          }
        }
      } catch (e) {
        CommonWidgets.printFunction("GS catch error ${e.toString()}");
        if (context.mounted) {
          CommonWidgets.commonErrorToast('Error occurred using Google Sign In. Try again.', context);
        }
      }
    }
    return user;
  }

  // TODO google sign-out method
  static googleSignOut(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signOut();
    } catch (e) {
      CommonWidgets.printFunction("sign out catch error ${e.toString()}");
      if (context.mounted) {
        CommonWidgets.commonErrorToast('Error signing out. Try again.', context);
      }
    }
  }

// TODO END GOOGLE LOGIN

// TODO START APPLE LOGIN
/*static Future<User?> signInWithApple(BuildContext context) async {
    User? user;

    try {
      String clientID = 'com.example.app-demo-service';
      String redirectURL = 'https://grizzled-zippy-cactus.glitch.me/callbacks/sign_in_with_apple';

      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: defaultTargetPlatform == TargetPlatform.iOS ? nonce : null,
        webAuthenticationOptions: defaultTargetPlatform == TargetPlatform.iOS
            ? null
            : WebAuthenticationOptions(
          clientId: clientID,
          redirectUri: Uri.parse(redirectURL),
        ),
      );

      final AuthCredential appleAuthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: defaultTargetPlatform == TargetPlatform.iOS ? rawNonce : null,
        accessToken: defaultTargetPlatform == TargetPlatform.iOS ? null : appleCredential.authorizationCode,
      );

      try {
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(appleAuthCredential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        CommonWidgets.printFunction("Error Occur");
        if (e.code == 'account-exists-with-different-credential') {
          if (context.mounted) {
            CommonLogic.commonFlutterToast("The account already exists with a different credential");
          }
        } else if (e.code == 'invalid-credential') {
          if (context.mounted) {
            CommonLogic.commonFlutterToast("Error occurred while accessing credentials. Try again.");
          }
        }
      } catch (e) {
        if (context.mounted) {
          CommonLogic.commonFlutterToast("Error occurred using Google Sign In. Try again.");
        }
      }

      CommonWidgets.printFunction("User Login Successfully ${user!.email} ${user.displayName}");
      return user;
    } catch (e) {
      rethrow;
    }
  }

  static String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }*/

// TODO END APPLE LOGIN
}
