import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:guia_moteis_app/modules/splash/ui/splash_page.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      routes: {
        '/': (context) => SplashPage(),
        '/motels': (context) => Scaffold(body: Text('Motels Page')),
      },
      navigatorObservers: [mockObserver],
    );
  }

  testWidgets('Should display logo and loading text', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(Image), findsOneWidget);

    expect(find.text('Carregando...'), findsOneWidget);
  });

  testWidgets('Should navigate to "/motels" after 4 seconds', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(const Duration(seconds: 5));

    verify(() => mockObserver.didReplace(
          newRoute: any(named: 'newRoute'),
          oldRoute: any(named: 'oldRoute'),
        )).called(1);
  });
}
