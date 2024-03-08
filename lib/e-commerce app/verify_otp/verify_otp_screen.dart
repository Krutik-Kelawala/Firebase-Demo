import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/utilities/common_logic.dart';
import 'package:test_project/widgets/common_widgets.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  late Timer timer;
  int start = 30;

  // 4 text editing controllers that associate with the 4 input fields
  final TextEditingController fieldOne = TextEditingController();
  final TextEditingController fieldTwo = TextEditingController();
  final TextEditingController fieldThree = TextEditingController();
  final TextEditingController fieldFour = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CommonLogic.firebaseEventTrack("Verify_Otp_Forgot_Password");
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            // timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  void resendOtp() {
    setState(() {
      start = 30;
    });
  }

  String otp = "";

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
                "OTP Verification",
                style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.03, fontWeight: FontWeight.bold, color: const Color(0xff2B2B2B)),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.05, vertical: CommonLogic.textSize * 0.01),
              child: Text(
                "Please check your email to see the verification code",
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
                      "OTP Code",
                      style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w600, color: const Color(0xff2B2B2B)),
                    ),
                  ),
                ],
              ),
            ),
            // Implement 4 input fields
            Container(
              padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OtpInput(fieldOne, true), // auto focus
                  SizedBox(
                    width: CommonLogic.textSize * 0.02,
                  ),
                  OtpInput(fieldTwo, false),
                  SizedBox(
                    width: CommonLogic.textSize * 0.02,
                  ),
                  OtpInput(fieldThree, false),
                  SizedBox(
                    width: CommonLogic.textSize * 0.02,
                  ),
                  OtpInput(fieldFour, false)
                ],
              ),
            ),
            SizedBox(
              height: CommonLogic.textSize * 0.02,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  otp = fieldOne.text + fieldTwo.text + fieldThree.text + fieldFour.text;
                });
                if (kDebugMode) {
                  CommonWidgets.printFunction("OTP input : $otp");
                }
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.015, horizontal: CommonLogic.textSize * 0.02),
                margin: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01, horizontal: CommonLogic.textSize * 0.02),
                decoration: BoxDecoration(color: const Color(0xff48B2E7), borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    "Verify",
                    style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ),
            ),
            start != 0
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Resend code to",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.018, fontWeight: FontWeight.w500, color: const Color(0xff707B81)),
                        ),
                        Text(
                          start < 10 ? "00:0$start" : "00:$start",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.018, fontWeight: FontWeight.w500, color: const Color(0xff707B81)),
                        )
                      ],
                    ),
                  )
                : InkWell(
                    onTap: () {
                      resendOtp();
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: IntrinsicWidth(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01, horizontal: CommonLogic.textSize * 0.01),
                          margin: EdgeInsets.symmetric(
                            vertical: CommonLogic.textSize * 0.03,
                          ),
                          decoration: BoxDecoration(color: const Color(0xff48B2E7), borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              "Resend OTP",
                              style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.016, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

// Create an input widget that takes only one digit
class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;

  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommonLogic.initiateHeightWidth(context);
    return Expanded(
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(
          color: const Color(0xff000000),
          fontSize: CommonLogic.textSize * 0.02,
          fontWeight: FontWeight.w500,
        ),
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          // isDense: true,4
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
          fillColor: const Color(0xffF7F7F9),
          filled: true,
          counterText: '',
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).previousFocus();
          }
          if (value.length == 4) {
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }
}
