import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/utilities/common_logic.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
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
        title: Text(
          "My Cart",
          style: GoogleFonts.raleway(
            fontSize: CommonLogic.textSize * 0.02,
            color: const Color(0xff2B2B2B),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: CommonLogic.textSize * 0.02,
          vertical: CommonLogic.textSize * 0.01,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.only(bottom: CommonLogic.textSize * 0.02),
            child: Text(
              "3 Items",
              style: GoogleFonts.poppins(
                fontSize: CommonLogic.textSize * 0.02,
                color: const Color(0xff2B2B2B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key("value"),
                  onDismissed: (direction) {},
                  secondaryBackground: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: CommonLogic.textSize * 0.01,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: CommonLogic.textSize * 0.01,
                    ),
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: CommonLogic.textSize * 0.04,
                    ),
                  ),
                  background: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: CommonLogic.textSize * 0.01,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: CommonLogic.textSize * 0.01,
                    ),
                    color: Colors.blue,
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: CommonLogic.textSize * 0.04,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: CommonLogic.textSize * 0.015,
                      horizontal: CommonLogic.textSize * 0.015,
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: CommonLogic.textSize * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.01),
                    ),
                    child: Row(children: [
                      Container(
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Color(0xffF7F7F9),
                          borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.02),
                        ),
                        child: Image.asset(
                          "assets/images/ecommerce/shoes_ic.webp",
                          height: CommonLogic.textSize * 0.1,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nike Air Max 270 ',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xff1A2530),
                                  fontSize: CommonLogic.textSize * 0.018,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: CommonLogic.textSize * 0.005,
                              ),
                              Text(
                                '74.95',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xff1A2530),
                                  fontSize: CommonLogic.textSize * 0.018,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                );
              },
            ),
          )
        ]),
      ),
      bottomNavigationBar: IntrinsicHeight(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.02),
          child: Column(children: [
            SizedBox(
              height: CommonLogic.textSize * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subtotal",
                  style: GoogleFonts.raleway(
                    fontSize: CommonLogic.textSize * 0.02,
                    color: const Color(0xff707B81),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "753.95",
                  style: GoogleFonts.poppins(
                    fontSize: CommonLogic.textSize * 0.02,
                    color: const Color(0xff1A2530),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery",
                    style: GoogleFonts.raleway(
                      fontSize: CommonLogic.textSize * 0.02,
                      color: const Color(0xff707B81),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "60.20",
                    style: GoogleFonts.poppins(
                      fontSize: CommonLogic.textSize * 0.02,
                      color: const Color(0xff1A2530),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01),
              height: CommonLogic.textSize * 0.002,
              color: const Color(0xff707B81),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Cost",
                    style: GoogleFonts.raleway(
                      fontSize: CommonLogic.textSize * 0.02,
                      color: const Color(0xff707B81),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "814.15",
                    style: GoogleFonts.poppins(
                      fontSize: CommonLogic.textSize * 0.02,
                      color: const Color(0xff1A2530),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.015, horizontal: CommonLogic.textSize * 0.02),
              margin: EdgeInsets.symmetric(
                vertical: CommonLogic.textSize * 0.02,
              ),
              decoration: BoxDecoration(color: const Color(0xff48B2E7), borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  "Checkout",
                  style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
