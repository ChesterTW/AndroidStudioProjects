import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
import 'package:accounting/main.dart';
import 'package:flutter/material.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  void initState() {
    super.initState();
    // 在啟動頁展示 2 秒後跳轉到主頁面
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const MyApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Spendify',
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1.2125,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                              color: Colors.grey[300]!,
                              blurRadius: 10,
                              offset: const Offset(3, 3))
                        ]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.greenAccent[400],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
