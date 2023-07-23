import 'package:animal_wiki/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets("點擊「詳細」鈕，進入「詳細頁面」（detail_page），測試「愛心」是否作用。",
      (WidgetTester tester) async {
    // 呼叫 Widget，進入 home_page。
    app.main();
    // 觸發渲染 home_page
    await tester.pumpAndSettle();

    // 在 home_page 中，點擊「詳細」按鈕，以進入 detail_page。
    await tester.tap(find.byIcon(Icons.description).first);
    // 觸發渲染 detail_page，
    // 由於渲染一張 Page 的時間較長，
    // 因此使用 pumpAndSettle 來觸發畫面渲染，
    // 以給予較長的等待時間。
    // 若使用 pump 觸發，會讓頁面來不及渲染，
    // 便開始後續的測試指令，而讓測試失效。
    await tester.pumpAndSettle();
    // 在 detail_page 中，點擊「愛了」按鈕。
    await tester.tap(find.byIcon(Icons.favorite_border));
    // 觸發渲染，以更新 Widget 狀態。
    await tester.pump();
    // 預期：能找到「一個」Icon.favorite。
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}
