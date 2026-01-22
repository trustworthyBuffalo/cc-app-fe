import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projek_cp/pages/profil.dart';

void main() {
  testWidgets('ProfilPage bisa ditampilkan dan punya TabBar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ProfilPage()));
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Boogie Woogie'), findsWidgets);
    expect(find.text('Edit Profil'), findsOneWidget);
    expect(find.text('Bagikan'), findsOneWidget);
    expect(find.byType(TabBar), findsOneWidget);
    expect(find.text('Postingan'), findsWidgets);
    expect(find.text('Media'), findsWidgets);
    expect(find.text('Suka'), findsWidgets);
    await tester.tap(find.text('Media').first);
    await tester.pumpAndSettle();
    expect(find.text('Media'), findsWidgets);
    await tester.tap(find.text('Suka').first);
    await tester.pumpAndSettle();
    expect(find.text('Suka'), findsWidgets);
  });
}
