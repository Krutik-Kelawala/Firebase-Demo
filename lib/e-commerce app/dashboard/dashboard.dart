import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:test_project/e-commerce%20app/cart_screen/cart_screen.dart';
import 'package:test_project/e-commerce%20app/favourite_screen/favourite_screen.dart';
import 'package:test_project/e-commerce%20app/login_screen/login_screen.dart';
import 'package:test_project/e-commerce%20app/login_screen/social_login/authentication/authentication_class.dart';
import 'package:test_project/e-commerce%20app/notification_screen/notification_screen.dart';
import 'package:test_project/e-commerce%20app/product_detail_screen/product_detail_screen.dart';
import 'package:test_project/e-commerce%20app/profile_screen/profile_screen.dart';
import 'package:test_project/utilities/common_logic.dart';
import 'package:test_project/widgets/common_widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController deleteAccountController = TextEditingController();
  int selectCatIndex = 0;
  bool validate = false;

  List menuList = [
    'Profile',
    'My Cart',
    'Favourite',
    'Orders',
    'Notifications',
    'Settings',
  ];

  List menuIcon = [
    'assets/images/ecommerce/profile_ic.webp',
    'assets/images/ecommerce/cart_bag.webp',
    'assets/images/ecommerce/fav_ic.webp',
    'assets/images/ecommerce/order_ic.webp',
    'assets/images/ecommerce/notification_ic.webp',
    'assets/images/ecommerce/setting_ic.webp',
  ];

  User? user = FirebaseAuth.instance.currentUser;

  String getInitials() {
    var buffer = StringBuffer();
    var split = user!.email!.split(' ');
    for (var i = 0; i < 1; i++) {
      buffer.write(split[i][0]);
    }

    return buffer.toString();
  }

  Future<void> deleteUser() async {
    try {
      await user?.delete();

      CollectionReference users = FirebaseFirestore.instance.collection('delete_users');

      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ));
      }

      return users
          .add({'email_id': user!.email, 'reason': deleteAccountController.text})
          .then(
            (value) => CommonWidgets.printFunction("User Added $users"),
          )
          .catchError(
            (error) => CommonWidgets.printFunction("Failed to add user: $error"),
          );
    } catch (e) {
      CommonWidgets.printFunction(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userReload();
  }

  userReload() async {
    if (user != null) {
      await user!.reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    CommonLogic.initiateHeightWidth(context);
    CommonWidgets.printFunction("profile ic ${getInitials().toUpperCase()} ${user!.displayName}");
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
            elevation: 5,
            shadowColor: Colors.white,
            width: CommonLogic.textSize * 0.3,
            backgroundColor: const Color(0xff48B2E7),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.03),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    user != null
                        ? Container(
                            padding: EdgeInsets.only(
                              top: CommonLogic.textSize * 0.1,
                            ),
                            child: CircleAvatar(
                              radius: CommonLogic.textSize * 0.045,
                              backgroundColor: Colors.deepPurpleAccent,
                              child: Center(
                                child: Text(
                                  getInitials().toUpperCase(),
                                  style: GoogleFonts.poppins(color: Colors.white, fontSize: CommonLogic.textSize * 0.05, fontWeight: FontWeight.bold),
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
                          color: Colors.white,
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
                        color: Colors.white,
                        fontSize: CommonLogic.textSize * 0.022,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.02),
                      color: const Color(0xffF7F7F9).withOpacity(0.2),
                      height: CommonLogic.textSize * 0.002,
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: menuList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            if (index == 0) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const ProfileScreen();
                                },
                              ));
                            } else if (index == 1) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const MyCartScreen();
                                },
                              ));
                            } else if (index == 2) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const FavouriteScreen();
                                },
                              ));
                            } else if (index == 3) {
                              // Todo navigate orders screen
                            } else if (index == 4) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const NotificationScreen();
                                },
                              ));
                            } else if (index == 5) {}
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Image.asset(
                              menuIcon[index],
                              height: CommonLogic.textSize * 0.026,
                              color: Colors.white,
                            ),
                            title: Text(
                              menuList[index],
                              style: GoogleFonts.raleway(
                                color: Colors.white,
                                fontSize: CommonLogic.textSize * 0.02,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01),
                      color: const Color(0xffF7F7F9).withOpacity(0.2),
                      height: CommonLogic.textSize * 0.002,
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  elevation: 5,
                                  contentPadding: EdgeInsets.zero,
                                  title: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: CommonLogic.textSize * 0.01,
                                      horizontal: CommonLogic.textSize * 0.01,
                                    ),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text(
                                        "Account Delete :",
                                        style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.02, color: const Color(0xff707B81), fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.02),
                                        child: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              if (deleteAccountController.text.isEmpty) {
                                                validate = true;
                                              } else {
                                                validate = false;
                                              }
                                            });
                                          },
                                          controller: deleteAccountController,
                                          maxLines: 4,
                                          decoration: InputDecoration(
                                            errorText: validate ? "Please enter reason for account delete." : null,
                                            isDense: true,
                                            errorMaxLines: 2,
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                                            fillColor: const Color(0xffF7F7F9),
                                            filled: true,
                                            hintText: "Write reason for account delete",
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: CommonLogic.textSize * 0.02,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff6A6A6A),
                                            ),
                                          ),
                                          style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: const Color(0xff2B2B2B)),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: deleteAccountController.text.isNotEmpty
                                            ? () {
                                                Navigator.pop(context);
                                                deleteUser();
                                              }
                                            : () {
                                                setState(() {
                                                  validate = true;
                                                });
                                              },
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.015, horizontal: CommonLogic.textSize * 0.02),
                                          // margin: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01, horizontal: CommonLogic.textSize * 0.02),
                                          decoration: BoxDecoration(
                                            color: deleteAccountController.text.isNotEmpty ? const Color(0xff48B2E7) : Colors.grey,
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Submit",
                                              style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          'assets/images/ecommerce/delete_user.webp',
                          height: CommonLogic.textSize * 0.03,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Delete User",
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: CommonLogic.textSize * 0.02,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              elevation: 5,
                              contentPadding: EdgeInsets.zero,
                              title: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: CommonLogic.textSize * 0.01,
                                  horizontal: CommonLogic.textSize * 0.01,
                                ),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text(
                                    "Are you sure?",
                                    style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.02, color: const Color(0xff707B81), fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: CommonLogic.textSize * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            await FirebaseAuth.instance.signOut().whenComplete(() {
                                              // FirebaseMessaging.instance.deleteToken();
                                              // TODO google sign out here
                                              Authentication.googleSignOut(context);
                                              Navigator.pushReplacement(context, MaterialPageRoute(
                                                builder: (context) {
                                                  return const LoginScreen();
                                                },
                                              ));
                                            });
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.015, horizontal: CommonLogic.textSize * 0.02),
                                            decoration: BoxDecoration(
                                              color: const Color(0xff48B2E7),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Yes",
                                                style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: CommonLogic.textSize * 0.02,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.015, horizontal: CommonLogic.textSize * 0.02),
                                            // margin: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01, horizontal: CommonLogic.textSize * 0.02),
                                            decoration: BoxDecoration(
                                              color: const Color(0xff48B2E7),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "No",
                                                style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            );
                          },
                        );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          'assets/images/ecommerce/logout_ic.webp',
                          height: CommonLogic.textSize * 0.026,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Sign Out",
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: CommonLogic.textSize * 0.02,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: user != null,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "Last login : ${DateFormat("dd-MM-yyyy hh:mm a").format(user!.metadata.lastSignInTime!.toLocal())}",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: CommonLogic.textSize * 0.012,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
      backgroundColor: const Color(0xffF7F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F9),
        leading: Builder(
          builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.016),
                child: Image.asset(
                  "assets/images/ecommerce/menu_ic.webp",
                  height: CommonLogic.textSize * 0.05,
                  width: CommonLogic.textSize * 0.05,
                ),
              ),
            );
          },
        ),
        title: Text(
          "Explore",
          style: GoogleFonts.raleway(
            fontSize: CommonLogic.textSize * 0.03,
            color: const Color(0xff2B2B2B),
            fontWeight: FontWeight.w700,
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
          padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.02),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.02),
              child: TextField(
                controller: searchController,
                style: GoogleFonts.poppins(
                  color: const Color(0xff6A6A6A),
                  fontSize: CommonLogic.textSize * 0.016,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: "Looking for shoes",
                  hintStyle: GoogleFonts.poppins(color: const Color(0xff6A6A6A), fontSize: CommonLogic.textSize * 0.016),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: CommonLogic.textSize * 0.02,
                    horizontal: CommonLogic.textSize * 0.02,
                  ),
                  prefixIcon: Icon(Icons.search, color: const Color(0xff6A6A6A), size: CommonLogic.textSize * 0.025),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.02),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.02),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.02),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      )),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.02),
              child: Text(
                "Select Category",
                style: GoogleFonts.raleway(
                  color: const Color(0xff2B2B2B),
                  fontWeight: FontWeight.w600,
                  fontSize: CommonLogic.textSize * 0.022,
                ),
              ),
            ),
            SizedBox(
              height: CommonLogic.textSize * 0.054,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectCatIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.015, horizontal: CommonLogic.textSize * 0.03),
                      margin: EdgeInsets.only(
                        right: CommonLogic.textSize * 0.02,
                      ),
                      decoration: BoxDecoration(color: selectCatIndex == index ? const Color(0xff48B2E7) : Colors.white, borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.02)),
                      child: Center(
                        child: Text(
                          "All Shoes",
                          style: GoogleFonts.poppins(
                            color: selectCatIndex != index ? const Color(0xff2B2B2B) : Colors.white,
                            fontSize: CommonLogic.textSize * 0.017,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.02),
                  child: Text(
                    "Popular Shoes",
                    style: GoogleFonts.raleway(
                      color: const Color(0xff2B2B2B),
                      fontWeight: FontWeight.w600,
                      fontSize: CommonLogic.textSize * 0.022,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: GoogleFonts.poppins(
                        color: const Color(0xff48B2E7),
                        fontSize: CommonLogic.textSize * 0.02,
                      ),
                    ))
              ],
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: CommonLogic.textSize * 0.00074,
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
                          child: Icon(
                            Icons.favorite,
                            size: CommonLogic.textSize * 0.02,
                            color: const Color(0xffF87265),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02),
                        child: Image.asset(
                          "assets/images/ecommerce/shoes_ic.webp",
                          height: CommonLogic.textSize * 0.155,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02),
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
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01, horizontal: CommonLogic.textSize * 0.01),
                              decoration: BoxDecoration(
                                color: const Color(0xff48B2E7),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(CommonLogic.textSize * 0.02),
                                  bottomRight: Radius.circular(CommonLogic.textSize * 0.02),
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: CommonLogic.textSize * 0.025,
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.02),
                  child: Text(
                    "New Arrivals",
                    style: GoogleFonts.raleway(
                      color: const Color(0xff2B2B2B),
                      fontWeight: FontWeight.w600,
                      fontSize: CommonLogic.textSize * 0.022,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: GoogleFonts.poppins(
                        color: const Color(0xff48B2E7),
                        fontSize: CommonLogic.textSize * 0.02,
                      ),
                    ))
              ],
            ),
            Image.asset(
              'assets/images/ecommerce/banner_ic.webp',
            )
          ]),
        ),
      ),
      bottomNavigationBar: SizedBox(
          height: CommonLogic.textSize * 0.17,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/ecommerce/bottom_nav.webp',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: CommonLogic.textSize * 0.04),
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const MyCartScreen();
                      },
                    ));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: CommonLogic.textSize * 0.02,
                      horizontal: CommonLogic.textSize * 0.01,
                    ),
                    child: CircleAvatar(
                      radius: CommonLogic.textSize * 0.04,
                      backgroundColor: const Color(0xff48B2E7),
                      child: Image.asset(
                        'assets/images/ecommerce/cart_bag.webp',
                        height: CommonLogic.textSize * 0.04,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.03, horizontal: CommonLogic.textSize * 0.02),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: CommonLogic.textSize * 0.01),
                          child: Image.asset(
                            'assets/images/ecommerce/home_ic.webp',
                            height: CommonLogic.textSize * 0.03,
                            color: const Color(0xff48B2E7),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const FavouriteScreen();
                              },
                            ));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.04),
                            child: Image.asset(
                              'assets/images/ecommerce/fav_ic.webp',
                              height: CommonLogic.textSize * 0.03,
                              color: const Color(0xff707B81),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const NotificationScreen();
                              },
                            ));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.04),
                            child: Image.asset(
                              'assets/images/ecommerce/notification_ic.webp',
                              height: CommonLogic.textSize * 0.03,
                              color: const Color(0xff707B81),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const ProfileScreen();
                              },
                            ));
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: CommonLogic.textSize * 0.01),
                            child: Image.asset(
                              'assets/images/ecommerce/profile_ic.webp',
                              height: CommonLogic.textSize * 0.03,
                              color: const Color(0xff707B81),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
