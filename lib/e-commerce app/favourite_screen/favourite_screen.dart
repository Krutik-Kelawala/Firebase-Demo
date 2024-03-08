import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/e-commerce%20app/product_detail_screen/product_detail_screen.dart';
import 'package:test_project/utilities/common_logic.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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
        title: Text(
          "Favourites",
          style: GoogleFonts.raleway(
            fontSize: CommonLogic.textSize * 0.02,
            color: const Color(0xff2B2B2B),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.02),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 5,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.58,
            crossAxisSpacing: CommonLogic.textSize * 0.025,
            mainAxisSpacing: CommonLogic.textSize * 0.02,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const ProductDetailScreen();
                  },
                ));
              },
              child: Container(
                width: CommonLogic.textSize * 0.2,
                // padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.02)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.02),
                      child: CircleAvatar(
                        backgroundColor: Color(0xffF7F7F9),
                        radius: CommonLogic.textSize * 0.02,
                        child: Center(
                          child: Icon(
                            Icons.favorite,
                            size: CommonLogic.textSize * 0.02,
                            color: const Color(0xffF87265),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02),
                    child: Image.asset(
                      "assets/images/ecommerce/shoes_ic.webp",
                      height: CommonLogic.textSize * 0.16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02),
                    child: Text(
                      'BEST SELLER',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                        color: const Color(0xff48B2E7),
                        fontSize: CommonLogic.textSize * 0.016,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02),
                    child: Text(
                      'Nike Jorden',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                        color: const Color(0xff707B81),
                        fontSize: CommonLogic.textSize * 0.018,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.005),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '302.00',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: const Color(0xff707B81),
                              fontSize: CommonLogic.textSize * 0.018,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: CommonLogic.textSize * 0.01),
                          child: CircleAvatar(
                            radius: CommonLogic.textSize * 0.01,
                            backgroundColor: Color(0xffCB1D1D),
                          ),
                        ),
                        CircleAvatar(
                          radius: CommonLogic.textSize * 0.01,
                          backgroundColor: Color(0xff0B2F8B),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
