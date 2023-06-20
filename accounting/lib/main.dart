import 'package:accounting/view/account_page.dart';
import 'package:accounting/view/lauch_page.dart';
import 'package:accounting/view/user_new_expense_page.dart';
import 'package:accounting/view/home_page.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting();

  runApp(const Init());
}

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LaunchPage(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isCollapsed = false;

  int balance = 10000;

  int _currentPagesIndex = 0;
  var pages = const [
    HomePage(),
    HomePage(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    loadBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: BottomNavigationbarItems(),
        currentIndex: _currentPagesIndex,
        fixedColor: Colors.black,
        onTap: ChangePage,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.greenAccent,
            pinned: true, // 固定
            snap: false, // 0% or 100% expended speed
            floating: true, // 懸浮
            centerTitle: false,
            flexibleSpace: AppBarExpension(),
            title: BrandTitle(
              isCollapsed: isCollapsed,
              title: "Spendify",
            ),
            bottom: BalanceTitle(
              subTitle: "Balance",
              title: "\$ $balance",
            ),
          ),
          pages[_currentPagesIndex]
        ],
      ),
    );
  }

  LayoutBuilder AppBarExpension() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final top = constraints.constrainHeight();
        final collapsedHeight =
            MediaQuery.of(context).viewPadding.top + kToolbarHeight + 80;

        void onCollapsed(bool value) {
          if (isCollapsed == value) return;
          setState(() => isCollapsed = value);
        }

        // 尚未展開的 flexibleSpace 高度。
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          // 此時如果立刻執行下面的代碼，是獲取不到 BuildContext，因為 widget 還沒有完成繪製
          // addPostFrameCallback 是 StatefulWidget 渲染結束的回調，只會被調用一次，之後 StatefulWidget 需要刷新 UI 也不會被調用
          onCollapsed(
              collapsedHeight != top); // 利用 callback 轉換傳遞現在的 isCollapsed
        });

        return const AppBarLinearGradient();
      },
    );
  }

  Future loadBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasResetBalance = prefs.getBool("hasResetBalance") ?? false;
    int startDate = prefs.getInt("prefStartDate") ?? 1;

    // 判定今日是否要重置
    if (!hasResetBalance && DateTime.now().day == startDate) {
      resetBalanceAndExpense();
      prefs.setBool("hasResetBalance", true);
    }

    setState(() {
      balance = (prefs.getInt("prefBalance") ?? 10000);
    });
  }

  Future resetBalanceAndExpense() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// 設置 浮動值 為 固定值。
      prefs.setInt(
          "prefBalance", (prefs.getInt("prefBalanceSetting") ?? 10000));
      // 重設 花費 為 0。
      prefs.setInt("prefExpense", 0);
    });
  }

  void ChangePage(int index) {
    setState(
      () {
        _currentPagesIndex = index;

        if (_currentPagesIndex == 1) {
          ShowBottomSheet().then((value) {
            // 若點擊外部，即退出 BottomSheet，並跳轉回 HomePage 頁面。
            setState(() {
              _currentPagesIndex = 0;
            });
          });
        }
      },
    );
  }

  Future<void> ShowBottomSheet() {
    return showModalBottomSheet<void>(
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(36))),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),

            /// file: lib/view/user_new_expense_page
            child: const AddExpensePage(),
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> BottomNavigationbarItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        label: "首頁",
        icon: _currentPagesIndex == 0
            ? const Icon(
                Ionicons.home,
                size: 24,
              )
            : const Icon(
                Ionicons.home_outline,
                size: 24,
              ),
      ),
      BottomNavigationBarItem(
        label: "新增",
        icon: _currentPagesIndex == 1
            ? const Icon(
                Icons.add_box_rounded,
                size: 26,
              )
            : const Icon(
                Icons.add_box_outlined,
                size: 26,
              ),
      ),
      BottomNavigationBarItem(
        label: "帳戶",
        icon: _currentPagesIndex == 2
            ? const Icon(Icons.menu_rounded)
            : const Icon(Icons.menu_rounded),
      )
    ];
  }
}

class BalanceTitle extends StatelessWidget with PreferredSizeWidget {
  final String subTitle;
  final String title;
  const BalanceTitle({
    Key? key,
    required this.subTitle,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    subTitle,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 1.2125,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      height: 1.2125,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class BrandTitle extends StatelessWidget {
  final String title;
  const BrandTitle({
    Key? key,
    required this.isCollapsed,
    required this.title,
  }) : super(key: key);

  final bool isCollapsed;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isCollapsed ? 0 : 1, // 判斷 SliverAppBar 是展開還是縮小。
      duration: const Duration(milliseconds: 250),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.2125,
            color: const Color(0xff000000),
          ),
        ),
      ),
    );
  }
}

class AppBarLinearGradient extends StatelessWidget {
  const AppBarLinearGradient({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Colors.greenAccent, Colors.lightGreenAccent],
          ),
        ),
      ),
    );
  }
}
