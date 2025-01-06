import 'package:forms_app/presentation/blocs/counter_bloc/counter_bloc.dart';
import 'package:test/test.dart';

void main() {
  late CounterState counterState;

  setUp(() => counterState = const CounterState());

  group('State Tests', () {
    test('Default values should be 10 and 0', () {
      expect(counterState.counter, 10);
      expect(counterState.transactionCount, 0);
    });

    test('Instances with same values should be equal', () {
      const state1 = CounterState(counter: 1, transactionCount: 1);
      const state2 = CounterState(counter: 1, transactionCount: 1);
      expect(state1, state2);
    });

    test('Instances with different values should not be equal', () {
      const state1 = CounterState(counter: 1, transactionCount: 1);
      const state2 = CounterState(counter: 2, transactionCount: 2);
      expect(state1, isNot(state2));
    });
  });

  group('Counter Tests', () {
    test('Counter must update to 3', () {
      counterState = counterState.copyWith(counter: 3);

      expect(counterState.counter, 3);
    });

    test('Counter must not update to 5', () {
      counterState = counterState.copyWith(counter: 2);

      expect(counterState.counter, isNot(5));
    });
  });

  group('TransactionCount Tests', () {
    test('TransactionCount must update to 3', () {
      counterState = counterState.copyWith(transactionCount: 3);

      expect(counterState.transactionCount, 3);
    });

    test('TransactionCount must not update to 5', () {
      counterState = counterState.copyWith(transactionCount: 2);

      expect(counterState.transactionCount, isNot(5));
    });
  });
}