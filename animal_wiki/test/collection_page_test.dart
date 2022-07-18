import 'package:animal_wiki/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("點擊收藏鈕", (WidgetTester tester) async {
    // 呼叫 Widget，進入 home_page。
    app.main();
    // 觸發渲染 home_page
    await tester.pumpAndSettle();

    // 在 home_page 中，點擊「收藏」按鈕。
    await tester.tap(find.byIcon(Icons.bookmark_border).first);
    // 觸發渲染，以更新 Widget 狀態。
    await tester.pump();
    // 預期：能找到「一個」已被「收藏」（Icon.bookmark）的動物。
    expect(find.byIcon(Icons.bookmark), findsOneWidget);

    // 在 home_page 中，點擊「收藏頁」按鈕，進入 collection_page。
    await tester.tap(find.byIcon(Icons.bookmarks));
    // 觸發渲染 collection_page
    await tester.pumpAndSettle();

    // 預期：能找到「一個」 Widget Type InkWell
    expect(find.byType(InkWell), findsOneWidget);

    // 點擊第一個 InWell。
    await tester.tap(find.byType(InkWell).first);
  });
}
