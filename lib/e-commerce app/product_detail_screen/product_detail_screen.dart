import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/e-commerce%20app/cart_screen/cart_screen.dart';
import 'package:test_project/utilities/common_logic.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool readMore = false;

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
          "Product Detail",
          style: GoogleFonts.raleway(
            fontSize: CommonLogic.textSize * 0.02,
            color: const Color(0xff2B2B2B),
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const MyCartScreen();
                },
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02),
              child: Image.asset(
                "assets/images/ecommerce/cart_ic.webp",
                height: CommonLogic.textSize * 0.05,
                width: CommonLogic.textSize * 0.05,
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: CommonLogic.textSize * 0.02,
            vertical: CommonLogic.textSize * 0.02,
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Nike Air Max 270 Essential",
              style: GoogleFonts.raleway(
                color: const Color(0xff2B2B2B),
                fontWeight: FontWeight.w700,
                fontSize: CommonLogic.textSize * 0.03,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.005),
              child: Text(
                "Man's Shoes",
                style: GoogleFonts.raleway(
                  color: const Color(0xff707B81),
                  fontWeight: FontWeight.w500,
                  fontSize: CommonLogic.textSize * 0.018,
                ),
              ),
            ),
            Text(
              "179.39",
              style: GoogleFonts.raleway(
                color: const Color(0xff2B2B2B),
                fontWeight: FontWeight.w700,
                fontSize: CommonLogic.textSize * 0.03,
              ),
            ),
            Image.asset(
              "assets/images/ecommerce/shoes_ic.webp",
              height: CommonLogic.textSize * 0.3,
            ),
            Container(
              height: CommonLogic.textSize * 0.08,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.02),
                    ),
                    width: CommonLogic.textSize * 0.08,
                    margin: EdgeInsets.only(
                      right: CommonLogic.textSize * 0.01,
                    ),
                    child: Image.asset(
                      "assets/images/ecommerce/shoes_ic.webp",
                      height: CommonLogic.textSize * 0.1,
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: CommonLogic.textSize * 0.02,
              ),
              child: Wrap(
                children: [
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                    maxLines: readMore ? 10 : 4,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: Color(0xff707B81),
                      fontSize: CommonLogic.textSize * 0.016,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(6),
                    child: GestureDetector(
                      child: Text(
                        readMore ? "Read less" : "Read more",
                        style: GoogleFonts.poppins(
                          color: Color(0xff0D6EFD),
                          fontSize: CommonLogic.textSize * 0.016,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          readMore = !readMore;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: CommonLogic.textSize * 0.04),
                  child: CircleAvatar(
                    backgroundColor: Color(0xffD9D9D9).withOpacity(0.4),
                    radius: CommonLogic.textSize * 0.035,
                    child: Icon(
                      Icons.favorite_border,
                      color: Color(0xff2B2B2B),
                      size: CommonLogic.textSize * 0.03,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: CommonLogic.textSize * 0.014,
                    horizontal: CommonLogic.textSize * 0.05,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff48B2E7),
                    borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.016),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: CommonLogic.textSize * 0.02),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: CommonLogic.textSize * 0.016,
                          child: Image.asset(
                            "assets/images/ecommerce/cart_bag.webp",
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        'Add To Cart',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: CommonLogic.textSize * 0.016,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
