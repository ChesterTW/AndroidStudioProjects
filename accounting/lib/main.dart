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
        primaryColor: Colors.orange,
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
        title: const Text("Accounting"),
        centerTitle: true,
      ),

      /// 最外層，包覆了所有「主頁面」的 Widget
      body: Container(
        /// 設計用顏色
        color: Colors.grey[400],

        /// 將「主頁面」設計為「豎項」排版
        child: Column(
          children: [
            /// BALANCE
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // 將每張 _buildCard 的底色設為白色，凸顯 ListView 的滑動感。
                    color: Colors.white,
                    // 讓每張 _buildCard 都有好看的四個圓角
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4.0, -4.0), //陰影y軸偏移量
                        blurRadius: 15.0, //陰影模糊程度
                        spreadRadius: 1, //陰影擴散程度
                      ),
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(4.0, 4.0), //陰影y軸偏移量
                        blurRadius: 15.0, //陰影模糊程度
                        spreadRadius: 1, //陰影擴散程度
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "B A L A N C E",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[400],
                              ),
                            ),
                            const Text(
                              "\$ 9380",
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            ),

            /// transaction
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  // 將每張 _buildCard 的底色設為白色，凸顯 ListView 的滑動感。
                  color: Colors.white,
                  // 讓每張 _buildCard 都有好看的四個圓角
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4.0, -4.0), //陰影y軸偏移量
                      blurRadius: 15.0, //陰影模糊程度
                      spreadRadius: 1, //陰影擴散程度
                    ),
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(4.0, 4.0), //陰影y軸偏移量
                      blurRadius: 15.0, //陰影模糊程度
                      spreadRadius: 1, //陰影擴散程度
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
                  child: Column(
                    children: [
                      const Text(
                        "T R A N S A C T I O N",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 40,
                        thickness: 1,
                        indent: 30,
                        endIndent: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildButtonColumn(Icons.fastfood, "飲食"),
                          _buildButtonColumn(Icons.sports_motorsports, "機車"),
                          _buildButtonColumn(Icons.description, "詳情"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// buildButtonColumn，創建單個「按鈕欄」，
  /// 引數為：IconData, label，會將引數對應用在 Icon 和 Container 中，並用 Column return，
  /// 而其屬性有：
  /// Colors.yellow[900]
  /// MainAxisSize.min
  /// MainAxisAlignment.center
  Widget _buildButtonColumn(IconData icon, String label) {
    Color? color = Colors.black;
    return Container(
      width: 50,
      height: 70,
      decoration: BoxDecoration(
        // 將每張 _buildCard 的底色設為白色，凸顯 ListView 的滑動感。
        color: Colors.white,
        // 讓每張 _buildCard 都有好看的四個圓角
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-4.0, -4.0), //陰影y軸偏移量
            blurRadius: 15.0, //陰影模糊程度
            spreadRadius: 1, //陰影擴散程度
          ),
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(4.0, 4.0), //陰影y軸偏移量
            blurRadius: 15.0, //陰影模糊程度
            spreadRadius: 1, //陰影擴散程度
          ),
        ],
      ),
      child: Column(
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
      ),
    );
  }
}
