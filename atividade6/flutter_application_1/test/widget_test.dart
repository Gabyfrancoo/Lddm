import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('App carrega corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // Verifica se aparece algum texto da sua tela
    expect(find.text('Salvar um usuário'), findsOneWidget);
  });
}