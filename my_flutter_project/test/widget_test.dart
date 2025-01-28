import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_flutter_project/main.dart';

void main() {
  testWidgets('HaberNoktasi Widget Test', (WidgetTester tester) async {
    // Build the HaberNoktasi widget.
    await tester.pumpWidget(const MaterialApp(
      home: HaberNoktasi(),
    ));
    
    // Verify that the HaberNoktasi widget is rendered.
    expect(find.byType(HaberNoktasi), findsOneWidget);
  });
}
