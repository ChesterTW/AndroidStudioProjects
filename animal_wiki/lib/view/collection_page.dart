import 'package:flutter/material.dart';
import 'detail_page.dart';
import '../model/animal.dart';

/// 負責「收藏頁面（CollectionPage）」
class CollectionPage extends StatefulWidget {
  CollectionPage({Key? key, required this.saved}) : super(key: key);

  var saved = <Animal>{};

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Collection Page"),
          centerTitle: false,
        ),
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 3.0),
              itemCount: widget.saved.length,
              itemBuilder: (context, index) {
                return _previewCard(widget.saved.toList()[index]);
              }),
        ));
  }

  /// 創建 Widget _previewCard，
  /// 使用引數 Animal animal，
  /// 將利用其中的 img，顯示一張圖片卡，
  /// 且藉由 InkWell 給予點擊動作，讓使用者可以跳轉「詳細頁面（detail_page.dart）。
  Widget _previewCard(Animal animal) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        child: Ink.image(
          image: AssetImage(animal.img),
          fit: BoxFit.cover,
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailPage(animal: animal);
          }));
        },
      ),
    );
  }
}
