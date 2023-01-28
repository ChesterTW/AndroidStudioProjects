import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Visibility(
          /// isLoaded，避免 ListView 讀出 Null 值，導致 APP 崩潰。
          visible: true,

          /// 會顯示不斷轉動的讀取條
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),

          /// 讀取所有「日結帳」
          child: ListView(
            children: [
              _buildCard(),
              _buildCard(),
              _buildCard(),
              _buildCard(),
              _buildCard(),
              _buildCard(),
              _buildCard(),
            ],
          ),
        ));
  }

  /// buildCard，負責產生「日結帳」的「外頁」，
  /// 會被使用在 Scaffold 的 ListView 中。
  Widget _buildCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // 暫時性，區分階層用。
          color: Colors.white,
          // 讓每張 _buildCard 都有好看的四個圓角
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          children: [
            _buildDate(),
            _buildExpenseSection(),
            _buildAmount(),
          ],
        ),
      ),
    );
  }

  /// buildDate，負責產生花費的「絕對日期」、「相對日期」。
  Widget _buildDate() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 20, 20, 15),
      child: Row(
        children: const [
          Text("2023/01/28 週六"),
          SizedBox(
            width: 12,
          ),
          Text(
            "今日",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  /// buildExpenseSection，負責產生花費的「花費詳細」。
  Widget _buildExpenseSection() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 239, 184, 1.0),
        //color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Column(
        children: [
          _buildExpense(),
          _buildExpense(),
        ],
      ),
    );
  }

  /// buildExpense，負責產生「單筆花費」。
  Widget _buildExpense() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// 圓形的圖框，其「背景顏色」為透明，
          /// 而 child 為 Icon，Colors 為 black87。
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.fastfood_rounded,
                size: 36,
                color: Colors.black87,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("大杯的卡布奇諾"),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: const [
                  Text("Eating Out"),
                  SizedBox(
                    width: 60,
                  ),
                  Text("65"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// buildExpense，負責產生花費的「總計」和「其他操作功能」。
  Widget _buildAmount() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 15, 20, 15),
      child: Row(
        children: const [
          Icon(
            Icons.monetization_on_rounded,
            size: 24,
          ),
          SizedBox(
            width: 35,
          ),
          Text("130"),
        ],
      ),
    );
  }
}
