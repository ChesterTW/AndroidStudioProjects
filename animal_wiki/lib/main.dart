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
      content:
          "水獺亞科動物分佈於全球各地。紅樹林的水獺生長在歐亞大陸，美洲獺屬的水獺則生長在美洲大陸，而海獺則常見於北太平洋的海岸。水獺身長70－75公分，尾巴細長；頭扁耳小腳短，趾間有蹼；有二層非常短而密（密度達到1000根/平方毫米）的細軟絨毛，以保持身體的乾燥和溫暖；背部深褐色有光澤，腹部顏色較淡。所有的水獺都具有細長、流綫型的身體結構，身體優美靈活，四肢較短。大多數都具有鋒利的爪。大多數水獺都以魚類為食，也吃蛙類、淡水蝦和蟹類。性格兇猛，在遭到獵犬圍捕時，敢於向身形較大的進攻者發起反抗，曾有咬死獵犬的記載。[1][來源可靠？] 2011年時，有遊客拍攝到水獺在伍德拉夫湖國家野生動物保護區攻擊幼年鱷魚[2] 。",
      img: "images/otter.jpeg",
      saved: false,
      loved: false,
      loveCount: 813);
  Animal animalBengalTiger = new Animal(
      chName: "孟加拉虎",
      enName: "BengalTiger",
      description:
          "孟加拉虎（學名：Panthera tigris tigris）[1][2]又名印度虎，是目前數量最多，分布最廣的虎的亞種，1758年，孟加拉虎成為瑞典自然學家卡爾·林奈為老虎命名時的模式標本，因而也就成了指名亞種。孟加拉虎主要分布在印度和孟加拉國。孟加拉虎也是這兩個國家的珍稀動物。",
      content:
          "成年雄性孟加拉虎包括尾部的總體長為2.7至3.1公尺，重約200至270公斤。雌性虎體型較小，包括尾部的總體長為2.4至2.65公尺，平均重139.7公斤 最重可達180公斤。孟加拉虎的毛色為橙色至淺橙色，擁有深褐色至黑色條紋，腹部和四肢內側為白色，尾部為褐色及橙色的環。白底黑紋的孟加拉白虎，一般是遺傳基因突變所造成的結果，孟加拉虎擁有異常粗壯犬齒，在所有貓科動物之中最長和最大。[3]另外，老虎成長期分為由幼崽(Cubs)<12個月、少年老虎(Juveniles) 1至2歲、亞成年老虎(Sub-adults) > 2至3歲、年輕老虎(Young-adults) > 3至5歲、成年老虎(Prime-adults) > 5至10歲、老年老虎(Old-adults) > 10歲）。孟加拉虎主要生活在印度和孟加拉國。在尼泊爾、不丹和中國也有少量的孟加拉虎。它們的棲息地較廣，主要活動於印度和孟加拉國的孫德爾本斯三角洲的紅樹林，不過在其它地區的雨林和草原里也有它們的蹤跡。野生的孟加拉虎主食為白斑鹿、印度黑羚、野豬和印度野牛，有時也能爬樹捕食靈長目的獵物。其它的捕食者，如豹、狼、豺、狐狸、鱷魚、懶熊、也可能成為孟加拉虎的獵物。在比較罕見的情況下，孟加拉虎也攻擊小象和犀牛。孟加拉虎喜歡在夜間捕食。它瞄準獵物的咽喉，用它強大的咬勁直接咬斷較小獵物的頸椎或讓大型獵物窒息。它可在一餐內吃掉18至40千克(公斤)的肉，並在接下來幾天內不進食。在卡齊蘭加國家公園，老虎在2007年殺死了20隻犀牛。[5][6]另外，孟加拉虎也有殺死灣鱷的記錄。Pranabes Sanyal博士是紅樹林生態系統的權威，1980年至1986年擔任孫德爾本斯虎保護區(Sundarbans Tiger Reserve)的前現場主管(the former field director)。Pranabes Sanyal博士在一份美國知識、文藝類的綜合雜誌The New Yorker(The Natural World April 21, 2008 Issue Tigerland)表示：「根據目擊者的報導，一隻一千八百磅的灣鱷被老虎殺死。」[7][8]但是在孟加拉虎的獵食中，大都以有蹄類動物為主。鮮有捕殺灣鱷的機率，反倒是有些大體型灣鱷捕殺孟加拉虎的報導。2017年6月，在 Kerala’s Wayanad至少有6頭是由於乾旱被老虎殺死的大象。[9]2009年12月，沼澤地溜進了一頭孟加拉虎，殺了一隻水牛後，攻擊一隻公象。村民發現受重傷的大象便通知森林部門。[10]",
      img: "images/BengalTiger.jpeg",
      saved: false,
      loved: false,
      loveCount: 219);
  Animal animalSlowpoke = new Animal(
      chName: "呆呆獸",
      enName: "Slowpoke",
      description:
          "呆呆獸是第一世代的寶可夢。 呆呆獸會用尾巴在水邊釣魚，根據設定，當大舌貝咬住呆呆獸的尾巴時，它就會進化成呆殼獸。 在動畫和旁支系列遊戲中存在這一情節，但在主系列遊戲中呆呆獸的進化與大舌貝無關。",
      content:
          "呆呆獸周身呈粉紅色，體態偏胖。它的耳朵是卷狀的，又圓又大的眼眶中只有很小的瞳孔，顯得目光呆滯。它的嘴巴呈奶油色，上顎可以看見有兩顆牙齒。它四肢短小，手腳都有一根爪子，有一條較長的粉紅尾巴，末端呈淡粉色。伽勒爾樣子的呆呆獸與一般樣子的分別不大，但頭頂及尾部末端改為黃色，額頭亦有三條橫紋。呆呆獸一直在水邊發呆，不知道它在想些什麼。雖然它又呆又遲鈍，但很擅長用尾巴來釣食物。呆呆獸會從尾端滲出甜甜的味道，雖然沒有營養，但咬到會有幸福的感覺。把尾巴泡在水裡後會有甜味滲出，因此它會以尾巴為誘餌吸引寶可夢並將其釣起，但釣著釣著就會忘記自己在做什麼，會因此躺在河邊直至一天結束。它的感覺遲鈍，就算滲出甜味的尾巴被釣到的食物咬到也不會注意到痛。就算被打了，過5秒才能感到一點疼。即使尾巴被吃了也感受不到疼痛，甚至不會注意到又長出了新尾巴。當呆呆獸去海裡捕食時，如果被大舌貝咬住尾巴就會變成了呆殼獸，如果被大舌貝咬住腦子就會變成呆呆王。它長長的尾巴經常被揪斷，這種會自然斷裂並脫落下來的尾巴是一種容易得到又十分貴重的食材。把呆呆獸的尾巴曬乾後再用鹽水煮成的小菜，是阿羅拉的家常美味。刺甲貝非常喜歡吃呆呆獸的尾巴，有時甚至會爬到陸地上來尋找呆呆獸。它總是恍恍惚惚的，從不在意時間的流逝，過著悠閒的生活。有傳說講呆呆獸打哈欠就會下雨，所以據說有些地方會供奉呆呆獸。伽勒爾地區的呆呆獸過著成天放空躺在海邊和河邊的生活，平時一直都在發呆。它曾經很喜歡吃簇生在樓息地的植物的種子。這些種子被稱作伽勒荳蔻，是煮料理時不可或缺的香料之一。呆呆獸世世代代持續地把伽勒荳蔻的成份積存在體內，最終令自己獲得了獨特的外型和能力，不同於至今發現的呆呆獸，伽勒爾地區的呆呆獸的尾巴是辣味的。它偶爾也會露出銳利的目光，但很快便會回復發呆的表情。這可能是由於它的腦部因為某種原因，受到積存在體內的伽勒荳蔻成份刺激，浮現了什麼厲害的點子，但在轉眼間就被它忘得一乾二淨的緣故。[1]",
      img: "images/Slowpoke.png",
      saved: false,
      loved: false,
      loveCount: 1316);

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
          body: Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: GridView.builder(
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
                }),
          ));
    }));
  }

  Widget _previewCard(Animal animal) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
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
              _buildImage(animal),

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
  /// 接收型別 Animal 作為引數，取用一個變數：「img」，
  /// 以此作為尋找「圖片」的路徑，最終會將「圖片」，
  /// 包在 ClipRRect 中 return。
  Widget _buildImage(Animal animal) {
    return ClipRRect(
      // 設置邊界半徑：豎向排列（設定頂列為 25.0）
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
      // child : 給予 Image
      child: Image(
        // 透過 ImageProvider 讀取圖片，使用 String imgPath 中儲存的「圖片路徑」。
        image: AssetImage(animal.img),
        // 設置 BoxFit 為填滿，以確保圖片能放到最大。
        fit: BoxFit.fill,
      ),
    );
  }

  /// buildContext，負責創建外頁的「內容」，
  /// 接收型別 Animal 作為引數，取用了三個變數「chName」、「enName」、「description」，
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
          // TODO: 2022/7/11 4:37 下午 待重構，程式碼過於重複、冗長。
          InkWell(
            child: _buildButtonColumn(Icons.description, "詳情"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DetailPage(animal: animal);
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

class DetailPage extends StatefulWidget {
  /// 建構式 Construction：需給予 Animal 類型的變數
  const DetailPage({Key? key, required this.animal}) : super(key: key);

  /// 宣告 Animal 型別的 animal，並在建構式中被定義。
  final Animal animal;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // TODO: 2022/7/11 4:36 下午 待重構，程式碼過於重複、冗長。
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
        SliverToBoxAdapter(
          child: Column(
            children: [
              _buildTitle(widget.animal),
              const Divider(),
              _buildContext(widget.animal)
            ],
          ),
        )
      ],
    ));
  }

  /// Widget _buildImage，負責設置「圖片」
  /// 引數為類型 Animal 的 animal，
  /// 使用其中的屬性「img」，獲取「圖片路徑」，以讀取「圖片」
  /// 最終以 SizedBox return。
  Widget _buildImage(Animal animal) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Image(
        image: AssetImage(animal.img),
        fit: BoxFit.fill,
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
  /// 使用其中屬性「description」，
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

/// Animal 類型
class Animal {
  /// 類型 Animal 的建構式
  Animal({
    required this.chName,
    required this.enName,
    required this.description,
    required this.content,
    required this.img,
    required this.saved,
    required this.loved,
    required this.loveCount,
  });

  /// 宣告 String 類型的 chName，負責接收「中文名稱」。
  final String chName;

  /// 宣告 String 類型的 enName，負責接收「英文名稱」。
  final String enName;

  /// 宣告 String 類型的 description，負責接收「簡介」。
  final String description;

  final String content;

  /// 宣告 String 類型的 img，負責接收「圖片路徑」。
  final String img;

  /// 宣告 bool 類型的 saved，負責儲存「是否存儲的狀態」。
  bool saved;

  bool loved;

  final int loveCount;

  /// 接收 Json 檔，將裡頭的數值定義給對應的「變數」。
  factory Animal.fromJson(Map<String, dynamic> json) => Animal(
      chName: json["name"],
      enName: json["enName"],
      description: json["description"],
      content: json["content"],
      img: json["img"],
      saved: json["saved"],
      loved: json["loved"],
      loveCount: json["loveCount"]);

  /// 發送 Json 檔，將「變數的值」輸入於對應的欄位中。
  Map<String, dynamic> toJson() => {
        "name": chName,
        "enName": enName,
        "description": description,
        "content": content,
        "img": img,
        "saved": saved,
        "loved": loved,
        "loveCount": loveCount,
      };
}
