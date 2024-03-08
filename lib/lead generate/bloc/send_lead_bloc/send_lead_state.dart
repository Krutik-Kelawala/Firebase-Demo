part of 'send_lead_bloc.dart';

@immutable
abstract class SendLeadState {}

class SendLeadInitial extends SendLeadState {}

class SendLeadLoading extends SendLeadState {}

class SendLeadLoaded extends SendLeadState {
  final SendLeadModel sendLeadModel;

  SendLeadLoaded(this.sendLeadModel);
}

class SendLeadError extends SendLeadState {}
