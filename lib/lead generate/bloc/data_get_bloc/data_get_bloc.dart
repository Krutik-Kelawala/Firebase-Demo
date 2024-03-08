import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_project/lead%20generate/api_repository/api_repository.dart';
import 'package:test_project/lead%20generate/model/data_get/data_get_model.dart';
import 'package:test_project/widgets/common_widgets.dart';

part 'data_get_event.dart';

part 'data_get_state.dart';

class DataGetBloc extends Bloc<DataGetEvent, DataGetState> {
  final HttpRepository httpRepository;
  late List<DataGetModel?> getDataModel;

  DataGetBloc(this.httpRepository) : super(DataGetInitial()) {
    on<DataGetEvent>((event, emit) async {
      if (event is GetDataSheet) {
        CommonWidgets.printFunction("bloc called");
        emit(DataGetLading());
        await Future.delayed(const Duration(), () async {
          getDataModel = await httpRepository.dataGetFromSheet();
          emit(DataGetLoaded(getDataModel));
        });
      }
    });
  }
}
