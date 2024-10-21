import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  // Constructor
  CounterBloc() : super(const CounterState()) {

    // Event Handlers
    // OPTION 1
    on<CounterIncreased>((event, emit) {
      emit(
        state.copyWith(
          counter: state.counter + event.value,
          transactionCount: state.transactionCount + 1
        )
      );
    });

    on<CounterReset>(_onCounterReset);
  }

  // OPTION 2
  void _onCounterReset(CounterReset event, Emitter<CounterState> emit) {
    emit(
      state.copyWith(
        counter: 0
      )
    );
  }

  // OPTION 3
  void increasedBy([int value = 1]) {
    add(CounterIncreased(value));
  }
}
