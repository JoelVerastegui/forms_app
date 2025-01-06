import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';
import 'package:forms_app/presentation/screens/cubits_counter_screen.dart';

void main() {
  late Widget widget;
  late int counter;
  late int transactionCount;

  setUp(() {
    widget = const MaterialApp(home: CubitsCounterScreen());
    counter = CounterCubit().state.counter;
    transactionCount = CounterCubit().state.transactionCount;
  });

  group('Components Tests', () {
    testWidgets('Widget title exists', (tester) async {
      await tester.pumpWidget(widget);

      expect(find.textContaining('Cubit Counter'), findsOneWidget);
    });

    testWidgets('BlocProvider<CounterCubit> exists', (tester) async {
      await tester.pumpWidget(widget);

      expect(find.byType(BlocProvider<CounterCubit>), findsOneWidget);
    });

    testWidgets('Reset button exists', (tester) async {
      await tester.pumpWidget(widget);

      expect(find.byIcon(Icons.refresh_outlined), findsOneWidget);
    });

    testWidgets('Floating action button exists', (tester) async {
      await tester.pumpWidget(widget);

      expect(find.byType(FloatingActionButton), findsExactly(3));
    });
  });

  group('Counter Tests', () {
    testWidgets('Counter starts with constructor value', (tester) async {
      await tester.pumpWidget(widget);

      expect(find.text('Counter value: $counter'), findsOneWidget);
    });

    testWidgets('Counter increased by 3', (tester) async {
      await tester.pumpWidget(widget);

      final plus3Button = find.byType(FloatingActionButton).at(0);

      await tester.tap(plus3Button);
      counter += 3;

      await tester.pump();

      expect(find.text('Counter value: $counter'), findsOneWidget);

      await tester.tap(plus3Button);
      counter += 3;

      await tester.tap(plus3Button);
      counter += 3;

      await tester.pump();

      expect(find.text('Counter value: $counter'), findsOneWidget);
    });

    testWidgets('Counter increased by 2', (tester) async {
      await tester.pumpWidget(widget);

      final plus2Button = find.byType(FloatingActionButton).at(1);

      await tester.tap(plus2Button);
      counter += 2;

      await tester.pump();

      expect(find.text('Counter value: $counter'), findsOneWidget);

      await tester.tap(plus2Button);
      counter += 2;

      await tester.tap(plus2Button);
      counter += 2;

      await tester.pump();

      expect(find.text('Counter value: $counter'), findsOneWidget);
    });

    testWidgets('Counter increased by 1', (tester) async {
      await tester.pumpWidget(widget);

      final plus1Button = find.byType(FloatingActionButton).at(2);

      await tester.tap(plus1Button);
      counter++;

      await tester.pump();

      expect(find.text('Counter value: $counter'), findsOneWidget);

      await tester.tap(plus1Button);
      counter++;

      await tester.tap(plus1Button);
      counter++;

      await tester.pump();

      expect(find.text('Counter value: $counter'), findsOneWidget);
    });

    testWidgets('Counter reset to 0', (tester) async {
      await tester.pumpWidget(widget);

      final resetButton = find.byIcon(Icons.refresh_outlined);

      await tester.tap(resetButton);
      await tester.pump();

      final add3Button = find.byType(FloatingActionButton).at(0);

      await tester.tap(add3Button);
      await tester.tap(resetButton);
      await tester.pump();

      expect(find.text('Counter value: 0'), findsOneWidget);
    });
  });

  group('TransactionCount Tests', () {
    testWidgets('TransactionCount starts with constructor value',
        (tester) async {
      await tester.pumpWidget(widget);

      expect(find.text('Cubit Counter: $transactionCount'), findsOneWidget);
    });

    testWidgets('TransactionCount increased by 1 per transaction',
        (tester) async {
      await tester.pumpWidget(widget);

      final floatingButtons = find.byType(FloatingActionButton);
      final add3Button = floatingButtons.at(0);
      final add2Button = floatingButtons.at(1);
      final add1Button = floatingButtons.at(2);

      await tester.tap(add3Button);
      transactionCount++;

      await tester.pump();

      expect(find.text('Cubit Counter: $transactionCount'), findsOneWidget);

      await tester.tap(add2Button);
      transactionCount++;

      await tester.tap(add1Button);
      transactionCount++;

      await tester.pump();

      expect(find.text('Cubit Counter: $transactionCount'), findsOneWidget);
    });

    testWidgets('TransactionCount do not increment on reset counter',
        (tester) async {
      await tester.pumpWidget(widget);

      final floatingButtons = find.byType(FloatingActionButton);
      final add3Button = floatingButtons.at(0);
      final add2Button = floatingButtons.at(1);
      final add1Button = floatingButtons.at(2);
      final resetButton = find.byIcon(Icons.refresh_outlined);

      await tester.tap(add3Button);
      transactionCount++;

      await tester.tap(add2Button);
      transactionCount++;

      await tester.tap(add1Button);
      transactionCount++;

      await tester.pump();

      expect(find.text('Cubit Counter: $transactionCount'), findsOneWidget);

      await tester.tap(resetButton);
      await tester.pump();

      expect(find.text('Cubit Counter: $transactionCount'), findsOneWidget);
    });
  });
}
