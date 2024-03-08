import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/utilities/common_logic.dart';
import 'package:test_project/widgets/common_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  User? user = FirebaseAuth.instance.currentUser;

  String getInitials() {
    var buffer = StringBuffer();
    var split = user!.email!.split(' ');
    for (var i = 0; i < 1; i++) {
      buffer.write(split[i][0]);
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffF7F7F9),
      backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: const Color(0xffF7F7F9),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.008, vertical: CommonLogic.textSize * 0.01),
            child: CircleAvatar(
              backgroundColor: Color(0xffF7F7F9),
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
        title: Text(
          "Profile",
          style: GoogleFonts.raleway(
            fontSize: CommonLogic.textSize * 0.02,
            color: const Color(0xff2B2B2B),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02),
          child: Column(children: [
            user != null
                ? Container(
                    padding: EdgeInsets.only(
                      top: CommonLogic.textSize * 0.05,
                    ),
                    child: CircleAvatar(
                      radius: CommonLogic.textSize * 0.045,
                      backgroundColor: Colors.deepPurpleAccent,
                      child: Center(
                        child: Text(
                          getInitials().toUpperCase(),
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: CommonLogic.textSize * 0.05, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(
                      top: CommonLogic.textSize * 0.1,
                    ),
                    child: Icon(
                      Icons.account_circle,
                      size: CommonLogic.textSize * 0.1,
                      color: Colors.white,
                    ),
                  ),
            Container(
              padding: EdgeInsets.only(
                top: CommonLogic.textSize * 0.02,
              ),
              child: Text(
                // user != null ? (user!.email!.split("@").first) : "User Name",
                user != null ? "${user!.displayName}" : "User Name",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.raleway(
                  color: const Color(0xff2B2B2B),
                  fontSize: CommonLogic.textSize * 0.022,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              user != null ? user!.email! : "user@gmail.com",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.raleway(
                color: const Color(0xff2B2B2B),
                fontSize: CommonLogic.textSize * 0.022,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: CommonLogic.textSize * 0.03,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "First Name",
                      style: GoogleFonts.raleway(
                        color: const Color(0xff2B2B2B),
                        fontSize: CommonLogic.textSize * 0.02,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: CommonLogic.textSize * 0.01,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                          fillColor: const Color(0xffF7F7F9),
                          filled: true,
                          hintText: "Enter first name",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: CommonLogic.textSize * 0.02,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff6A6A6A),
                          ),
                        ),
                        style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: const Color(0xff2B2B2B)),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last Name",
                      style: GoogleFonts.raleway(
                        color: const Color(0xff2B2B2B),
                        fontSize: CommonLogic.textSize * 0.02,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: CommonLogic.textSize * 0.01,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                          fillColor: const Color(0xffF7F7F9),
                          filled: true,
                          hintText: "Enter last name",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: CommonLogic.textSize * 0.02,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff6A6A6A),
                          ),
                        ),
                        style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: const Color(0xff2B2B2B)),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email Address",
                      style: GoogleFonts.raleway(
                        color: const Color(0xff2B2B2B),
                        fontSize: CommonLogic.textSize * 0.02,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: CommonLogic.textSize * 0.01,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                          fillColor: const Color(0xffF7F7F9),
                          filled: true,
                          hintText: "Enter email address",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: CommonLogic.textSize * 0.02,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff6A6A6A),
                          ),
                        ),
                        style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: const Color(0xff2B2B2B)),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mobile Number",
                      style: GoogleFonts.raleway(
                        color: const Color(0xff2B2B2B),
                        fontSize: CommonLogic.textSize * 0.02,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: CommonLogic.textSize * 0.01,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                          fillColor: const Color(0xffF7F7F9),
                          filled: true,
                          hintText: "Enter mobile number",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: CommonLogic.textSize * 0.02,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff6A6A6A),
                          ),
                        ),
                        style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: const Color(0xff2B2B2B)),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address",
                      style: GoogleFonts.raleway(
                        color: const Color(0xff2B2B2B),
                        fontSize: CommonLogic.textSize * 0.02,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: CommonLogic.textSize * 0.01,
                      ),
                      child: CSCPicker(
                        defaultCountry: CscCountry.India,
                        cityDropdownLabel: "Select City",
                        stateDropdownLabel: "Select state",
                        // currentCity: "Surat",
                        disableCountry: true,
                        layout: Layout.vertical,
                        showStates: true,
                        showCities: true,
                        flagState: CountryFlag.DISABLE,
                        dropdownDecoration: BoxDecoration(
                          color: const Color(0xffF7F7F9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        disabledDropdownDecoration: BoxDecoration(
                          color: const Color(0xffF7F7F9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          if (value != null) {
                            setState(() {
                              stateValue = value;
                            });
                          }
                        },
                        onCityChanged: (value) {
                          if (value != null) {
                            setState(() {
                              cityValue = value;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () {
                if (stateValue.isEmpty || stateValue == "Select state") {
                  CommonWidgets.commonErrorToast("Please select state", context);
                } else if (cityValue.isEmpty || cityValue == "Select city") {
                  CommonWidgets.commonErrorToast("Please select city", context);
                } else {
                  setState(() {
                    address = "Country : $countryValue\n State : $stateValue\n City : $cityValue";
                    CommonWidgets.printFunction("address $address");
                  });
                }
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.015, horizontal: CommonLogic.textSize * 0.02),
                margin: EdgeInsets.symmetric(
                  vertical: CommonLogic.textSize * 0.02,
                ),
                decoration: BoxDecoration(color: const Color(0xff48B2E7), borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    "Save",
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
}
