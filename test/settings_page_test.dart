import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projek_cp/pages/settings_page.dart';

void main() {
  testWidgets('SettingsPage tampil dengan benar', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsPage(),
      ),
    );
    expect(find.text('Pengaturan'), findsOneWidget);
    expect(find.text('Notifikasi'), findsOneWidget);
    expect(find.text('Tentang Aplikasi'), findsOneWidget);
    expect(find.byType(Switch), findsNWidgets(2));
  });
}
