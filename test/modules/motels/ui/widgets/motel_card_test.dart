import 'package:flutter/material.dart';
import 'package:flutter_image_test_utils/flutter_image_test_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis_app/modules/motels/domain/models/motel_model.dart';
import 'package:guia_moteis_app/modules/motels/ui/widgets/motel_card_widget.dart';
import 'package:guia_moteis_app/modules/motels/ui/widgets/suite_list_widget.dart';

void main() {
  final mockMotel = MotelModel(
    fantasia: 'Motel Le Nid',
    bairro: 'Chacara Flora',
    logo:
        "https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_1.jpg",
    media: 4.6,
    qtdAvaliacoes: 42,
    suites: [],
    distancia: 28.27,
    qtdFavoritos: 2,
  );
  testWidgets('Should render the MotelCard without errors.',
      (WidgetTester tester) async {
    provideMockedNetworkImages(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotelCardWidget(motel: mockMotel),
          ),
        ),
      );

      expect(find.byType(MotelCardWidget), findsOneWidget);
    });
  });

  testWidgets('Should render correct Motel data', (WidgetTester tester) async {
    provideMockedNetworkImages(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotelCardWidget(motel: mockMotel),
          ),
        ),
      );

      expect(find.text('Motel Le Nid'), findsOneWidget);
      expect(find.text('Chacara Flora'), findsOneWidget);
      expect(find.text('4.6'), findsOneWidget);
      expect(find.text('42 avaliações'), findsOneWidget);

      final circleAvatar =
          tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(
          (circleAvatar.backgroundImage as NetworkImage).url, mockMotel.logo);

      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });

  testWidgets('Should render the suite list correctly',
      (WidgetTester tester) async {
    provideMockedNetworkImages(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MotelCardWidget(motel: mockMotel),
          ),
        ),
      );

      expect(find.byType(SuiteListWidget), findsOneWidget);

      final suiteListWidget =
          tester.widget<SuiteListWidget>(find.byType(SuiteListWidget));
      expect(suiteListWidget.suites, mockMotel.suites);
    });
  });
}
