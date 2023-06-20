import 'dart:io';

import 'package:accounting/model/DatabaseHelper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:accounting/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final balanceTextController = TextEditingController();
  final startDateTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        const CloudBackUpTile(),
        const Title(
          title: "系統設定",
        ),
        SystemSettingTile(context),
      ],
    );
  }

  Future setBalance(int amount) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(color: Colors.greenAccent[400]),
          );
        });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 取得 StartDate 範圍內的花費，減去新的 固定餘額
    int date = prefs.getInt("prefStartDate") ?? 1;
    int sum = await DatabaseHelper.instance.getSumByDate(date);

    setState(() {
      /// 設置固定值、浮動值
      prefs.setInt("prefBalanceSetting", amount);
      prefs.setInt("prefBalance", amount - sum);
    });
  }

  Future incrementBalance(int amount) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(color: Colors.greenAccent[400]),
          );
        });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// 增減時，只更動浮動值，在下個月就會被重置為固定值。
      prefs.setInt(
          "prefBalance", (prefs.getInt("prefBalance") ?? 10000) + amount);
    });
  }

  Future setStartDate(int date) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(color: Colors.greenAccent[400]),
          );
        });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int sum = await DatabaseHelper.instance.getSumByDate(date);
    setState(() {
      prefs.setInt("prefStartDate", date);
      prefs.setInt(
          "prefBalance", (prefs.getInt("prefBalanceSetting") ?? 10000) - sum);
      prefs.setInt("prefExpense", sum);
    });
  }

  SliverToBoxAdapter SystemSettingTile(BuildContext context) {
    return SliverToBoxAdapter(
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
                BalanceSettingTile(context),
                const Divider(),
                const DisplaySettingTile()
              ],
            )),
      ),
    );
  }

  Theme BalanceSettingTile(BuildContext context) {
    return Theme(
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
          SetBalanceTile(context),
          IncreaseBalanceTile(context),
          SetStartDateTile(context)
        ],
      ),
    );
  }

  ListTile SetStartDateTile(BuildContext context) {
    return ListTile(
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
                                keyboardType: Platform.isIOS
                                    ? const TextInputType.numberWithOptions(
                                        signed: true, decimal: true)
                                    : TextInputType.number,
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 5, 10, 5),
                                    border: OutlineInputBorder(),
                                    hintText: "1~15 的起始日期"),
                                validator: (text) {
                                  if (text == null ||
                                      text.isEmpty ||
                                      int.parse(text) > 15 ||
                                      int.parse(text) < 1) {
                                    return '請輸入 1~15 的起始日期。';
                                  }
                                  return null;
                                },
                                controller: startDateTextController,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          if (_formKey.currentState!.validate()) {
                            /*
                                                setStartDate(int.parse(
                                                    textControllerStartDate
                                                        .text));
                                                setExpense(int.parse(
                                                    textControllerStartDate
                                                        .text));

                                                 */
                            setStartDate(
                                int.parse(startDateTextController.text));
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: const MyApp(),
                                  );
                                },
                              ),
                              (Route<dynamic> route) => false,
                            );
                          }
                        },
                        color: Colors.greenAccent,
                        child: const Text(
                          "確定",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  )
                ],
              );
            });
      },
    );
  }

  ListTile IncreaseBalanceTile(BuildContext context) {
    return ListTile(
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
                                keyboardType: Platform.isIOS
                                    ? const TextInputType.numberWithOptions(
                                        signed: true, decimal: true)
                                    : TextInputType.number,
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 5, 10, 5),
                                    border: OutlineInputBorder(),
                                    hintText: "金額"),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return '請輸入金額';
                                  }
                                  return null;
                                },
                                controller: balanceTextController,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          if (_formKey.currentState!.validate()) {
                            incrementBalance(
                                int.parse(balanceTextController.text));
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: const MyApp(),
                                  );
                                },
                              ),
                              (Route<dynamic> route) => false,
                            );
                          }
                        },
                        color: Colors.greenAccent,
                        child: const Text(
                          "確定",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  )
                ],
              );
            });
      },
    );
  }

  ListTile SetBalanceTile(BuildContext context) {
    return ListTile(
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
                                keyboardType: Platform.isIOS
                                    ? const TextInputType.numberWithOptions(
                                        signed: true, decimal: true)
                                    : TextInputType.number,
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 5, 10, 5),
                                    border: OutlineInputBorder(),
                                    hintText: "金額"),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return '請輸入金額';
                                  }
                                  return null;
                                },
                                controller: balanceTextController,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          if (_formKey.currentState!.validate()) {
                            setBalance(int.parse(balanceTextController.text));
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: const MyApp(),
                                  );
                                },
                              ),
                              (Route<dynamic> route) => false,
                            );
                          }
                        },
                        color: Colors.greenAccent,
                        child: const Text(
                          "確定",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  )
                ],
              );
            });
      },
    );
  }
}

class DisplaySettingTile extends StatelessWidget {
  const DisplaySettingTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
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
    );
  }
}

class CloudBackUpTile extends StatelessWidget {
  const CloudBackUpTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
                  fontWeight: FontWeight.w600, color: Colors.deepOrange[300]),
            ),
            trailing: Text(
              "重新同步",
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600, color: Colors.green[700]),
            ),
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;
  const Title({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 20, 25, 0),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
