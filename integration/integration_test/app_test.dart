import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_example/home_screen.dart';
import 'package:integration_test/integration_test.dart';
import 'package:form_example/main.dart' as app;


// 統合テストは、アプリケーションのさまざまな部分が連携して動作することを確認

void main() {
  // 統合テストのセットアップ
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //正しいユーザー名とパスワードでのログインテスト
  group(
    'end to end test',
    () {
      testWidgets(
        'verify login screen with correct username and password',
        (tester) async {
          app.main(); // 起動
          await tester.pumpAndSettle(); //UIの描写の完了をまつ
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(0), 'tf1'); // 1番目のテキストフィールド
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(1), 'tf2'); // 2番目のテキストフィールド
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton)); // ボタンをタップする
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 2));
          expect(find.byType(HomeScreen), findsOneWidget); // 次の画面にちゃんと遷移するか
        },
      );

      testWidgets(
        'verify login screen with incorrect username and password',
        (tester) async {
          app.main();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(0), 'xxx');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(1), 'xxxxxxx');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byType(ElevatedButton));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 2));
          expect(find.text('Invalid username or password'), findsOneWidget);  // 画面の文字を探す
        },
      );
    },
  );
}
