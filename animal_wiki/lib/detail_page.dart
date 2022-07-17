import 'package:flutter/material.dart';

import 'model/animal.dart';

/// 負責顯示動物的「詳細頁面（DetailPage）」，
/// 需有 animal 作為引數，
/// 才能知道要調用誰的資料。
class DetailPage extends StatefulWidget {
  /// 建構式 Construction：需給予 Animal 類型的變數
  const DetailPage({Key? key, required this.animal}) : super(key: key);

  /// 宣告 Animal 型別的 animal，並在建構式中被定義。
  final Animal animal;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Detail Page"),
            expandedHeight: 250,
            stretch: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Image(
                image: AssetImage(widget.animal.img),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 用 SliverToBoxAdapter 以包裝「一般Widget」
          SliverToBoxAdapter(
            /// 使用 Column 取得豎項佈局
            child: Column(
              children: [
                /// DetailPage 的動物「名稱」、「愛心數」
                _buildTitle(widget.animal),

                /// 可愛的分隔線
                const Divider(),

                /// DetailPage 的內文，將讀取 animal.content。
                _buildContext(widget.animal)
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Widget _buildTitle，負責設置「標題」、「收藏鈕」
  /// 引數為類型 Animal 的 animal，
  /// 使用其中屬性「chName」、「enName」、「loved」、「loveCount」，
  /// 最終以 Padding return。
  Widget _buildTitle(Animal animal) {
    int integerSaveCount = animal.loveCount;
    String saveCount = "$integerSaveCount";
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                animal.chName,
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                animal.enName,
                style: TextStyle(color: Colors.grey[600]),
              )
            ],
          ),
          InkWell(
            child: Row(
              children: [
                Icon(
                  animal.loved ? Icons.favorite : Icons.favorite_border,
                  color: Colors.yellow[800],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    saveCount,
                    style: TextStyle(color: Colors.yellow[800]),
                  ),
                )
              ],
            ),
            onTap: () {
              setState(() {
                animal.loved = !animal.loved;
              });
            },
          )
        ],
      ),
    );
  }

  /// Widget _buildDescription，負責設置「內文」，
  /// 引數為類型 Animal 的 animal，
  /// 使用其中屬性「content」，
  /// 最終以 Column return。
  Widget _buildContext(Animal animal) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 30.0),
          child: Text(animal.content),
        )
      ],
    );
  }
}
