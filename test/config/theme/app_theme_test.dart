import 'package:flutter/material.dart';
import 'package:forms_app/config/theme/app_theme.dart';
import 'package:test/test.dart';

void main() {
  late ThemeData appTheme;

  setUp(() => appTheme = AppTheme().getTheme());

  test('AppTheme uses Material3', () {
    expect(appTheme.useMaterial3, true);
  });

  test('AppTheme can change primary color seed', () {
    const Color newColor = Colors.red;
    final newTheme = appTheme.copyWith(
      colorScheme: appTheme.colorScheme.copyWith(primary: newColor),
      listTileTheme: appTheme.listTileTheme.copyWith(iconColor: newColor),
    );
    expect(newTheme.colorScheme.primary, newColor);
    expect(newTheme.listTileTheme.iconColor, newColor);
  });
}