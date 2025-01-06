import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forms_app/config/router/app_router.dart';

void main() {
  late Widget widget;

  // setUpAll(() => widget = const MaterialApp(home: HomeScreen()));
  setUpAll(() => widget = MaterialApp.router(routerConfig: appRouter));

  group('List Tile Tests', () {
    testWidgets('Find 3 ListTiles', (tester) async {
      await tester.pumpWidget(widget);

      expect(find.byType(ListTile), findsExactly(3));
    });

    testWidgets('Find tiles title in order', (tester) async {
      await tester.pumpWidget(widget);

      final listTiles = find.byType(ListTile);

      expect(listTiles, findsNWidgets(3)); // Asegúrate de que hay 3 ListTiles

      // Verifica el orden de los títulos
      expect(tester.widget<ListTile>(listTiles.at(0)).title,
          isA<Text>().having((t) => t.data, 'text', 'Cubits'));
      expect(tester.widget<ListTile>(listTiles.at(1)).title,
          isA<Text>().having((t) => t.data, 'text', 'Bloc'));
      expect(tester.widget<ListTile>(listTiles.at(2)).title,
          isA<Text>().having((t) => t.data, 'text', 'Nuevo usuario'));
    });
  });

  group('Navigation Tests', () {
    testWidgets('Navigation to Cubit works correctly', (tester) async {
      await tester.pumpWidget(widget);

      // Tap on the 'Cubits' ListTile and verify navigation
      await tester.tap(find.text('Cubits'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Cubit Counter'), findsOneWidget);

      // Navigate back to HomeScreen
      tester.state<NavigatorState>(find.byType(Navigator)).pop();
      await tester.pumpAndSettle();
    });

    testWidgets('Navigation to Bloc works correctly', (tester) async {
      await tester.pumpWidget(widget);

      await tester.tap(find.text('Bloc'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Bloc Counter'), findsOneWidget);

      tester.state<NavigatorState>(find.byType(Navigator)).pop();
      await tester.pumpAndSettle();
    });

    testWidgets('Navigation to Register works correctly', (tester) async {
      await tester.pumpWidget(widget);

      await tester.tap(find.text('Nuevo usuario'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Nuevo usuario'), findsOneWidget);

      tester.state<NavigatorState>(find.byType(Navigator)).pop();
      await tester.pumpAndSettle();
    });
  });
}
