import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/lead%20generate/api_repository/api_repository.dart';
import 'package:test_project/lead%20generate/bloc/send_lead_bloc/send_lead_bloc.dart';
import 'package:test_project/utilities/common_logic.dart';
import 'package:test_project/widgets/common_widgets.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  late BuildContext apiContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dataGet();
  }

  dataGet() {
    HttpRepository repository = HttpRepository();
    repository.dataGetFromSheet();
  }

  @override
  Widget build(BuildContext context) {
    CommonLogic.initiateHeightWidth(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Screen"),
        backgroundColor: const Color(0xffF7F7F9),
      ),
      body: SingleChildScrollView(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SendLeadBloc(HttpRepository()),
            ),
          ],
          child: blocProviderView(),
        ),
      ),
    );
  }

  Widget blocProviderView() {
    return Stack(
      children: [
        BlocConsumer<SendLeadBloc, SendLeadState>(
          builder: (context, state) {
            apiContext = context;
            return mainVIew();
          },
          listener: (context, state) {
            if (state is SendLeadLoaded) {
              CommonWidgets.commonSuccessToast("Data add successfully!", context);
            }
          },
        ),
      ],
    );
  }

  Widget mainVIew() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.02),
      child: Column(children: [
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
        Container(
          padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.02),
          child: TextField(
            controller: interestController,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
              fillColor: const Color(0xffF7F7F9),
              filled: true,
              hintText: "Enter your interest",
              hintStyle: GoogleFonts.poppins(
                fontSize: CommonLogic.textSize * 0.02,
                fontWeight: FontWeight.w400,
                color: const Color(0xff6A6A6A),
              ),
            ),
            style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: const Color(0xff2B2B2B)),
          ),
        ),
        TextField(
          controller: mobileNoController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
            fillColor: const Color(0xffF7F7F9),
            filled: true,
            hintText: "Enter your mobile number",
            hintStyle: GoogleFonts.poppins(
              fontSize: CommonLogic.textSize * 0.02,
              fontWeight: FontWeight.w400,
              color: const Color(0xff6A6A6A),
            ),
          ),
          style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: const Color(0xff2B2B2B)),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.02),
          child: TextField(
            controller: designationController,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
              fillColor: const Color(0xffF7F7F9),
              filled: true,
              hintText: "Enter your designation",
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
          onTap: () {
            if (nameController.text.isEmpty) {
              CommonWidgets.commonErrorToast("Please enter your name", context);
            } else if (mobileNoController.text.isEmpty) {
              CommonWidgets.commonErrorToast("Please enter your mobile no", context);
            } else if (interestController.text.isEmpty) {
              CommonWidgets.commonErrorToast("Please enter your interest", context);
            } else if (designationController.text.isEmpty) {
              CommonWidgets.commonErrorToast("Please enter your designation", context);
            } else {
              HttpRepository httpRepo = HttpRepository();
              httpRepo
                  .sendExcelData(
                nameController.text,
                interestController.text,
                mobileNoController.text,
                designationController.text,
              )
                  .whenComplete(() {
                Navigator.pop(context);
                CommonWidgets.commonSuccessToast("Data add successfully!", context);
              });
              /*  apiContext.read<SendLeadBloc>().add(
                    SendData(
                      nameController.text,
                      interestController.text,
                      mobileNoController.text,
                      designationController.text,
                    ),
                  );*/
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.02),
            padding: EdgeInsets.symmetric(vertical: CommonLogic.textSize * 0.01, horizontal: CommonLogic.textSize * 0.05),
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.02)),
            child: Text(
              "Submit",
              style: GoogleFonts.raleway(fontSize: CommonLogic.textSize * 0.02, fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
