import 'package:equatable/equatable.dart';

import '../../domain/models/motels_result_model.dart';

sealed class ListMotelsState extends Equatable {}

class InitialListMotelsState extends ListMotelsState {
  @override
  List<Object> get props => [];
}

class LoadingListMotelsState extends ListMotelsState {
  @override
  List<Object> get props => [];
}

class LoadedMotelsState extends ListMotelsState {
  final MotelsResultModel motel;
  LoadedMotelsState(this.motel);

  @override
  List<Object> get props => [];
}

class ErrorMotelsState extends ListMotelsState {
  final String message;
  ErrorMotelsState({required this.message});
  @override
  List<Object> get props => [];
}
