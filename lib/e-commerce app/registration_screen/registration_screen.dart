import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/e-commerce%20app/dashboard/dashboard.dart';
import 'package:test_project/e-commerce%20app/login_screen/login_screen.dart';
import 'package:test_project/e-commerce%20app/login_screen/social_login/authentication/authentication_class.dart';
import 'package:test_project/utilities/common_logic.dart';
import 'package:test_project/widgets/common_widgets.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showPassword = false;
  String userFcmToken = "";
  String userUuid = "";

  void passwordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  bool isSigningIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CommonLogic.firebaseEventTrack("Registration_Screen");
    getUserToken();
  }

  Future<void> getUserToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      CommonWidgets.printFunction("fcm token : $fcmToken");
      userFcmToken = fcmToken;
    }
  }

  Future<void> createUser() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      credential.user!.updateDisplayName(nameController.text);
      CommonWidgets.printFunction("user credential ${credential} ${credential.user!.displayName}");
      CommonWidgets.printFunction("user credential $credential ${credential.user!.displayName}");

      if (mounted) {
        CommonWidgets.commonSuccessToast("Registration Successfully!", context);
      }

      if (credential.user != null) {
        userUuid = credential.user!.uid;
      }

      if (credential.user != null) {
        await credential.user!.reload();
      }

      CollectionReference users = FirebaseFirestore.instance.collection('users');

      return users
          .add({
            'name': nameController.text,
            'email_id': emailController.text,
            'password': passwordController.text,
            'fcm_token': userFcmToken,
            'user_uuid': userUuid,
            'type': "REGISTER",

          })
          .then((value) => CommonWidgets.printFunction("User Added ${users}"))


          .catchError((error) => CommonWidgets.printFunction("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CommonWidgets.printFunction('The password provided is too weak.');
        if (mounted) {
          CommonWidgets.commonErrorToast("The password provided is too weak.${e.message}", context);
        }
      } else if (e.code == 'email-already-in-use') {
        if (mounted) {
          CommonWidgets.commonErrorToast("The account already exists for that email.", context);
        }
        CommonWidgets.printFunction('The account already exists for that email.');
      }
    } catch (e) {
      CommonWidgets.printFunction("catch error ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    CommonLogic.initiateHeightWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.01),
                child: CircleAvatar(
                  backgroundColor: const Color(0xffF7F7F9),
                  radius: CommonLogic.textSize * 0.025,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.018),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: const Color(0xff2B2B2B),
                      size: CommonLogic.textSize * 0.02,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "Register Account",
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
                      "Name",
                      style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w600, color: const Color(0xff2B2B2B)),
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                      fillColor: const Color(0xffF7F7F9),
                      filled: true,
                      hintText: "Enter your name",
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
            SizedBox(
              height: CommonLogic.textSize * 0.01,
            ),
            InkWell(
              onTap: () {
                if (nameController.text.isEmpty) {
                  CommonWidgets.commonErrorToast("Please enter name.", context);
                } else if (emailController.text.isEmpty) {
                  CommonWidgets.commonErrorToast("Please enter email address.", context);
                } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)) {
                  CommonWidgets.commonErrorToast("Please enter valid email address.", context);
                } else if (passwordController.text.isEmpty) {
                  CommonWidgets.commonErrorToast("Please enter password.", context);
                } else {
                  createUser().whenComplete(() {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      Navigator.push(context, MaterialPageRoute(
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
                    "Sign Up",
                    style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
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
                        "Sign Up With Google",
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

                        /* CollectionReference users = FirebaseFirestore.instance.collection('users');

                        return users.add({
                          'name': user.displayName,
                          'email_id': user.email,
                          'password': "",
                          'fcm_token': userFcmToken,
                          'user_uuid': user.uid,
                          'type': "GOOGLE_REG",
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
                        }).catchError((error) => CommonWidgets.printFunction("Failed to add user: $error"));*/
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
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already Have Account?",
              style: GoogleFonts.poppins(
                fontSize: CommonLogic.textSize * 0.02,
                fontWeight: FontWeight.w500,
                color: const Color(0xff6A6A6A),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ), (route) => false);
              },
              child: Padding(
                padding: EdgeInsets.only(left: CommonLogic.textSize * 0.005),
                child: Text(
                  "Log In",
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
    );
  }
}
