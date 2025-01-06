import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forms_app/main.dart';
import 'package:forms_app/config/router/app_router.dart';
import 'package:forms_app/presentation/screens/home_screen.dart';

void main() {
  testWidgets('MainApp initializes correctly', (tester) async {
    await tester.pumpWidget(const MainApp());

    // Verifica que el MaterialApp.router se inicializa correctamente
    expect(find.byType(MaterialApp), findsOneWidget);

    // Verifica que el routerConfig es el correcto
    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.routerConfig, equals(appRouter));

    // Verifica que el tema es el correcto
    // final theme = Theme.of(tester.element(find.byType(MaterialApp)));
    // expect(theme, equals(AppTheme().getTheme()));
    // ESTO DEBERIA SER CORRECTO PERO NO FUNCIONA
  });

  testWidgets('Initial route is HomeScreen', (tester) async {
    await tester.pumpWidget(const MainApp());

    // Verifica que la ruta inicial es HomeScreen
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}