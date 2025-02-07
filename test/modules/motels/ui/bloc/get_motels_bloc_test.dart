import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis_app/modules/motels/data/motel_repository.dart';
import 'package:guia_moteis_app/modules/motels/domain/errors/motels_failure.dart';
import 'package:guia_moteis_app/modules/motels/domain/models/motels_result_model.dart';
import 'package:guia_moteis_app/modules/motels/ui/bloc/get_motels_bloc.dart';
import 'package:guia_moteis_app/modules/motels/ui/bloc/get_motels_event.dart';
import 'package:guia_moteis_app/modules/motels/ui/bloc/motels_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';

class MockMotelRepository extends Mock implements MotelRepository {}

void main() {
  late GetMotelsBloc bloc;
  late MockMotelRepository mockRepository;

  setUp(() {
    mockRepository = MockMotelRepository();
    bloc = GetMotelsBloc(mockRepository);
  });

  tearDown(() {
    bloc.close();
  });
  final mockMotels = MotelsResultModel(
    pagina: 1,
    qtdPorPagina: 1,
    totalSuites: 1,
    totalMoteis: 1,
    raio: 1,
    maxPaginas: 1,
    moteis: [],
  );
  group('GetMotelsBloc', () {
    test('o estado inicial deve ser InitialListMotelsState', () {
      expect(bloc.state, equals(InitialListMotelsState()));
    });

    blocTest<GetMotelsBloc, ListMotelsState>(
      'deve emitir [LoadingListMotelsState, LoadedMotelsState] quando FetchMotels for chamado com sucesso',
      build: () {
        when(() => mockRepository.getMotels())
            .thenAnswer((_) async => Right(mockMotels));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchMotels()),
      expect: () => [
        LoadingListMotelsState(),
        LoadedMotelsState(mockMotels),
      ],
    );

    blocTest<GetMotelsBloc, ListMotelsState>(
      'deve emitir [LoadingListMotelsState, ErrorMotelsState] quando FetchMotels falhar',
      build: () {
        when(() => mockRepository.getMotels()).thenAnswer(
            (_) async => Left(GetFailureMotels(errorMessage: 'Erro na API')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchMotels()),
      expect: () => [
        LoadingListMotelsState(),
        ErrorMotelsState(message: 'Erro na API'),
      ],
    );
  });
}
