import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/utilities/common_logic.dart';
import 'package:test_project/utilities/common_pref.dart';
import 'package:test_project/utilities/custom_colors.dart';
import 'package:test_project/widgets/common_widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> currentSearchList = [];

  // TODO put it to common preference class key & 2 get set method
  /* static String searchList = "search_list";

  static Future<bool> setSearchList(List<String> searchArray) async {
    return await prefs.setStringList(searchList, searchArray);
  }

  static List<String> getSearchList() {
    return prefs.getStringList(searchList) ?? [];
  }*/

  @override
  Widget build(BuildContext context) {
    CommonLogic.initiateHeightWidth(context);

    currentSearchList = CommonSharedPreferences.getSearchList();
    CommonWidgets.printFunction("search array $currentSearchList");

    return Scaffold(
      backgroundColor: CustomColors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: CommonLogic.textSize * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchView(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.015),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      recentTitle(),
                      CommonWidgets.heightBox(CommonLogic.textSize, 0.015),
                      Expanded(
                        child: currentSearchList.isNotEmpty
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: currentSearchList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(top: CommonLogic.textSize * 0.01),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.search,
                                                size: CommonLogic.textSize * 0.025,
                                              ),
                                              // Image.asset(CustomImages.searchIcon, width: CommonLogic.textSize * 0.025, height: CommonLogic.textSize * 0.025),
                                              // const CustomSizeBox(width: 0.015),
                                              Expanded(
                                                child: GestureDetector(
                                                  behavior: HitTestBehavior.translucent,
                                                  onTap: () {
                                                    searchController.text = currentSearchList[index];
                                                  },
                                                  child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: CommonLogic.textSize * 0.01,
                                                        vertical: CommonLogic.textSize * 0.005,
                                                      ),
                                                      child: Text(currentSearchList[index],
                                                          style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.015, color: CustomColors.greyTextColor, fontWeight: FontWeight.w400))),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              currentSearchList.removeAt(index);
                                              CommonSharedPreferences.prefs.remove(CommonSharedPreferences.searchList);
                                              CommonSharedPreferences.setSearchList(currentSearchList);
                                            });
                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.01, vertical: CommonLogic.textSize * 0.005),
                                              child: Icon(
                                                Icons.clear,
                                                size: CommonLogic.textSize * 0.023,
                                              )
                                              /*Image.asset(
                                              CustomImages.cancelIcon,
                                              width: CommonLogic.textSize * 0.022,
                                              height: CommonLogic.textSize * 0.022,
                                            ),*/
                                              ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                            : Center(
                                child: Text(
                                  "No search history found",
                                  style: GoogleFonts.poppins(
                                    fontSize: CommonLogic.textSize * 0.016,
                                    color: CustomColors.blackTextColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container recentTitle() {
    return Container(
        margin: EdgeInsets.only(top: CommonLogic.textSize * 0.03),
        child: Text("Recent Search", style: GoogleFonts.poppins(fontSize: CommonLogic.textSize * 0.0215, color: CustomColors.black, fontWeight: FontWeight.w600)));
  }

  Widget searchView() {
    return Row(
      children: [
        CommonWidgets.widthBox(CommonLogic.textSize, 0.025),
        Container(
          padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01, horizontal: CommonLogic.textSize * 0.005),
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new, size: CommonLogic.textSize * 0.025)),
        ),
        // const CustomSizeBox(width: 0.012),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: CommonLogic.textSize * 0.005,
              horizontal: CommonLogic.textSize * 0.015,
            ),
            child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  // checkValidation();
                },
                style: GoogleFonts.poppins(
                  color: CustomColors.blackTextColor,
                  fontSize: CommonLogic.textSize * 0.018,
                  fontWeight: FontWeight.w400,
                ),
                validator: (value) {
                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                      onTap: searchController.text.isNotEmpty
                          ? () {
                              currentSearchList.add(searchController.text);
                              CommonSharedPreferences.setSearchList(currentSearchList).then((value) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                setState(() {});
                              });
                            }
                          : null,
                      child: Container(
                        color: CustomColors.bgColor,
                        padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.015, horizontal: CommonLogic.textSize * 0.01),
                        child: Icon(
                          Icons.search,
                          size: CommonLogic.textSize * 0.03,
                          color: CustomColors.blackTextColor,
                        ),
                        /*Image.asset(
                          CustomImages.searchIcon,
                          color: CustomColors.mainTextColor,
                          height: CommonLogic.textSize * 0.01,
                        ),*/
                      )),
                  isDense: true,
                  border: const OutlineInputBorder(),
                  hintText: "Search Course....",
                  hintStyle: GoogleFonts.poppins(
                    color: CustomColors.greyTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: CommonLogic.textSize * 0.016,
                  ),
                  errorMaxLines: 2,
                  errorStyle: GoogleFonts.poppins(
                    // color: CustomColors.onboardGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: CommonLogic.textSize * 0.014,
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.003),
                      borderSide: BorderSide(
                        color: CustomColors.red,
                        width: 1,
                      )),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.003),
                      borderSide: BorderSide(
                        color: CustomColors.red,
                        width: 1,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.003),
                      borderSide: BorderSide(
                        color: CustomColors.greyTextColor,
                        width: 1,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.003),
                      borderSide: BorderSide(
                        color: CustomColors.greyTextColor,
                        width: 1,
                      )),
                  // contentPadding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.014, horizontal: CommonLogic.textSize * 0.01),
                  /*   suffixIconConstraints: BoxConstraints(
                          minHeight: CommonLogic.textSize * 0.025,
                          minWidth: CommonLogic.textSize * 0.05,
                        ),*/
                  prefixIcon: Container(
                    padding: EdgeInsets.all(CommonLogic.textSize * 0.0135),
                    child: Icon(
                      Icons.search,
                      size: CommonLogic.textSize * 0.025,
                    ),
                    /*  Image.asset(
                      CustomImages.searchIcon,
                      height: 10,
                      width: 10,
                      // color: CustomColors.black,
                    ),*/
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
