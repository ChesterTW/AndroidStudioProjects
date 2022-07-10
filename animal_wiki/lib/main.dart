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
  /// 可以 Json 化，以簡潔 main.dart
  Animal animalOtter = new Animal(
      chName: "水獺",
      enName: "Otter",
      description:
          "水獺是一類水棲、肉食性的哺乳動物，在動物分類學中屬於食肉目鼬科下的亞科級別，稱為水獺亞科（Lutrinae），現存七個屬及十三個物種。",
      img: "images/otter.jpeg",
      saved: false);
  Animal animalBengalTiger = new Animal(
      chName: "孟加拉虎",
      enName: "BengalTiger",
      description:
          "孟加拉虎（學名：Panthera tigris tigris）[1][2]又名印度虎，是目前數量最多，分布最廣的虎的亞種，1758年，孟加拉虎成為瑞典自然學家卡爾·林奈為老虎命名時的模式標本，因而也就成了指名亞種。孟加拉虎主要分布在印度和孟加拉國。孟加拉虎也是這兩個國家的珍稀動物。",
      img: "images/BengalTiger.jpeg",
      saved: false);
  Animal animalSlowpoke = new Animal(
      chName: "呆呆獸",
      enName: "Slowpoke",
      description:
          "呆呆獸是第一世代的寶可夢。 呆呆獸會用尾巴在水邊釣魚，根據設定，當大舌貝咬住呆呆獸的尾巴時，它就會進化成呆殼獸。 在動畫和旁支系列遊戲中存在這一情節，但在主系列遊戲中呆呆獸的進化與大舌貝無關。",
      img: "images/Slowpoke.png",
      saved: false);

  final _saved = <Animal>{};

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
            _buildCard(animalOtter),
            _buildCard(animalBengalTiger),
            _buildCard(animalSlowpoke)
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
          backgroundColor: Colors.grey[200],
          body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 3.0),
              itemCount: _saved.length,
              itemBuilder: (context, index) {
                var temp = <Animal>[];
                temp = _saved.toList();
                return _previewCard(temp[index]);
              }));
    }));
  }

  Widget _previewCard(Animal animal) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: InkWell(
        child: Ink.image(
          image: AssetImage(animal.img),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  /// buildCard，負責產生動物的「外頁」，
  /// 會被使用在 ListView 中，
  /// 引數有四個，皆為 String 類型：imgPath, chName, enName, description，
  /// 當中使用到了一些方法：有 Container buildImage，和 Column buildContext, buildSection。
  /// 而本 Widget ，最終，會把各方法的回傳值組合起，並 return 為 Padding。
  Widget _buildCard(Animal animal) {
    //throw Exception();
    return Padding(
        // Padding : 設置左上右方向為 16.0，底部為 4.0，讓 _buildCard 與螢幕邊界擁有距離，
        // 以凸顯 ListView 的滑動感，
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
        child: Container(
          // 寬度設置：無限
          width: double.infinity,
          decoration: BoxDecoration(
            // 將每張 _buildCard 的底色設為白色，凸顯 ListView 的滑動感。
            color: Colors.white,
            // 讓每張 _buildCard 都有好看的四個圓角
            borderRadius: BorderRadius.circular(25.0),
          ),
          // 使用 Column，以擁有「豎向」排版。
          child: Column(
            children: [
              /// 負責外頁的「圖片」
              /// Return ClipRRect, Child : Image
              _buildImage(animal.img),

              /// 負責外頁的「按鈕列」
              /// Return Row, Children : 三個 buttonColumn
              _buttonSection(animal),

              /// 我是可愛的分隔線，負責將「按鈕列」、「文字」區分開來。
              const Divider(),

              /// 負責外頁的「中英文名稱」、「簡介」。
              _buildContext(animal)
            ],
          ),
        ));
  }

  /// buildImage，負責產生外頁的「圖片」，
  /// 接收引數為 String 類型的變數 imgPath，
  /// 以此作為尋找「圖片」的路徑，最終會將「圖片」，
  /// 包在 ClipRRect 中 return。
  Widget _buildImage(String imgPath) {
    return ClipRRect(
      // 設置邊界半徑：豎向排列（設定頂列為 25.0）
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
      // child : 給予 Image
      child: Image(
        // 透過 ImageProvider 讀取圖片，使用 String imgPath 中儲存的「圖片路徑」。
        image: AssetImage(imgPath),
        // 設置 BoxFit 為填滿，以確保圖片能放到最大。
        fit: BoxFit.fill,
      ),
    );
  }

  /// buildContext，負責創建外頁的「內容」，
  /// 接收三個 String 引數，分別為「中英文名稱」和「簡介」，
  /// 而最終會回傳成 Column。
  Widget _buildContext(Animal animal) {
    return Column(
      children: [
        ListTile(
            title: Text(
              animal.chName,
              style: const TextStyle(fontSize: 24),
            ),
            subtitle: Text(animal.enName)),
        Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(animal.description)),
      ],
    );
  }

  /// buildButtonColumn，創建單個「按鈕欄」，
  /// 引數為：IconData, label，會將引數對應用在 Icon 和 Container 中，並用 Column return，
  /// 而其屬性有：
  /// Colors.yellow[900]
  /// MainAxisSize.min
  /// MainAxisAlignment.center
  Widget _buildButtonColumn(IconData icon, String label) {
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
  Widget _buttonSection(Animal animal) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            child: _buildButtonColumn(Icons.description, "詳情"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return EnterDetailPage(animal: animal);
              }));
            },
          ),
          InkWell(
            child: _buildButtonColumn(Icons.share, "分享"),
            onTap: () {
              setState(() {});
            },
          ),
          InkWell(
            child: _buildButtonColumn(
                animal.saved ? Icons.bookmark : Icons.bookmark_border, "收藏"),
            onTap: () {
              setState(() {
                animal.saved = !animal.saved;
                animal.saved ? _saved.add(animal) : _saved.remove(animal);
              });
            },
          )
        ],
      ),
    );
  }
}

class EnterDetailPage extends StatelessWidget {
  /// 建構式 Construction：需給予 Animal 類型的變數
  const EnterDetailPage({Key? key, required this.animal}) : super(key: key);

  /// 宣告 Animal 型別的 animal，並在建構式中被定義。
  final Animal animal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(animal.chName)),
      body: Text(animal.description),
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
    required this.saved,
  });

  /// 宣告 String 類型的 chName，負責接收「中文名稱」。
  final String chName;

  /// 宣告 String 類型的 enName，負責接收「英文名稱」。
  final String enName;

  /// 宣告 String 類型的 description，負責接收「簡介」。
  final String description;

  /// 宣告 String 類型的 img，負責接收「圖片路徑」。
  final String img;

  /// 宣告 bool 類型的 saved，負責儲存「是否存儲的狀態」。
  bool saved;

  /// 接收 Json 檔，將裡頭的數值定義給對應的「變數」。
  factory Animal.fromJson(Map<String, dynamic> json) => Animal(
        chName: json["name"],
        enName: json["enName"],
        description: json["description"],
        img: json["img"],
        saved: json["saved"],
      );

  /// 發送 Json 檔，將「變數的值」輸入於對應的欄位中。
  Map<String, dynamic> toJson() => {
        "name": chName,
        "enName": enName,
        "description": description,
        "img": img,
        "saved": saved,
      };
}
