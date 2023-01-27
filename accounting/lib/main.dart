import 'package:accounting/view/AccountPage.dart';
import 'package:accounting/view/CreateExpensePage.dart';
import 'package:accounting/view/HomePage.dart';
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
  int _currentIndex = 0;
  final pages = [HomePage(), CreateExpensePage(), AccountPage()];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Accounting",
        ),
        centerTitle: false,
      ),

      /// 最外層，包覆了所有「主頁面」的 Widget
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(label: "首頁", icon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(
              label: "新增", icon: Icon(Icons.library_add_outlined)),
          BottomNavigationBarItem(
              label: "帳戶", icon: Icon(Icons.account_circle_outlined))
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.amber,
        onTap: _onItemClick,
      ),
    );
  }

  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
