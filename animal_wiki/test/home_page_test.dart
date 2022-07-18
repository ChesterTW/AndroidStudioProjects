import 'package:animal_wiki/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("檢測是否皆以預設值呈現", (WidgetTester tester) async {
    // 呼叫 Widget，進入 home_page。
    app.main();
    // 觸發渲染 home_page
    await tester.pumpAndSettle();

    // 預期：能找到「一個」Icons.search
    expect(find.byIcon(Icons.search), findsOneWidget);
    // 預期：能找到「一個」Icons.bookmarks
    expect(find.byIcon(Icons.bookmarks), findsOneWidget);

    // 預期：能找到「一個或多個」Icons.description，以確認有讀取出 Card。
    expect(find.byIcon(Icons.description), findsWidgets);
    // 預期：能找到「一個或多個」Icons.description，以確認有讀取出 Card。
    expect(find.byIcon(Icons.share), findsWidgets);
    // 點擊「第一個」Icons.share。
    await tester.tap(find.byIcon(Icons.share).first);
    // 觸發渲染
    await tester.pumpAndSettle();
    // 預期：能找到「一個或多個」Icons.description，以確認有讀取出 Card。
    expect(find.byIcon(Icons.bookmark_border), findsWidgets);

    // ListView 滑動測試
    final gesture = await tester
        .startGesture(const Offset(0, 300)); //Position of the scrollview
    await gesture.moveBy(const Offset(0, -300)); //How much to scroll by
    // 觸發渲染
    await tester.pump();
  });
}
