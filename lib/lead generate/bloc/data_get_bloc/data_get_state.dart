part of 'data_get_bloc.dart';

@immutable
abstract class DataGetState {}

class DataGetInitial extends DataGetState {}

class DataGetLoaded extends DataGetState {
  final List<DataGetModel?> dataList;

  DataGetLoaded(this.dataList);
}

class DataGetLading extends DataGetState {}

class DataGetError extends DataGetState {}
