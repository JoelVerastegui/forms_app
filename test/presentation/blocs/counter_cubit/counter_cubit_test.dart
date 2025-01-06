import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';
import 'package:test/test.dart';

void main() {
  late CounterCubit counterCubit;

  setUp(() => counterCubit = CounterCubit());

  group('State Tests', () {
    test('Default values must be 5 and 0', () {
      expect(counterCubit.state.counter, 5);
      expect(counterCubit.state.transactionCount, 0);
    });

    test('CounterState must be different to Cubit state', () {
      const CounterState counterState = CounterState();
      expect(counterCubit.state, isNot(counterState));
    });

    test('CounterState must be equal to Cubit state', () {
      CounterState counterState = const CounterState();

      counterState = counterState.copyWith(counter: 5);

      expect(counterCubit.state, counterState);
    });
  });

  group('IncreasedBy Tests', () {
    test('Counter must be 8 and TransactionCount must be 1', () {
      counterCubit.increaseBy(3);
      expect(counterCubit.state.counter, 8);
      expect(counterCubit.state.transactionCount, 1);
    });

    test('Counter must be -10 and TransactionCount must be 1', () {
      counterCubit.increaseBy(-15);
      expect(counterCubit.state.counter, -10);
      expect(counterCubit.state.transactionCount, 1);
    });

    test('Counter must be 16 and TransactionCount must be 3', () {
      counterCubit.increaseBy(6);
      counterCubit.increaseBy(3);
      counterCubit.increaseBy(2);
      expect(counterCubit.state.counter, 16);
      expect(counterCubit.state.transactionCount, 3);
    });

    test('Counter must be -7 and TransactionCount must be 4', () {
      counterCubit.increaseBy(2);
      counterCubit.increaseBy(-3);
      counterCubit.increaseBy(-6);
      counterCubit.increaseBy(-5);
      expect(counterCubit.state.counter, -7);
      expect(counterCubit.state.transactionCount, 4);
    });

    test('CounterState must be equal to Cubit state after IncreaseBy', () {
      CounterState counterState = const CounterState();

      counterState = counterState.copyWith(counter: 15, transactionCount: 5);

      counterCubit.increaseBy(2);
      counterCubit.increaseBy(2);
      counterCubit.increaseBy(3);
      counterCubit.increaseBy(2);
      counterCubit.increaseBy(1);

      expect(counterCubit.state, counterState);
    });
  });

  group('Reset Tests', () {
    test('Counter and TransactionCount must be 0', () {
      counterCubit.reset();
      counterCubit.reset();
      counterCubit.reset();
      expect(counterCubit.state.counter, 0);
      expect(counterCubit.state.transactionCount, 0);
    });

    test('Counter must be 0 and TransactionCount must be 4', () {
      counterCubit.increaseBy(2);
      counterCubit.increaseBy(6);
      counterCubit.increaseBy(14);
      counterCubit.increaseBy(8);
      counterCubit.reset();
      expect(counterCubit.state.counter, 0);
      expect(counterCubit.state.transactionCount, 4);
    });

    test('Counter must be 4 and TransactionCount must be 4', () {
      counterCubit.increaseBy(6);
      counterCubit.increaseBy(8);
      counterCubit.reset();
      counterCubit.increaseBy(11);
      counterCubit.reset();
      counterCubit.increaseBy(4);
      expect(counterCubit.state.counter, 4);
      expect(counterCubit.state.transactionCount, 4);
    });

    test('CounterState must be equal to Cubit state after Reset', () {
      CounterState counterState = const CounterState();

      counterState = counterState.copyWith(counter: 1, transactionCount: 4);

      counterCubit.increaseBy(2);
      counterCubit.increaseBy(2);
      counterCubit.increaseBy(3);
      counterCubit.reset();
      counterCubit.increaseBy(1);

      expect(counterCubit.state, counterState);
    });
  });
}