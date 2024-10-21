import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitsCounterScreen extends StatelessWidget {
  static String name = 'cubits_counter_screen';

  const CubitsCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const _CubitsCounterView()
    );
  }
}

class _CubitsCounterView extends StatelessWidget {
  const _CubitsCounterView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select((CounterCubit value) {
          return Text('Cubit Counter: ${value.state.transactionCount}');
        }),
        actions: [
          IconButton(
            onPressed: () => context.read<CounterCubit>().reset(), 
            icon: const Icon(Icons.refresh_outlined)
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, CounterState>(
          builder: (context, state) {
            return Text('Counter value: ${state.counter}');
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 1,
            onPressed: () => context.read<CounterCubit>().increaseBy(3),
            child: const Text('+3'),
          ),
    
          const SizedBox(height: 15),
    
          FloatingActionButton(
            heroTag: 2,
            onPressed: () => context.read<CounterCubit>().increaseBy(2),
            child: const Text('+2'),
          ),
    
          const SizedBox(height: 15),
    
          FloatingActionButton(
            heroTag: 3,
            onPressed: () => context.read<CounterCubit>().increaseBy(1),
            child: const Text('+1'),
          ),
        ],
      ),
    );
  }
}