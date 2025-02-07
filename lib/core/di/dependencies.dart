import 'package:get_it/get_it.dart';
import 'package:guia_moteis_app/modules/motels/data/motel_repository_impl.dart';
import 'package:http/http.dart' as http;

import '../../modules/motels/data/motel_repository.dart';
import '../../modules/motels/ui/bloc/get_motels_bloc.dart';

GetIt getIt = GetIt.instance;

// Register your dependencies here
Future<void> configureDependencies() async {
  getIt.registerLazySingleton(() => http.Client());

  getIt.registerSingleton<MotelRepository>(
    MotelRepositoryImpl(getIt()),
  );

  getIt.registerFactory<GetMotelsBloc>(
      () => GetMotelsBloc(getIt.get<MotelRepository>()));
}
