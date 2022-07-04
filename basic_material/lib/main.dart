import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

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
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  /// 建構式 Construction：
  /// 需給予參數 title
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  /// 宣告字串型別的 title，並在建構式中被定義。
  final String title;

  /// 給予可變狀態
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// 定義類別為 WordPair 的 List，名為 _suggestions。
  final _suggestions = <WordPair>[];

  /// 定義類別為 WordPair 的 Set，名為 _saved ，
  /// Set 有著一項特性，非常適用於此情況：不會存在重複元素。
  final _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.favorite,
              ),
              onPressed: _pushSaved),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  /// 產生 ListView，並回傳 _buildRow 或 分割線。
  Widget _buildSuggestions() {
    /// ListView.builder 是 ListView 的建構器，返回值為一個 Widget，當列表滾到 i 的位置時，會調用建構器建構列表。
    /// itemCount：列表项的数量，如果为null，则为无限列表。
    return ListView.builder(itemBuilder: (context, i) {
      // 利用 ListView.builder 的計數器，每當數值為偶數時，return 分割線。
      if (i.isOdd) return const Divider();

      // 宣告 index 為計數器除與 2 的商數
      final index = i ~/ 2;

      // 如果 index 大於等於 _suggestions 的長度
      if (index >= _suggestions.length) {
        // 呼叫 generateWordPairs ，並執行take(10)，獲取 10 個單字，並新增進 _suggestions 中。
        _suggestions.addAll(generateWordPairs().take(10));
      }

      // 回傳 _buildRow，並給予引數 _suggestions[index]
      return _buildRow(_suggestions[index]);
    });
  }

  /// 產生單字列
  Widget _buildRow(WordPair pair) {
    // 定義 alreadySaved 為 bool 類型，
    // Set 的方法 contains 用途為：確認其中是否有與引入值相同的元素，結果將回傳為 True 或 False。
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
      ),
      // trailing 會將給予的 Widget 顯示在列尾末端，
      // 在此的三元運算子，將根據 alreadySaved 的 true、false，決定 Icons、Color 。
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      // 點擊事件
      onTap: () {
        // 改變狀態（setState），告知框架需要重建。
        setState(() {
          // 同時，判斷單字是刪除或新增。
          alreadySaved ? _saved.remove(pair) : _saved.add(pair);
        });
      },
    );
  }

  /// 跳轉頁面，使用 Scaffold 顯示以收藏的單字。
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          // 定義 final tiles 為執行方法 map 的 _saved，
          // 給予 pair 作為 Function 的引數，並回傳 ListTile 給予。
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                ),
              );
            },
          );
          // 宣告類型為 List 的 divided，
          // 給予 ListTile 的方法 divideTiles：可以在各 ListTile 之間添加「分隔線」。
          // 而 tiles 是先前存有 ListTile 的 tiles。
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          // 回傳 Scaffold，
          // 於 body 的 Widget 為 ListView，
          // 而子 Widget 是類型為 List<Widget> 的 divided。
          return Scaffold(
            appBar: AppBar(
              title: const Text('CollectionPage'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
