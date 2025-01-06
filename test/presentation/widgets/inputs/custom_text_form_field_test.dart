// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forms_app/presentation/widgets/inputs/custom_text_form_field.dart';

void main() {
  testWidgets('Default values are equals to null values', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomTextFormField(),
        )
      )
    );

    final textFormField = find.byType(TextFormField);
    final textFormFieldWidget = tester.widget<TextFormField>(textFormField);
    
    final customTextFormField = find.byType(CustomTextFormField);
    final customTextFormFieldWidget = tester.widget<CustomTextFormField>(customTextFormField);

    expect(customTextFormFieldWidget.label, isNull);
    expect(customTextFormFieldWidget.hint, isNull);
    expect(customTextFormFieldWidget.errorMessage, isNull);
    expect(textFormFieldWidget.onChanged, isNull);
    expect(textFormFieldWidget.validator, isNull);
    expect(customTextFormFieldWidget.obscureText, isNull);
  });

  testWidgets('Instance with initial values are not null', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextFormField(
            label: 'Test Field',
            hint: 'Enter a text sample',
            errorMessage: 'This is my error message',
            onChanged: (_) {},
            validator: (_) {return;},
            obscureText: false,
          ),
        )
      )
    );

    final textFormField = find.byType(TextFormField);
    final textFormFieldWidget = tester.widget<TextFormField>(textFormField);
    
    final customTextFormField = find.byType(CustomTextFormField);
    final customTextFormFieldWidget = tester.widget<CustomTextFormField>(customTextFormField);

    expect(customTextFormFieldWidget.label, isNotNull);
    expect(customTextFormFieldWidget.hint, isNotNull);
    expect(customTextFormFieldWidget.errorMessage, isNotNull);
    expect(textFormFieldWidget.onChanged, isNotNull);
    expect(textFormFieldWidget.validator, isNotNull);
    expect(customTextFormFieldWidget.obscureText, isNotNull);
  });

  testWidgets('Enter text works correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomTextFormField(),
        )
      )
    );

    const newText = 'Sample';
    final customTextFormField = find.byType(CustomTextFormField);

    await tester.enterText(customTextFormField, newText);
    await tester.pump();

    expect(find.text(newText), findsOneWidget);
  });
}