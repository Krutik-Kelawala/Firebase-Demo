import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/e-commerce%20app/verify_otp/verify_otp_screen.dart';
import 'package:test_project/utilities/common_logic.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CommonLogic.firebaseEventTrack("Forgot_Password_screen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Forgot Password",
                style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.03, fontWeight: FontWeight.bold, color: const Color(0xff2B2B2B)),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.05, vertical: CommonLogic.textSize * 0.01),
              child: Text(
                "Enter your Email account to reset your password",
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
            InkWell(
              onTap: () async {
                forgotPasswordSuccessDialog(context);
                /* if (emailController.text.isEmpty) {
                  CommonWidgets.commonErrorToast("Please enter email address.", context);
                } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)) {
                  CommonWidgets.commonErrorToast("Please enter valid email address.", context);
                } else {
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                  } catch (e) {
                    CommonWidgets.printFunction("catch err ${e.toString()}");
                  }
                }*/
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.015, horizontal: CommonLogic.textSize * 0.02),
                margin: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01, horizontal: CommonLogic.textSize * 0.02),
                decoration: BoxDecoration(color: const Color(0xff48B2E7), borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    "Reset Password",
                    style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  forgotPasswordSuccessDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(
          const Duration(seconds: 5),
          () {
            Navigator.of(context).pop();
          },
        );
        return PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: Column(children: [
              CircleAvatar(
                backgroundColor: const Color(0xff48B2E7),
                radius: CommonLogic.textSize * 0.03,
                child: const Icon(
                  Icons.mark_email_unread_outlined,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.01),
                child: Center(
                  child: Text(
                    "Check Your Email",
                    style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.bold, color: const Color(0xff2B2B2B)),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.01),
                child: Text(
                  "We have send password recovery code in your email",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.018, fontWeight: FontWeight.w500, color: const Color(0xff707B81)),
                ),
              ),
            ]),
          ),
        );
      },
    ).then((value) {
      return Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const VerifyOtp();
        },
      ));
    });
  }
}
