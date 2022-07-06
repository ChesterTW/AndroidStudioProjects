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
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Animal Wiki"),
        ),
        backgroundColor: Colors.white70,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildBox(),
            )
          ],
        ));
  }

  Widget _buildBox() {
    return Container(
      width: double.infinity,
      height: 560,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              image: DecorationImage(
                image: AssetImage('images/BengalTiger.jpeg'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  IconButton(
                    icon: Icon(Icons.description_outlined),
                    iconSize: 30.0,
                    onPressed: null,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  IconButton(
                    icon: Icon(Icons.share_outlined),
                    iconSize: 30.0,
                    onPressed: null,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  IconButton(
                    icon: Icon(Icons.bookmark_border_outlined),
                    iconSize: 30.0,
                    onPressed: null,
                  )
                ],
              )
            ],
          ),
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: const [
                          Text(
                            "BengalTiger",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                            "孟加拉虎（學名：Panthera tigris tigris）[1][2]又名印度虎，是目前數量最多，分布最廣的虎的亞種，1758年，孟加拉虎成為瑞典自然學家卡爾·林奈為老虎命名時的模式標本，因而也就成了指名亞種。孟加拉虎主要分布在印度和孟加拉國。孟加拉虎也是這兩個國家的珍稀動物。")),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
