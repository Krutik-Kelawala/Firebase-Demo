import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/e-commerce%20app/dashboard/dashboard.dart';
import 'package:test_project/e-commerce%20app/forgot_password_screen/forgot_password_screen.dart';
import 'package:test_project/e-commerce%20app/login_screen/social_login/authentication/authentication_class.dart';
import 'package:test_project/e-commerce%20app/registration_screen/registration_screen.dart';
import 'package:test_project/utilities/common_logic.dart';
import 'package:test_project/widgets/common_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showPassword = false;

  bool isSigningIn = false;

  String userFcmToken = "";

  void passwordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CommonLogic.firebaseEventTrack("Login_Screen");

    getUserToken();
  }

  Future<void> getUserToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      CommonWidgets.printFunction("fcm token : $fcmToken");
      userFcmToken = fcmToken;
    }
  }

  Future<void> loginUser() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print("credential $credential");
      if (context.mounted) {
        CommonWidgets.commonSuccessToast("Login Successfully!", context);
      }
    } on FirebaseAuthException catch (e) {
      print("firebase error ${e.toString()}");
      if (e.code == 'user-not-found') {
        print('No user found for that email. ${e.toString()}');

        if (context.mounted) {
          CommonWidgets.commonErrorToast("No user found", context);
        }
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.${e.toString()}');
        if (context.mounted) {
          CommonWidgets.commonErrorToast("Wrong password", context);
        }
      } else if (e.code == "invalid-credential") {
        print('invalid-credential for that user.${e.toString()}');
        if (context.mounted) {
          CommonWidgets.commonErrorToast("Invalid credential", context);
        }
      }
    } catch (e) {
      print("error ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    CommonLogic.initiateHeightWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(backgroundColor: Colors.transparent),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "New User?",
              style: GoogleFonts.poppins(
                fontSize: CommonLogic.textSize * 0.02,
                fontWeight: FontWeight.w500,
                color: const Color(0xff6A6A6A),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const RegistrationScreen();
                  },
                ));
              },
              child: Padding(
                padding: EdgeInsets.only(left: CommonLogic.textSize * 0.005),
                child: Text(
                  "Create Account",
                  style: GoogleFonts.poppins(
                    fontSize: CommonLogic.textSize * 0.02,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff1A1D1E),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: CommonLogic.textSize * 0.05,
            ),
            Center(
              child: Text(
                "Hello Again!",
                style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.03, fontWeight: FontWeight.bold, color: const Color(0xff2B2B2B)),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.05, vertical: CommonLogic.textSize * 0.01),
              child: Text(
                "Fill your details or continue with social media",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: const Color(0xff707B81)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01),
                    child: Text(
                      "Email Address",
                      style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w600, color: const Color(0xff2B2B2B)),
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                      fillColor: const Color(0xffF7F7F9),
                      filled: true,
                      hintText: "xyz@gmail.com",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: CommonLogic.textSize * 0.02,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff6A6A6A),
                      ),
                    ),
                    style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: const Color(0xff2B2B2B)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01),
                    child: Text(
                      "Password",
                      style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w600, color: const Color(0xff2B2B2B)),
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                        fillColor: const Color(0xffF7F7F9),
                        filled: true,
                        hintText: "Enter password",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: CommonLogic.textSize * 0.02,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff6A6A6A),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            passwordVisibility();
                          },
                          child: Icon(
                            showPassword ? Icons.visibility : Icons.visibility_off,
                            color: const Color(0xff6A6A6A),
                          ),
                        )),
                    style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: const Color(0xff2B2B2B)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01, horizontal: CommonLogic.textSize * 0.02),
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const ForgotPassword();
                    },
                  ));
                },
                child: Text(
                  "Forgot Password",
                  style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: const Color(0xff707B81)),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (emailController.text.isEmpty) {
                  CommonWidgets.commonErrorToast("Please enter email address.", context);
                } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)) {
                  CommonWidgets.commonErrorToast("Please enter valid email address.", context);
                } else if (passwordController.text.isEmpty) {
                  CommonWidgets.commonErrorToast("Please enter password.", context);
                } else {
                  loginUser().whenComplete(() {
                    final user = FirebaseAuth.instance.currentUser;

                    if (user != null) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return const DashboardScreen();
                        },
                      ));
                    }
                  });
                }
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.015, horizontal: CommonLogic.textSize * 0.02),
                margin: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01, horizontal: CommonLogic.textSize * 0.02),
                decoration: BoxDecoration(color: const Color(0xff48B2E7), borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    "Sign In",
                    style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: Authentication.initializeFirebase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return InkWell(
                    onTap: () async {
                      setState(() {
                        isSigningIn = true;
                      });

                      User? user = await Authentication.signInWithGoogle(context);

                      setState(() {
                        isSigningIn = false;
                      });

                      if (user != null) {
                        if (context.mounted) {
                          CommonWidgets.printFunction("user detail mail ${user.email!} name ${user.displayName!} image pic ${user.photoURL}");
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return const DashboardScreen();
                            },
                          ));
                        }

                        /*   CollectionReference users = FirebaseFirestore.instance.collection('users');

                        return users.add({
                          'name': user.displayName,
                          'email_id': user.email,
                          'password': "",
                          'fcm_token': userFcmToken,
                          'user_uuid': user.uid,
                          'type': "GOOGLE_SIGN_IN",
                        }).then((value) {
                          CommonWidgets.printFunction("User Added $users");

                          if (context.mounted) {
                            CommonWidgets.printFunction("user detail mail ${user.email!} name ${user.displayName!} image pic ${user.photoURL}");
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) {
                                return const DashboardScreen();
                              },
                            ));
                          }
                        }).catchError((error) => CommonWidgets.printFunction("Failed to add user: $error"))*/
                        ;
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.015, horizontal: CommonLogic.textSize * 0.02),
                      margin: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.02, horizontal: CommonLogic.textSize * 0.02),
                      decoration: BoxDecoration(color: const Color(0xffF7F7F9), borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/ecommerce/google_ic.webp", height: CommonLogic.textSize * 0.025),
                          Padding(
                            padding: EdgeInsets.only(left: CommonLogic.textSize * 0.01),
                            child: Text(
                              "Sign In With Google",
                              style: GoogleFonts.poppins(
                                fontSize: CommonLogic.textSize * 0.02,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff2B2B2B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            )
          ]),
        ),
      ),
    );
  }
}
