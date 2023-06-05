import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:accounting/model/DatabaseHelper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:accounting/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  DateTime _selectedDate = DateTime.now();
  List<bool> isSelected = [true, false, false];
  final bool _validate = false;
  final dbHelper = DatabaseHelper.instance;
  var categoryController = TextEditingController(text: "餐飲");
  final amountController = TextEditingController();
  var timeController = TextEditingController();
  final format = DateFormat('yyyy / M / d EEE', "zh_CN");
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> expenses = [];

  /// 減少餘額
  decreaseBalance(int amount, DateTime date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (DateTime.now().month == date.month) {
      setState(() {
        int balance = (prefs.getInt("prefBalance") ?? 10000) - amount;
        prefs.setInt("prefBalance", balance);
      });
    }
  }

  /// 增加花費
  incrementExpense(int amount, DateTime date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 取得起始日
    int prefixDate = prefs.getInt("prefStartDate") ?? 1;

    bool dateCondition2() {
      var startDate = DateTime(date.year, date.month - 1, prefixDate)
              .millisecondsSinceEpoch ~/
          1000;
      var endDate = DateTime(date.year, date.month, prefixDate - 1)
              .millisecondsSinceEpoch ~/
          1000;

      /*
      print(
          "startDate: ${startDate} ${DateTime(date.year, date.month - 1, prefixDate)}");
      print(
          "endDate: ${endDate} ${DateTime(date.year, date.month, prefixDate - 1)}");
      print("Condition: ${endDate} < Date > ${startDate}");
      print("Result： ${date.millisecondsSinceEpoch ~/ 1000 > startDate}");
      print("Result： ${date.millisecondsSinceEpoch ~/ 1000 < endDate}");

       */

      return date.millisecondsSinceEpoch ~/ 1000 > startDate &&
          endDate < date.millisecondsSinceEpoch ~/ 1000;
    }

    bool dateCondition1() {
      return prefixDate == 1 && DateTime.now().month == date.month;
    }

    //print("dateCondition1() ${dateCondition1()}");
    //print("dateCondition2() ${dateCondition2()}");

    // 判斷起始日是否為 1，且新增日期是否為本月。
    if (dateCondition1() && dateCondition2()) {
      //print("Condition ? PASS");
      setState(() {
        int expense = (prefs.getInt("prefExpense") ?? 0) + amount;
        prefs.setInt("prefExpense", expense);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    timeController = TextEditingController(text: format.format(_selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      // soN (201:30)
      width: double.infinity,
      height: 500,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 30, 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    '新增消費紀錄',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.2125,
                      color: Colors.blueGrey[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close_rounded,
                      size: 24,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
            indent: 15,
            endIndent: 15,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 28, 60, 6),
            child: TextFormFieldAmount(
                formKey: _formKey, amountController: amountController),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(55, 0, 55, 28),
            child: Row(
              children: [categorySelector()],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 0, 60, 12),
            child: textFormFieldDate(context),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 0, 60, 28),
            child: Container(
              height: 36,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ToggleButtons(
                    textStyle: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 1.2125,
                    ),
                    color: const Color(0xff6b6b6b), // 文字的顏色
                    selectedColor: Colors.greenAccent[700], // 被選取的文字的顏色
                    fillColor: Colors.green[50], // 被選取的背景顏色
                    highlightColor: const Color(0xffeaeaea),
                    selectedBorderColor: Colors.greenAccent[700],
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    constraints: BoxConstraints.expand(
                        width: constraints.maxWidth / 3.05),
                    isSelected: isSelected,
                    onPressed: (int index) {
                      _dateChange(index);
                    },
                    children: const [Text("今日"), Text("昨日"), Text("前日")],
                  );
                },
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 120,
                    height: 35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          //primary: const Color(0xff3b3b3b)),
                          primary: Colors.transparent),
                      child: const Text(
                        '取消',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          //primary: const Color(0xff3b3b3b)),
                          primary: Colors.greenAccent),
                      child: const Text(
                        '確定',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseHelper.instance.addExpense(
                            Expense(
                                category: categoryController.text,
                                dateTime:
                                    _selectedDate.millisecondsSinceEpoch ~/
                                        1000,
                                amount: int.parse(amountController.text)),
                          );
                          decreaseBalance(
                              int.parse(amountController.text), _selectedDate);
                          incrementExpense(
                              int.parse(amountController.text), _selectedDate);

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
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Expanded categorySelector() {
    return Expanded(
      child: Scrollbar(
        thumbVisibility: false,
        trackVisibility: true,
        showTrackOnHover: true,
        thickness: 3,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _CategoriesView(
            onCategoryValueChanged: (String value) {
              _updateCategoryValue(value);
            },
          ),
        ),
      ),
    );
  }

  void _updateCategoryValue(String newValue) {
    setState(() {
      categoryController.text = newValue;
    });
  }

  TextFormField textFormFieldDate(BuildContext context) {
    return TextFormField(
      controller: timeController,
      style: const TextStyle(
        fontSize: 14,
      ),
      keyboardType: Platform.isIOS
          ? const TextInputType.numberWithOptions(signed: true, decimal: true)
          : TextInputType.number,
      readOnly: true,
      decoration: InputDecoration(
          labelText: '消費日期',
          labelStyle: const TextStyle(fontSize: 14),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          border: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.greenAccent[700]!),
          ),
          hintText: "$_selectedDate",
          hintStyle: const TextStyle(fontSize: 14)),
      validator: (text) {
        if (text == null || text.isEmpty) {
          return '請輸入金額';
        }
        return null;
      },
      onTap: () {
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff3b3b3b),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff000000),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        timeController
          ..text = format.format(_selectedDate)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: timeController.text.length,
              affinity: TextAffinity.upstream));
      });
    }
  }

  void _dateChange(int index) {
    setState(() {
      // 如果點選的已經是 true，那麼就不反應，
      // 如果點選的不是 true，那麼將現在的改為 false，點選的改為 true。
      if (isSelected[index] == false) {
        isSelected[index] = !isSelected[index];
      }

      // 將其他選項的選中狀態設為 false
      for (int i = 0; i < isSelected.length; i++) {
        if (i != index) isSelected[i] = false;
      }

      switch (index) {
        case 0:
          setState(() {
            _selectedDate = DateTime.now();
            timeController =
                TextEditingController(text: format.format(DateTime.now()));
          });
          break;
        case 1:
          setState(() {
            _selectedDate = DateTime.now().subtract(const Duration(days: 1));
            timeController = TextEditingController(
                text: format
                    .format(DateTime.now().subtract(const Duration(days: 1))));
          });
          break;
        case 2:
          setState(() {
            _selectedDate = DateTime.now().subtract(const Duration(days: 2));
            timeController = TextEditingController(
                text: format
                    .format(DateTime.now().subtract(const Duration(days: 2))));
          });
          break;
      }
    });
  }

  Widget amountTextField(double left, double top, double right, double bottom) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: Row(
        children: [
          Container(
            width: 191,
            height: 29,
            decoration: BoxDecoration(
              color: const Color(0xffeaeaea),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: amountController,
              textAlign: TextAlign.right,
              keyboardType: Platform.isIOS
                  ? const TextInputType.numberWithOptions(
                      signed: true, decimal: true)
                  : TextInputType.number,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 1.2125,
                color: const Color(0xff6b6b6b),
              ),
              decoration: InputDecoration(
                errorText: _validate ? "請輸入金額" : null,
                errorBorder: OutlineInputBorder(
                  borderSide: _validate
                      ? const BorderSide(width: 3, color: Colors.redAccent)
                      : BorderSide.none,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: Colors.greenAccent[700]!),
                ),
                enabledBorder:
                    const UnderlineInputBorder(borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.fromLTRB(0, 0, 12, 16),
                hintText: _validate ? null : "\$ 0",
                hintStyle: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 1.2125,
                  color: const Color(0xff6b6b6b),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 50,
            height: 29,
            child: Icon(
              Icons.calculate_rounded,
              size: 22.5,
            ),
          )
        ],
      ),
    );
  }

  Widget title(String title) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          height: 20,
          child: Text(
            title,
            style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.blueGrey[800]),
          ),
        )
      ],
    );
  }
}

class TextFormFieldAmount extends StatelessWidget {
  const TextFormFieldAmount({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.amountController,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: amountController,
        keyboardType: Platform.isIOS
            ? const TextInputType.numberWithOptions(signed: true, decimal: true)
            : TextInputType.number,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: '消費金額',
          labelStyle: const TextStyle(fontSize: 14),
          floatingLabelStyle: TextStyle(color: Colors.greenAccent[700]!),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          border: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.greenAccent[700]!),
          ),
        ),
        validator: (text) {
          if (text == null || text.isEmpty) {
            return '請輸入金額';
          }
          return null;
        },
      ),
    );
  }
}

class _CategoriesView extends StatefulWidget {
  final ValueChanged<String> onCategoryValueChanged;
  const _CategoriesView({required this.onCategoryValueChanged, Key? key})
      : super(key: key);

  @override
  State<_CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<_CategoriesView> {
  void handleCategoryValueChange(String newValue) {
    print("handle:${newValue}");
    // 執行數值更改後的相關邏輯
    // 將更改後的數值回傳給父組件
    widget.onCategoryValueChanged(newValue);
  }

  int groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: MediaQuery.of(context).size.height * 0.1,
      height: 100,
      //width: MediaQuery.of(context).size.width * 0.9,
      width: 550,
      child: Container(
        alignment: Alignment.center,
        child: CupertinoSlidingSegmentedControl<int>(
          backgroundColor: Colors.transparent,
          thumbColor: Colors.greenAccent, // 被選擇的顏色
          padding: const EdgeInsets.all(5),
          groupValue: groupValue,
          children: {
            0: buildSegment(Icons.dining_outlined, "餐飲", context),
            1: buildSegment(Icons.food_bank_outlined, "食材", context),
            2: buildSegment(Icons.checkroom_rounded, "服飾", context),
            3: buildSegment(Icons.other_houses_outlined, "家用", context),
            4: buildSegment(Icons.sports_bar_rounded, "娛樂", context),
            5: buildSegment(Icons.local_gas_station_outlined, "交通", context),
            6: buildSegment(Icons.wifi_rounded, "電信", context),
            7: buildSegment(Icons.health_and_safety_outlined, "健康", context),
            8: buildSegment(Icons.lightbulb_outline_rounded, "學習", context),
            9: buildSegment(Icons.shopping_bag_outlined, "購物", context),
            10: buildSegment(Icons.money_off_csred_rounded, "費用", context),
            11: buildSegment(Icons.list_alt_rounded, "雜費", context),
          },
          onValueChanged: (value) {
            setState(() {
              groupValue = value!;
              switch (value) {
                case 0:
                  handleCategoryValueChange("餐飲");
                  print("餐飲");
                  break;
                case 1:
                  handleCategoryValueChange("食材");
                  print("食材");
                  break;
                case 2:
                  handleCategoryValueChange("服飾");
                  print("服飾");
                  break;
                case 3:
                  handleCategoryValueChange("家用");
                  print("家用");
                  break;
                case 4:
                  handleCategoryValueChange("娛樂");
                  print("娛樂");
                  break;
                case 5:
                  handleCategoryValueChange("交通");
                  print("交通");
                  break;
                case 6:
                  handleCategoryValueChange("通訊");
                  print("通訊");
                  break;
                case 7:
                  handleCategoryValueChange("健康");
                  print("健康");
                  break;
                case 8:
                  handleCategoryValueChange("學習");
                  print("學習");
                  break;
                case 9:
                  handleCategoryValueChange("購物");
                  print("購物");
                  break;
                case 10:
                  handleCategoryValueChange("費用");
                  print("費用");
                  break;
                case 11:
                  handleCategoryValueChange("雜費");
                  print("雜費");
                  break;
              }
            });
          },
        ),
      ),
    );
  }

  Widget buildSegment(
      IconData categoryIcon, String categoryTitle, BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.085,
      //height: 65,
      width: MediaQuery.of(context).size.width * 0.95,
      //width: 550,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(categoryIcon, size: 28, color: Colors.grey),
          Text(
            categoryTitle,
            style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 1.2125,
                color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
