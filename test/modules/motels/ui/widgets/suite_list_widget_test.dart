import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis_app/modules/motels/domain/models/suite_model.dart';
import 'package:guia_moteis_app/modules/motels/ui/widgets/suite_card_widget.dart';
import 'package:guia_moteis_app/modules/motels/ui/widgets/suite_list_widget.dart';

void main() {
  testWidgets('Should render a list of suites', (tester) async {
    final List<SuiteModel> mockSuites = [];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SuiteListWidget(suites: mockSuites),
        ),
      ),
    );

    expect(find.byType(SuiteCardWidget), findsNWidgets(mockSuites.length));

    for (var suite in mockSuites) {
      expect(find.text(suite.nome), findsOneWidget);
    }
  });
}
