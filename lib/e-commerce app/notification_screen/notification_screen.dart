import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/utilities/common_logic.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    CommonLogic.initiateHeightWidth(context);
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F9),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.008, vertical: CommonLogic.textSize * 0.01),
            child: CircleAvatar(
              backgroundColor: Colors.white,
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
        title: Text("Notification",
            style: GoogleFonts.raleway(
              fontSize: CommonLogic.textSize * 0.02,
              color: Color(0xff2B2B2B),
              fontWeight: FontWeight.w500,
            )),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: CommonLogic.textSize * 0.02,
        ),
        child: ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.02),
                  child: Text("Recent",
                      style: GoogleFonts.raleway(
                        fontSize: CommonLogic.textSize * 0.02,
                        color: Color(0xff2B2B2B),
                        fontWeight: FontWeight.w600,
                      )),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.02),
                      margin: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            CommonLogic.textSize * 0.01,
                          )),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: CommonLogic.textSize * 0.002,
                            // vertical: CommonLogic.textSize * 0.01,
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xffF7F7F9),
                              borderRadius: BorderRadius.circular(
                                CommonLogic.textSize * 0.01,
                              )),
                          child: Image.asset(
                            "assets/images/ecommerce/shoes_ic.webp",
                            height: CommonLogic.textSize * 0.08,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: CommonLogic.textSize * 0.01,
                            ),
                            child: Column(
                              children: [
                                Text("We Have New Products With Offers",
                                    style: GoogleFonts.raleway(
                                      fontSize: CommonLogic.textSize * 0.015,
                                      color: Color(0xff2B2B2B),
                                      fontWeight: FontWeight.w500,
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("364.50",
                                        style: GoogleFonts.poppins(
                                          fontSize: CommonLogic.textSize * 0.015,
                                          color: Color(0xff2B2B2B),
                                          fontWeight: FontWeight.w500,
                                        )),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: CommonLogic.textSize * 0.005,
                                        horizontal: CommonLogic.textSize * 0.02,
                                      ),
                                      child: Text("260.00",
                                          style: GoogleFonts.poppins(
                                            fontSize: CommonLogic.textSize * 0.015,
                                            color: Color(0xff707B81),
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Text("40 min ago",
                            style: GoogleFonts.poppins(
                              fontSize: CommonLogic.textSize * 0.015,
                              color: Color(0xff707B81),
                              fontWeight: FontWeight.w500,
                            )),
                      ]),
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
