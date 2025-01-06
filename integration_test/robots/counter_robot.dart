import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forms_app/presentation/screens/bloc_counter_screen.dart';
import 'package:forms_app/presentation/screens/cubits_counter_screen.dart';
import 'package:forms_app/presentation/screens/home_screen.dart';

class CounterRobot {
  final WidgetTester tester;

  const CounterRobot(this.tester);

  void verifyHome() {
    expect(find.byType(HomeScreen), findsOneWidget);
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
  }

  Future<void> navigateToCubit() async {
    final cubitsButton = find.byType(ListTile).at(0);

    await tester.tap(cubitsButton);
    await tester.pumpAndSettle();

    expect(find.byType(CubitsCounterScreen), findsOneWidget);
  }

  Future<void> navigateToBloc() async {
    final blocButton = find.byType(ListTile).at(1);

    await tester.tap(blocButton);
    await tester.pumpAndSettle();

    expect(find.byType(BlocCounterScreen), findsOneWidget);
  }

  Future<void> add3ToCounter() async {
    final add3Button = find.byType(FloatingActionButton).at(0);

    await tester.tap(add3Button);
    await tester.pump();
  }

  Future<void> add2ToCounter() async {
    final add2Button = find.byType(FloatingActionButton).at(1);

    await tester.tap(add2Button);
    await tester.pump();
  }

  Future<void> add1ToCounter() async {
    final add1Button = find.byType(FloatingActionButton).at(2);

    await tester.tap(add1Button);
    await tester.pump();
  }

  Future<void> resetCounter() async {
    final iconButton = find.byIcon(Icons.refresh_outlined);

    await tester.tap(iconButton);
    await tester.pump();
  }
}