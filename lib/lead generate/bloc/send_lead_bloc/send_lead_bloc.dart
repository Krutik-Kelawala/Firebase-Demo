import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_project/lead%20generate/api_repository/api_repository.dart';
import 'package:test_project/lead%20generate/model/send_lead/send_lead_model.dart';
import 'package:test_project/widgets/common_widgets.dart';

part 'send_lead_event.dart';

part 'send_lead_state.dart';

class SendLeadBloc extends Bloc<SendLeadEvent, SendLeadState> {
  final HttpRepository httpRepository;
  late SendLeadModel? leadModel;

  SendLeadBloc(this.httpRepository) : super(SendLeadInitial()) {
    on<SendLeadEvent>((event, emit) async {
      if (event is SendData) {
        CommonWidgets.printFunction("bloc called");
        emit(SendLeadLoading());
        await Future.delayed(const Duration(), () async {
          leadModel = await httpRepository.sendExcelData(
            event.name,
            event.interest,
            event.mobileNo,
            event.designation,
          );
          emit(SendLeadLoaded(leadModel!));
        });
      }
    });
  }
}
