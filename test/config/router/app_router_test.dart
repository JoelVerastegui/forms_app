import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forms_app/config/router/app_router.dart';
import 'package:forms_app/presentation/screens/screens.dart';

void main() {
  late Widget widget;
  
  setUp(() {
    widget = MaterialApp.router(routerConfig: appRouter);
  });

  test('Routes quantity is correct', () {
    expect(appRouter.configuration.routes.length, equals(4));
  });

  testWidgets('First widget is rendered by default path', (tester) async {
    await tester.pumpWidget(widget);

    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Navigation to HomeScreen', (tester) async {
    await tester.pumpWidget(widget);

    appRouter.go('/');
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Navigation to CubitsCounterScreen', (tester) async {
    await tester.pumpWidget(widget);

    appRouter.go('/cubits');
    await tester.pumpAndSettle();

    expect(find.byType(CubitsCounterScreen), findsOneWidget);
  });

  testWidgets('Navigation to BlocCounterScreen', (tester) async {
    await tester.pumpWidget(widget);

    appRouter.go('/bloc');
    await tester.pumpAndSettle();

    expect(find.byType(BlocCounterScreen), findsOneWidget);
  });

  testWidgets('Navigation to RegisterScreen', (tester) async {
    await tester.pumpWidget(widget);

    appRouter.go('/new-user');
    await tester.pumpAndSettle();

    expect(find.byType(RegisterScreen), findsOneWidget);
  });
}