import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/lead%20generate/api_repository/api_repository.dart';
import 'package:test_project/lead%20generate/bloc/data_get_bloc/data_get_bloc.dart';
import 'package:test_project/utilities/common_logic.dart';

class DataListScreen extends StatefulWidget {
  const DataListScreen({super.key});

  @override
  State<DataListScreen> createState() => _DataListScreenState();
}

class _DataListScreenState extends State<DataListScreen> {
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
        title: const Text("Data Screen"),
        backgroundColor: const Color(0xffF7F7F9),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DataGetBloc(HttpRepository())..add(GetDataSheet()),
          )
        ],
        child: blocProviderView(),
      ),
    );
  }

  Widget blocProviderView() {
    return mainVIew();
  }

  Widget mainVIew() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: CommonLogic.textSize * 0.02, vertical: CommonLogic.textSize * 0.02),
      child: Column(children: [
        BlocConsumer<DataGetBloc, DataGetState>(
          builder: (context, state) {
            if (state is DataGetLading) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is DataGetLoaded) {
              state.dataList.removeRange(0, 3);
              return state.dataList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.dataList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              vertical: CommonLogic.textSize * 0.01,
                              horizontal: CommonLogic.textSize * 0.02,
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: CommonLogic.textSize * 0.01,
                              horizontal: CommonLogic.textSize * 0.01,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(CommonLogic.textSize * 0.01),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                )),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text("Name : ${state.dataList[index]!.name}"),
                              Text("Interest : ${state.dataList[index]!.interest}"),
                              Text("Mobile No : ${state.dataList[index]!.mobileNo}"),
                              Text("Designation : ${state.dataList[index]!.designation}"),
                            ]),
                          );
                        },
                      ),
                    )
                  : const Expanded(child: Center(child: Text("No Data Found.")));
            }
            return Container();
          },
          listener: (context, state) {},
        ),
      ]),
    );
  }
}
