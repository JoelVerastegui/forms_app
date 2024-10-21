import 'package:forms_app/presentation/screens/bloc_counter_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:forms_app/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/cubits',
      name: CubitsCounterScreen.name,
      builder: (context, state) => const CubitsCounterScreen(),
    ),

    GoRoute(
      path: '/bloc',
      name: BlocCounterScreen.name,
      builder: (context, state) => const BlocCounterScreen(),
    )
  ]
);