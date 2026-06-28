import 'package:app_biometria/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Teste básico do app de biometria', (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    expect(find.text('Acesso Restrito'), findsOneWidget);
    expect(find.text('Acessar Conta'), findsOneWidget);
  });
}