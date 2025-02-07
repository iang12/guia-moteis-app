import 'package:flutter/material.dart';
import 'package:flutter_image_test_utils/image_test/image_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:guia_moteis_app/modules/motels/domain/models/periodo_model.dart';
import 'package:guia_moteis_app/modules/motels/domain/models/suite_model.dart';
import 'package:guia_moteis_app/modules/motels/ui/widgets/suite_card_widget.dart';
import 'package:mocktail/mocktail.dart';

class NetworkImageMock extends Mock implements NetworkImage {}

void main() {
  testWidgets('Should display suite details correctly', (tester) async {
    final suiteMock = SuiteModel(
      nome: 'Suíte Premium',
      fotos: [
        'https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_4.jpg'
      ],
      categoriaItens: [
        CategoriaItenSuite(
          icone:
              'https://cdn.guiademoteis.com.br/Images/itens-suites/arcondicionado-04-09-2018-12-13.png',
          nome: 'Internet Wi-Fi',
        ),
      ],
      periodos: [
        PeriodoModel(
          tempoFormatado: '2h',
          valorTotal: 150.0,
          tempo: '3',
          valor: 88,
          temCortesia: false,
          desconto: null,
        ),
      ],
      qtd: 1,
      exibirQtdDisponiveis: true,
      itens: ['ducha dupla', 'TV a cabo'],
    );
    provideMockedNetworkImages(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SuiteCardWidget(suite: suiteMock),
          ),
        ),
      );

      expect(find.text('Suíte Premium'), findsOneWidget);

      expect(find.text('2h'), findsOneWidget);

      expect(find.textContaining('R\$ 150,00'), findsOneWidget);

      expect(find.byType(Image), findsWidgets);

      expect(find.byType(ClipRRect), findsNWidgets(2));

      await tester.pumpAndSettle();
    });
  });
}
