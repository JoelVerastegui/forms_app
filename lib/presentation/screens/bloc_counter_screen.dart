import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_bloc/counter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  static String name = 'bloc_counter_screen';

  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const _BlocCounterView()
    );
  }
}

class _BlocCounterView extends StatelessWidget {
  const _BlocCounterView();

  void _increaseCounter(BuildContext context, [int value = 1]) {
    context.read<CounterBloc>().add(
      CounterIncreased(value)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select((CounterBloc bloc) {
          return Text('Bloc Counter: ${bloc.state.transactionCount}');
        }),
        actions: [
          IconButton(
            onPressed: () => context.read<CounterBloc>().add(const CounterReset()), 
            icon: const Icon(Icons.refresh_outlined)
          )
        ],
      ),
      body: Center(
        child: context.select((CounterBloc value) {
          return Text('Counter value: ${value.state.counter}');
        },),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 1,
            onPressed: () => _increaseCounter(context, 3),
            child: const Text('+3'),
          ),
    
          const SizedBox(height: 10),
    
          FloatingActionButton(
            heroTag: 2,
            onPressed: () => context.read<CounterBloc>().increasedBy(2),
            child: const Text('+2'),
          ),
    
          const SizedBox(height: 10),
    
          FloatingActionButton(
            heroTag: 3,
            onPressed: () => _increaseCounter(context),
            child: const Text('+1'),
          ),
        ],
      ),
    );
  }
}