import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forms_app/main.dart';
import 'package:forms_app/presentation/blocs/counter_bloc/counter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';
import 'package:integration_test/integration_test.dart';

import 'robots/counter_robot.dart';
import 'robots/register_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Cubits screen is working correctly', (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();

    final counterRobot = CounterRobot(tester);
    final defaultCubit = CounterCubit().state;
    int counter = defaultCubit.counter;
    int transactionCount = defaultCubit.transactionCount;

    counterRobot.verifyHome();
    await counterRobot.navigateToCubit();
    expect(find.text('Cubit Counter: $transactionCount'), findsOneWidget);
    expect(find.text('Counter value: $counter'), findsOneWidget);

    await Future.delayed(const Duration(seconds: 1));
    await counterRobot.add3ToCounter();
    counter += 3;
    transactionCount++;

    await Future.delayed(const Duration(seconds: 1));
    await counterRobot.add2ToCounter();
    counter += 2;
    transactionCount++;
    
    expect(find.text('Cubit Counter: $transactionCount'), findsOneWidget);
    expect(find.text('Counter value: $counter'), findsOneWidget);

    await Future.delayed(const Duration(seconds: 1));
    await counterRobot.resetCounter();
    counter = 0;

    await Future.delayed(const Duration(seconds: 1));
    await counterRobot.add1ToCounter();
    counter++;
    transactionCount++;
    
    expect(find.text('Cubit Counter: $transactionCount'), findsOneWidget);
    expect(find.text('Counter value: $counter'), findsOneWidget);

    await Future.delayed(const Duration(seconds: 1));

    await counterRobot.goBack();
    counterRobot.verifyHome();
  });

  testWidgets('Bloc screen is working correctly', (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();

    final counterRobot = CounterRobot(tester);
    final defaultBloc = CounterBloc().state;
    int counter = defaultBloc.counter;
    int transactionCount = defaultBloc.transactionCount;

    counterRobot.verifyHome();
    await counterRobot.navigateToBloc();
    expect(find.text('Bloc Counter: $transactionCount'), findsOneWidget);
    expect(find.text('Counter value: $counter'), findsOneWidget);

    await Future.delayed(const Duration(seconds: 1));
    await counterRobot.add3ToCounter();
    counter += 3;
    transactionCount++;

    await Future.delayed(const Duration(seconds: 1));
    await counterRobot.add2ToCounter();
    counter += 2;
    transactionCount++;
    
    expect(find.text('Bloc Counter: $transactionCount'), findsOneWidget);
    expect(find.text('Counter value: $counter'), findsOneWidget);

    await Future.delayed(const Duration(seconds: 1));
    await counterRobot.resetCounter();
    counter = 0;

    await Future.delayed(const Duration(seconds: 1));
    await counterRobot.add1ToCounter();
    counter++;
    transactionCount++;
    
    expect(find.text('Bloc Counter: $transactionCount'), findsOneWidget);
    expect(find.text('Counter value: $counter'), findsOneWidget);

    await Future.delayed(const Duration(seconds: 1));

    await counterRobot.goBack();
    counterRobot.verifyHome();
  });

  testWidgets('Register screen is working correctly', (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();

    final registerRobot = RegisterRobot(tester);
    String username = 'Michael';
    String email = 'michael@google.com';
    String password = '123456';

    registerRobot.verifyHome();
    await registerRobot.navigateToRegister();

    await Future.delayed(const Duration(seconds: 1));
    await registerRobot.putUsername(username);
    await Future.delayed(const Duration(seconds: 1));
    await registerRobot.putEmail(email);
    await Future.delayed(const Duration(seconds: 1));
    await registerRobot.putPassword(password);
    await Future.delayed(const Duration(seconds: 1));
    await registerRobot.save();

    final registerCubit = BlocProvider.of<RegisterCubit>(tester.element(find.byIcon(Icons.save)));
    expect(registerCubit.state.isValid, equals(true));

    await Future.delayed(const Duration(seconds: 1));

    await registerRobot.goBack();
    registerRobot.verifyHome();
  });

  testWidgets('Register screen is showing errors correctly', (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();

    final registerRobot = RegisterRobot(tester);
    String username = 'five';
    String email = 'email-error@';
    String password = 'five';

    registerRobot.verifyHome();
    await registerRobot.navigateToRegister();

    await Future.delayed(const Duration(seconds: 1));
    await registerRobot.save();

    final registerCubit = BlocProvider.of<RegisterCubit>(tester.element(find.byIcon(Icons.save)));
    await registerRobot.errorUsername(registerCubit.state.username.errorMessage);
    await registerRobot.errorEmail(registerCubit.state.email.errorMessage);
    await registerRobot.errorPassword(registerCubit.state.password.errorMessage);
    await Future.delayed(const Duration(seconds: 2));

    await registerRobot.putUsername(username);
    await registerRobot.errorUsername(registerCubit.state.username.errorMessage);
    await Future.delayed(const Duration(seconds: 2));

    await registerRobot.putEmail(email);
    await registerRobot.errorEmail(registerCubit.state.email.errorMessage);
    await Future.delayed(const Duration(seconds: 2));

    await registerRobot.putPassword(password);
    await registerRobot.errorPassword(registerCubit.state.password.errorMessage);
    await Future.delayed(const Duration(seconds: 2));
    
    await registerRobot.save();

    await Future.delayed(const Duration(seconds: 1));
    expect(registerCubit.state.isValid, equals(false));

    await registerRobot.goBack();
    registerRobot.verifyHome();
  });
}
