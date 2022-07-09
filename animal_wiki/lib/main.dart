// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Animal Wiki"),
          centerTitle: false,
          actions: [
            const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: _enterBookmarks,
              icon: const Icon(
                Icons.bookmarks,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[300],
        body: ListView(
          children: [
            buildCard("images/BengalTiger.jpeg", "孟加拉虎", "BengalTiger",
                "孟加拉虎（學名：Panthera tigris tigris）[1][2]又名印度虎，是目前數量最多，分布最廣的虎的亞種，1758年，孟加拉虎成為瑞典自然學家卡爾·林奈為老虎命名時的模式標本，因而也就成了指名亞種。孟加拉虎主要分布在印度和孟加拉國。孟加拉虎也是這兩個國家的珍稀動物。"),
            buildCard("images/otter.jpeg", "水獺", "Otter",
                "水獺是一類水棲、肉食性的哺乳動物，在動物分類學中屬於食肉目鼬科下的亞科級別，稱為水獺亞科（Lutrinae），現存七個屬及十三個物種。"),
            buildCard("images/Slowpoke.png", "呆呆獸", "Slowpoke",
                "呆呆獸是第一世代的寶可夢。 呆呆獸會用尾巴在水邊釣魚，根據設定，當大舌貝咬住呆呆獸的尾巴時，它就會進化成呆殼獸。 在動畫和旁支系列遊戲中存在這一情節，但在主系列遊戲中呆呆獸的進化與大舌貝無關。"),
          ],
        ));
  }

  /// 跳轉「收藏頁」，會被 AppBar 的 IconButton 呼叫。
  void _enterBookmarks() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Collection Page"),
          centerTitle: false,
        ),
        body: const Text("Welcome to Collection Page"),
      );
    }));
  }

  /// buildCard，負責產生動物的「外頁」，
  /// 會被使用在 ListView 中，
  /// 引數有四個，皆為 String 類型：imgPath, chName, enName, description，
  /// 當中使用到了一些方法：有 Container buildImage，和 Column buildContext, buildSection。
  /// 而本 Widget ，最終，會把各方法的回傳值組合起，並 return 為 Padding。
  Widget buildCard(
      String imgPath, String chName, String enName, String description) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Column(
            children: [
              buildImage(imgPath),
              buttonSection(),
              const Divider(),
              buildContext(chName, enName, description)
            ],
          ),
        ));
  }

  /// buildImage，負責產生外頁的「圖片」，
  /// 接收引數為 String 類型的變數 imgPath，
  /// 以此作為尋找「圖片」的路徑，最終會將「圖片」，
  /// 包在 Container 中 return，
  /// 而其中使用到很多的屬性 decoration，
  /// 以讓它有好看的圓角，並且完美貼合在 Container 中。
  Container buildImage(String imgPath) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
        image: DecorationImage(
          image: AssetImage(imgPath),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  /// buildContext，負責創建外頁的「內容」，
  /// 接收三個 String 引數，分別為「中英文名稱」和「簡介」，
  /// 而最終會回傳成 Column。
  Column buildContext(String chName, String enName, String description) {
    return Column(
      children: [
        ListTile(
            title: Text(
              chName,
              style: const TextStyle(fontSize: 24),
            ),
            subtitle: Text(enName)),
        Padding(padding: const EdgeInsets.all(15.0), child: Text(description)),
      ],
    );
  }

  /// buildButtonColumn，創建單個「按鈕欄」，
  /// 引數為：IconData, label，會將引數對應用在 Icon 和 Container 中，並用 Column return，
  /// 而其屬性有：
  /// Colors.yellow[900]
  /// MainAxisSize.min
  /// MainAxisAlignment.center
  Column buildButtonColumn(IconData icon, String label) {
    Color? color = Colors.yellow[900];
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
        ),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(fontSize: 12.0, color: color),
          ),
        )
      ],
    );
  }

  /// buttonSection，負責組合出「按鈕列」，
  /// 呼叫多個 Column 方法 buildButtonColumn，以獲取「按鈕欄」，
  /// 並使用 MainAxisAlignment.spaceEvenly，將其平均分散，
  /// 並包在 Row 中 return。
  Widget buttonSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.description, '詳情'),
          buildButtonColumn(Icons.share, '分享'),
          buildButtonColumn(Icons.bookmark_border, '收藏'),
        ],
      ),
    );
  }
}

/// Animal 類型
class Animal {
  /// 類型 Animal 的建構式
  Animal({
    required this.chName,
    required this.enName,
    required this.description,
    required this.img,
  });

  /// 宣告 String 類型的 chName，負責接收「中文名稱」。
  final String chName;

  /// 宣告 String 類型的 enName，負責接收「英文名稱」。
  final String enName;

  /// 宣告 String 類型的 description，負責接收「簡介」。
  final String description;

  /// 宣告 String 類型的 img，負責接收「圖片路徑」。
  final String img;

  /// 接收 Json 檔，將裡頭的數值定義給對應的「變數」。
  factory Animal.fromJson(Map<String, dynamic> json) => Animal(
        chName: json["name"],
        enName: json["enName"],
        description: json["description"],
        img: json["img"],
      );

  /// 發送 Json 檔，將「變數的值」輸入於對應的欄位中。
  Map<String, dynamic> toJson() => {
        "name": chName,
        "enName": enName,
        "description": description,
        "img": img,
      };
}
