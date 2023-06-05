import 'dart:io';

import 'package:accounting/model/DatabaseHelper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:accounting/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AccountPage extends StatefulWidget {
  AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final textControllerAmount = TextEditingController();
  final textControllerStartDate = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  setBalance(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// 設置固定值、浮動值
      prefs.setInt("prefBalanceSetting", amount);
      prefs.setInt("prefBalance", amount);
    });
  }

  incrementBalance(
    int amount,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// 增減時，只更動浮動值，在下個月就會被重置為固定值。
      prefs.setInt(
          "prefBalance", (prefs.getInt("prefBalance") ?? 10000) + amount);
    });
  }

  setStartDate(int date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// 設置固定值
      prefs.setInt("prefStartDate", date);
    });
  }

  setExpense(int date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int sum = await DatabaseHelper.instance.getSumByDate(date);
    print("sumaaaaaaa ${sum}");

    setState(() {
      /// 設置固定值
      prefs.setInt(
          "prefBalance", (prefs.getInt("prefBalanceSetting") ?? 10000) - sum);
      prefs.setInt("prefExpense", sum);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 8),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.cloud_upload_outlined,
                  size: 40,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "雲端同步狀態",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                subtitle: Text(
                  "未同步",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange[300]),
                ),
                trailing: Text(
                  "重新同步",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600, color: Colors.green[700]),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 20, 25, 0),
          child: Text(
            "系統設定",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    Theme(
                      data: ThemeData(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        iconColor: Colors.green[700],
                        leading: const Icon(
                          Icons.wallet_outlined,
                          size: 32,
                        ),
                        title: Text(
                          "餘額設定",
                          style: GoogleFonts.inter(color: Colors.grey),
                        ),
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 70),
                            title: Text(
                              "固定餘額",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      contentPadding: const EdgeInsets.all(15),
                                      title: const Center(
                                        child: Text("更改固定餘額"),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Form(
                                                    key: _formKey,
                                                    child: TextFormField(
                                                      keyboardType: Platform
                                                              .isIOS
                                                          ? const TextInputType
                                                                  .numberWithOptions(
                                                              signed: true,
                                                              decimal: true)
                                                          : TextInputType
                                                              .number,
                                                      decoration:
                                                          const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          20,
                                                                          5,
                                                                          10,
                                                                          5),
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText: "金額"),
                                                      validator: (text) {
                                                        if (text == null ||
                                                            text.isEmpty) {
                                                          return '請輸入金額';
                                                        }
                                                        return null;
                                                      },
                                                      controller:
                                                          textControllerAmount,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                "取消",
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  setBalance(int.parse(
                                                      textControllerAmount
                                                          .text));
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    PageRouteBuilder(
                                                      transitionDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  500),
                                                      pageBuilder: (BuildContext
                                                              context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secondaryAnimation) {
                                                        return FadeTransition(
                                                          opacity: animation,
                                                          child: const MyApp(),
                                                        );
                                                      },
                                                    ),
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  );
                                                }
                                              },
                                              color: Colors.greenAccent,
                                              child: const Text(
                                                "確定",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            },
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 70),
                            title: Text(
                              "追加餘額",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      contentPadding: const EdgeInsets.all(15),
                                      title: const Center(
                                        child: Text("追加餘額"),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Form(
                                                    key: _formKey,
                                                    child: TextFormField(
                                                      keyboardType: Platform
                                                              .isIOS
                                                          ? const TextInputType
                                                                  .numberWithOptions(
                                                              signed: true,
                                                              decimal: true)
                                                          : TextInputType
                                                              .number,
                                                      decoration:
                                                          const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          20,
                                                                          5,
                                                                          10,
                                                                          5),
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText: "金額"),
                                                      validator: (text) {
                                                        if (text == null ||
                                                            text.isEmpty) {
                                                          return '請輸入金額';
                                                        }
                                                        return null;
                                                      },
                                                      controller:
                                                          textControllerAmount,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                "取消",
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  incrementBalance(int.parse(
                                                      textControllerAmount
                                                          .text));
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    PageRouteBuilder(
                                                      transitionDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  500),
                                                      pageBuilder: (BuildContext
                                                              context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secondaryAnimation) {
                                                        return FadeTransition(
                                                          opacity: animation,
                                                          child: const MyApp(),
                                                        );
                                                      },
                                                    ),
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  );
                                                }
                                              },
                                              color: Colors.greenAccent,
                                              child: const Text(
                                                "確定",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            },
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 70),
                            title: Text(
                              "每月起始日期",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      contentPadding: const EdgeInsets.all(15),
                                      title: const Center(
                                        child: Text("更改每月起始日期"),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Form(
                                                    key: _formKey,
                                                    child: TextFormField(
                                                      keyboardType: Platform
                                                              .isIOS
                                                          ? const TextInputType
                                                                  .numberWithOptions(
                                                              signed: true,
                                                              decimal: true)
                                                          : TextInputType
                                                              .number,
                                                      decoration: const InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.fromLTRB(
                                                                  20, 5, 10, 5),
                                                          border:
                                                              OutlineInputBorder(),
                                                          hintText:
                                                              "1~30 的起始日期"),
                                                      validator: (text) {
                                                        if (text == null ||
                                                            text.isEmpty ||
                                                            int.parse(text) >
                                                                10 ||
                                                            int.parse(text) <
                                                                1) {
                                                          return '請輸入 1~30 的起始日期。';
                                                        }
                                                        return null;
                                                      },
                                                      controller:
                                                          textControllerStartDate,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                "取消",
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  setStartDate(int.parse(
                                                      textControllerStartDate
                                                          .text));
                                                  setExpense(int.parse(
                                                      textControllerStartDate
                                                          .text));
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    PageRouteBuilder(
                                                      transitionDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  500),
                                                      pageBuilder: (BuildContext
                                                              context,
                                                          Animation<double>
                                                              animation,
                                                          Animation<double>
                                                              secondaryAnimation) {
                                                        return FadeTransition(
                                                          opacity: animation,
                                                          child: const MyApp(),
                                                        );
                                                      },
                                                    ),
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  );
                                                }
                                              },
                                              color: Colors.greenAccent,
                                              child: const Text(
                                                "確定",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            },
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    Theme(
                      data: ThemeData(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        leading: const Icon(
                          Icons.settings_display_outlined,
                          size: 32,
                        ),
                        title: Text(
                          "顯示設定",
                          style: GoogleFonts.inter(color: Colors.grey),
                        ),
                        iconColor: Colors.green[700],
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(left: 70),
                            title: Text(
                              "深色模式",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
