import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/motel_repository.dart';
import 'get_motels_event.dart';
import 'motels_state.dart';

class GetMotelsBloc extends Bloc<MotelsEvent, ListMotelsState> {
  final MotelRepository repository;

  GetMotelsBloc(this.repository) : super(InitialListMotelsState()) {
    on<FetchMotels>((event, emit) async {
      emit(LoadingListMotelsState());
      final result = await repository.getMotels();
      result.fold(
        (error) {
          emit(ErrorMotelsState(message: error.errorMessage.toString()));
        },
        (motels) {
          emit(LoadedMotelsState(motels));
        },
      );
    });
  }
}
