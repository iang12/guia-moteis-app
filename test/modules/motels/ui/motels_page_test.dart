import 'package:flutter/material.dart';
import 'package:flutter_image_test_utils/flutter_image_test_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_moteis_app/modules/motels/domain/models/motel_model.dart';
import 'package:guia_moteis_app/modules/motels/domain/models/motels_result_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';

import 'package:guia_moteis_app/modules/motels/ui/motels_page.dart';
import 'package:guia_moteis_app/modules/motels/ui/bloc/get_motels_bloc.dart';
import 'package:guia_moteis_app/modules/motels/ui/bloc/motels_state.dart';

class MockGetMotelsBloc extends Mock implements GetMotelsBloc {}

void main() {
  late MockGetMotelsBloc mockBloc;
  final getIt = GetIt.instance;

  setUpAll(() {
    mockBloc = MockGetMotelsBloc();

    getIt.registerLazySingleton<GetMotelsBloc>(() => mockBloc);
    when(() => mockBloc.stream)
        .thenAnswer((_) => Stream.value(LoadingListMotelsState()));
  });

  final mockMotels = MotelsResultModel(
    pagina: 1,
    qtdPorPagina: 1,
    totalSuites: 1,
    totalMoteis: 1,
    raio: 1,
    maxPaginas: 1,
    moteis: [
      MotelModel(
        fantasia: 'Motel Le Nid',
        bairro: 'Flora',
        media: 4.5,
        qtdAvaliacoes: 100,
        logo:
            'https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_2.jpg',
        suites: [],
        distancia: 28.27,
        qtdFavoritos: 2,
      ),
    ],
  );
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<GetMotelsBloc>(
        create: (_) => mockBloc,
        child: const MotelsPage(),
      ),
    );
  }

  testWidgets(
      'Should display a loading when the state is LoadingListMotelsState',
      (tester) async {
    when(() => mockBloc.state).thenReturn(LoadingListMotelsState());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'Should display a list of motels when the state is LoadedMotelsState',
      (tester) async {
    provideMockedNetworkImages(() async {
      when(() => mockBloc.stream)
          .thenAnswer((_) => Stream.value(LoadedMotelsState(mockMotels)));
      when(() => mockBloc.state).thenReturn(LoadedMotelsState(mockMotels));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Motel Le Nid'), findsOneWidget);
      expect(find.byKey(Key('motels_list')), findsWidgets);
    });
  });

  testWidgets(
      'Should display an error Snackbar when the state is ErrorMotelsState',
      (tester) async {
    when(() => mockBloc.state)
        .thenReturn(ErrorMotelsState(message: 'Erro ao carregar motéis'));
    when(() => mockBloc.stream).thenAnswer((_) =>
        Stream.value(ErrorMotelsState(message: 'Erro ao carregar motéis')));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('Erro ao carregar motéis'), findsOneWidget);
  });
}
