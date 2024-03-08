part of 'send_lead_bloc.dart';

@immutable
abstract class SendLeadEvent {}

class SendData extends SendLeadEvent {
  final String name;
  final String interest;
  final String mobileNo;
  final String designation;

  SendData(this.name, this.interest, this.mobileNo, this.designation);
}
