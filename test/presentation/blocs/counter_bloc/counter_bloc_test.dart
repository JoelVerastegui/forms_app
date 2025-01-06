import 'package:forms_app/presentation/blocs/counter_bloc/counter_bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  late int initialCounter;

  setUp(() {
    initialCounter = CounterBloc().state.counter;
  });

  group('State Tests', () {
    test('Default values must be initial values', () {
      CounterBloc counterBloc = CounterBloc();
      CounterState counterState = const CounterState();
      expect(counterBloc.state.counter, counterState.counter);
      expect(counterBloc.state.transactionCount, counterState.transactionCount);
    });

    test('CounterState must be equal to Bloc state', () {
      CounterBloc counterBloc = CounterBloc();
      const CounterState counterState = CounterState();
      expect(counterBloc.state, counterState);
    });

    test('CounterState must be different to Bloc state', () {
      CounterBloc counterBloc = CounterBloc();
      CounterState counterState = const CounterState();
      counterState = counterState.copyWith(counter: 5);

      expect(counterBloc.state, isNot(counterState));
    });
  });

  group('IncreasedBy Tests', () {

    blocTest<CounterBloc, CounterState>(
      'Counter must increase positive value',
      build: () => CounterBloc(),
      act: (bloc) => bloc.add(const CounterIncreased(3)),
      expect: () => <CounterState>[CounterState(counter: initialCounter + 3, transactionCount: 1)],
    );

    blocTest<CounterBloc, CounterState>(
      'Counter must decrease negative value',
      build: () => CounterBloc(),
      act: (bloc) => bloc.add(const CounterIncreased(-15)),
      expect: () => <CounterState>[CounterState(counter: initialCounter - 15, transactionCount: 1)],
    );

    blocTest<CounterBloc, CounterState>(
      'Counter must handle zero increment',
      build: () => CounterBloc(),
      act: (bloc) => bloc.add(const CounterIncreased(0)),
      expect: () => <CounterState>[CounterState(counter: initialCounter, transactionCount: 1)],
    );

    blocTest<CounterBloc, CounterState>(
      'Counter must handle large increment',
      build: () => CounterBloc(),
      act: (bloc) => bloc.add(const CounterIncreased(1000000)),
      expect: () => <CounterState>[CounterState(counter: initialCounter + 1000000, transactionCount: 1)],
    );

    blocTest<CounterBloc, CounterState>(
      'Counter must increase positive values',
      build: () => CounterBloc(),
      act: (bloc) {
        bloc.add(const CounterIncreased(6));
        bloc.add(const CounterIncreased(3));
        bloc.add(const CounterIncreased(2));
      },
      expect: () => <CounterState>[
        CounterState(counter: initialCounter + 6, transactionCount: 1),
        CounterState(counter: initialCounter + 6 + 3, transactionCount: 2),
        CounterState(counter: initialCounter + 6 + 3 + 2, transactionCount: 3),
      ],
    );

    blocTest<CounterBloc, CounterState>(
      'Counter must increase positive value and decrease negative values',
      build: () => CounterBloc(),
      act: (bloc) {
        bloc.increasedBy(6);
        bloc.increasedBy(-3);
        bloc.increasedBy(-6);
        bloc.increasedBy(-5);
      },
      expect: () => <CounterState>[
        CounterState(counter: initialCounter + 6, transactionCount: 1),
        CounterState(counter: initialCounter + 6 - 3, transactionCount: 2),
        CounterState(counter: initialCounter + 6 - 3 - 6, transactionCount: 3),
        CounterState(counter: initialCounter + 6 - 3 - 6 - 5, transactionCount: 4),
      ],
    );

    blocTest<CounterBloc, CounterState>(
      'CounterState must be equal to Bloc state after IncreaseBy',
      build: () => CounterBloc(),
      act: (bloc) {
        bloc.increasedBy(2);
        bloc.increasedBy(2);
        bloc.increasedBy(3);
        bloc.increasedBy(2);
        bloc.increasedBy();
      },
      expect: () {
        CounterState counterState = const CounterState();
        counterState = counterState.copyWith(counter: 20, transactionCount: 5);
        
        return <CounterState>[
          CounterState(counter: initialCounter + 2, transactionCount: 1),
          CounterState(counter: initialCounter + 2 + 2, transactionCount: 2),
          CounterState(counter: initialCounter + 2 + 2 + 3, transactionCount: 3),
          CounterState(counter: initialCounter + 2 + 2 + 3 + 2, transactionCount: 4),
          counterState,
        ];
      },
    );
  });

  group('Reset Tests', () {
    blocTest<CounterBloc, CounterState>(
      'Counter and TransactionCount must be 0',
      build: () => CounterBloc(),
      act: (bloc) {
        bloc.add(const CounterReset());
        bloc.add(const CounterReset());
        bloc.add(const CounterReset());
      },
      expect: () => const <CounterState>[
        CounterState(counter: 0, transactionCount: 0),
      ],
    );

    blocTest<CounterBloc, CounterState>(
      'Counter must be 0 and TransactionCount must be 4',
      build: () => CounterBloc(),
      act: (bloc) {
        bloc.increasedBy(2);
        bloc.increasedBy(6);
        bloc.increasedBy(14);
        bloc.increasedBy(8);
        bloc.add(const CounterReset());
      },
      expect: () => <CounterState>[
        CounterState(counter: initialCounter + 2, transactionCount: 1),
        CounterState(counter: initialCounter + 2 + 6, transactionCount: 2),
        CounterState(counter: initialCounter + 2 + 6 + 14, transactionCount: 3),
        CounterState(counter: initialCounter + 2 + 6 + 14 + 8, transactionCount: 4),
        const CounterState(counter: 0, transactionCount: 4),
      ],
    );

    blocTest<CounterBloc, CounterState>(
      'Counter must be 4 and TransactionCount must be 4',
      build: () => CounterBloc(),
      act: (bloc) => {
        bloc.increasedBy(6),
        bloc.increasedBy(8),
        bloc.add(const CounterReset()),
        bloc.increasedBy(-11),
        bloc.add(const CounterReset()),
        bloc.increasedBy(4),
      },
      expect: () => <CounterState>[
        CounterState(counter: initialCounter + 6, transactionCount: 1),
        CounterState(counter: initialCounter + 6 + 8, transactionCount: 2),
        const CounterState(counter: 0, transactionCount: 2),
        const CounterState(counter: -11, transactionCount: 3),
        const CounterState(counter: 0, transactionCount: 3),
        const CounterState(counter: 4, transactionCount: 4),
      ],
    );

    blocTest<CounterBloc, CounterState>(
      'CounterState must be equal to Bloc state after Reset',
      build: () => CounterBloc(),
      act: (bloc) {
        

        bloc.increasedBy(2);
        bloc.increasedBy(2);
        bloc.increasedBy(3);
        bloc.add(const CounterReset());
        bloc.increasedBy(1);
      },
      expect: () {
        CounterState counterState = const CounterState();
        counterState = counterState.copyWith(counter: 1, transactionCount: 4);

        return <CounterState>[
          CounterState(counter: initialCounter + 2, transactionCount: 1),
          CounterState(counter: initialCounter + 2 + 2, transactionCount: 2),
          CounterState(counter: initialCounter + 2 + 2 + 3, transactionCount: 3),
          const CounterState(counter: 0, transactionCount: 3),
          counterState
        ];
      },
    );
  });
}