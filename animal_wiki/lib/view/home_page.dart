import 'package:animal_wiki/service/remote_service.dart';
import 'package:animal_wiki/view/collection_page.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'detail_page.dart';
import '../model/animal.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// 宣告 Set _saved，負責儲存「已儲存的動物」。
  /// 利用不可重複的特性，必應用在「收藏頁面（collection_page.dart）」。
  final _saved = <Animal>{};

  /// 宣告 Boolean isLoaded，作為 API 讀取完畢的 Flag，
  /// 應用在 CircularProgressIndicator ，避免顯示 null 的 Widget 。
  var isLoaded = false;

  /// 宣告 List<Animal> 型別的 animals，
  /// 負責儲存 API 中，讀取出的「動物（Animal）」資料。
  List<Animal>? animals;

  @override
  void initState() {
    super.initState();

    /// fetch data from API，
    /// 讓 API 可以在一開始就開始讀取、Decode。
    getData();
  }

  /// 將 decode JSON 包裝成方法，並在其中給予 List<Animal>? animals。
  getData() async {
    // 接收類別 RemoteService 的方法 getPosts 的 Return。
    animals = await RemoteService().getAnimals();
    // 確認 animals 是否有資料，若有則讓 isLoaded 為 True，以讓 View 可以渲染。
    if (animals != null) {
      setState(
        () {
          isLoaded = true;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animal Wiki"),

        /// 標題至左
        centerTitle: false,
        actions: [
          /// 執行「搜尋」的按鈕
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),

          /// 跳轉至「收藏頁面」的按鈕
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CollectionPage(saved: _saved);
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.bookmarks,
              color: Colors.black,
            ),
          ),
        ],
      ),

      /// 給予微灰的顏色，
      /// 以讓眼睛可區分 Card 和 背景，
      /// 可以增強滑動的動覺效果。
      backgroundColor: Colors.grey[300],

      /// 給予 ListView ，以擁有上下滑動的功能。
      body: Visibility(
        /// isLoaded，避免 View 讀取出是 Null 的 animals。
        visible: isLoaded,
        replacement: const Center(
          /// 會顯示不斷轉動的讀取條
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          /// 數量設置為：animals 的長度，問號表示： 可能為 Null
          itemCount: animals?.length,
          itemBuilder: (context, index) {
            /// _buildCard 引數為 Animal 類型，因此僅需在 List animals 中，
            /// 指定要給予第幾個 index。
            return _buildCard(animals![index]);
          },
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
      ),
    );
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
        /// 以主軸為準 ，進行「平分」排列
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// 挑轉至「詳情頁面（detail_page.dart）」的按鈕，
          /// 使用 InkWell，以讓整塊「Widget」都能有「觸發事件」，且不需修改 _buildButtonColumn。
          InkWell(
            /// 呼叫 _buildButtonColumn，並給予 Icons.description、字串，
            /// 以生成「按鈕欄」。
            child: _buildButtonColumn(Icons.description, "詳情"),
            onTap: () {
              /// 導向「詳細頁面（DetailPage）」，並給予 animal 作為引數。
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return DetailPage(animal: animal);
                  },
                ),
              );
            },
          ),

          /// 執行「分享」的按鈕，使用了第三方套件「share_plus」，
          /// 可傳送固定的字串給其他應用程式，
          /// 使用 InkWell，以讓整塊「Widget」都能有「觸發事件」，且不需修改 _buildButtonColumn。
          InkWell(
            /// 呼叫 _buildButtonColumn，並給予 Icons.share、字串，
            /// 以生成「按鈕欄」。
            child: _buildButtonColumn(Icons.share, "分享"),
            onTap: () {
              setState(
                () {
                  /// 使用第三方套件「Share_plus」的 Class，
                  /// 可分享字串訊息給其他 App。
                  Share.share("快來一起看看！！在 AnimalWiki 上找到了這個有趣的動物\n" +
                      "動物名稱：" +
                      animal.chName +
                      "\n英文名稱：" +
                      animal.enName +
                      "\n簡介：" +
                      animal.description);
                },
              );
            },
          ),

          /// 將該「動物」收藏，將添加至 Set<Animal> _saved 中，
          /// 使用 InkWell，以讓整塊「Widget」都能有「觸發事件」，且不需修改 _buildButtonColumn。
          InkWell(
            /// 呼叫 _buildButtonColumn，
            /// 將判斷是否已「儲存」，再給予 Icon、字串，
            /// 以生成「按鈕欄」。
            child: _buildButtonColumn(
                animal.saved ? Icons.bookmark : Icons.bookmark_border, "收藏"),
            onTap: () {
              setState(
                () {
                  // 每此 onTap，animal 的 saved 將會反轉布林值，以達到開/關的作用。
                  animal.saved = !animal.saved;
                  // 若 animal 的 saved 為 Ture，
                  // 把 _saved 中添加該 animal，
                  // 若否，則刪去。
                  animal.saved ? _saved.add(animal) : _saved.remove(animal);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
