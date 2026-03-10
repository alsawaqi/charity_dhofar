import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:charity_dhofar/screen/setup_number_page.dart';

void main() {
  testWidgets('SetupNumberPage builds', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      const MaterialApp(
        home: SetupNumberPage(),
      ),
    );

    expect(find.text('Setup Kiosk'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
  });
}
