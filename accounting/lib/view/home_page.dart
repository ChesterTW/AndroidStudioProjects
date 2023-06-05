import 'package:accounting/category_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:accounting/model/DatabaseHelper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:accounting/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int startDate = 1;

  getStartDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// 設置固定值
      startDate = (prefs.getInt("prefStartDate") ?? 1);
    });
  }

  @override
  void initState() {
    super.initState();
    getStartDate();
  }

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        const Title(
          title: '花費佔比',
          seeMoreText: '查看更多',
          seeMoreIcon: Icons.keyboard_arrow_right_rounded,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 0, 0),
            child: SizedBox(
              height: 120,
              child: FutureBuilder<List<Total>>(
                future: DatabaseHelper.instance.getTotalByDate(startDate),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Total>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child:
                            Text('Error loading expenses: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('無花費紀錄'));
                  }

                  final totalList = snapshot.data!;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: totalList.length,
                    itemBuilder: (context, int index) {
                      final total = totalList[index];
                      return ExpenseRatio(total: total);
                    },
                  );
                },
              ),
            ),
          ),
        ),
        const Title(
          title: '花費紀錄',
          seeMoreText: '查看更多',
          seeMoreIcon: Icons.keyboard_arrow_right_rounded,
        ),
        const SliverToBoxAdapter(
          child: CalendarWeeklyView(),
        ),
      ],
    );
  }
}

class ExpenseRatio extends StatelessWidget {
  const ExpenseRatio({
    Key? key,
    required this.total,
  }) : super(key: key);

  final Total total;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 120,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                categoryIcon(total.category),
                Text(
                  "\$${total.total.toString()}",
                  style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${total.percentage.toString()}%",
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;
  final String seeMoreText;
  final IconData seeMoreIcon;
  const Title({
    Key? key,
    required this.title,
    required this.seeMoreText,
    required this.seeMoreIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 30, 35, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.2125,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    seeMoreText,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      height: 1.2125,
                      color: Colors.grey[700],
                    ),
                  ),
                  Icon(
                    seeMoreIcon,
                    size: 14,
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

class SeeMore extends StatelessWidget {
  final String text;
  final IconData icon;
  const SeeMore({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            height: 1.2125,
            color: Colors.grey[700],
          ),
        ),
        Icon(
          icon,
          size: 14,
          color: Colors.grey[700],
        ),
      ],
    );
  }
}

class CalendarWeeklyView extends StatefulWidget {
  const CalendarWeeklyView({super.key});

  @override
  State<CalendarWeeklyView> createState() => _CalendarWeeklyViewState();
}

class _CalendarWeeklyViewState extends State<CalendarWeeklyView> {
  int? groupValue = 0;

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.fromMicrosecondsSinceEpoch(
        DateTime.now().microsecondsSinceEpoch);

    Widget buildSegment(
        String dateAbr, String dateNumber, BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.075,
        width: MediaQuery.of(context).size.width * 0.9,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            dateAbr[0] + dateAbr[1].toUpperCase(),
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(dateNumber, style: GoogleFonts.inter(fontSize: 14)),
        ]),
      );
    }

    DateTime nowDateTime = DateTime.now();

    List<DateTime> pastWeek = [
      nowDateTime,
      nowDateTime.subtract(const Duration(days: 1)),
      nowDateTime.subtract(const Duration(days: 2)),
      nowDateTime.subtract(const Duration(days: 3)),
      nowDateTime.subtract(const Duration(days: 4)),
      nowDateTime.subtract(const Duration(days: 5)),
      nowDateTime.subtract(const Duration(days: 6))
    ];

    Widget calendarBox(BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Container(
            alignment: Alignment.center,
            child: CupertinoSlidingSegmentedControl<int>(
                backgroundColor: Colors.transparent,
                thumbColor: Colors.greenAccent,
                padding: const EdgeInsets.all(5),
                groupValue: groupValue,
                children: {
                  0: buildSegment(
                      DateFormat.EEEE()
                          .format(today.subtract(const Duration(days: 0)))
                          .toString(),
                      DateFormat.d()
                          .format(today.subtract(const Duration(days: 0)))
                          .toString(),
                      context),
                  1: buildSegment(
                      DateFormat.EEEE()
                          .format(today.subtract(const Duration(days: 1)))
                          .toString(),
                      DateFormat.d()
                          .format(today.subtract(const Duration(days: 1)))
                          .toString(),
                      context),
                  2: buildSegment(
                      DateFormat.EEEE()
                          .format(today.subtract(const Duration(days: 2)))
                          .toString(),
                      DateFormat.d()
                          .format(today.subtract(const Duration(days: 2)))
                          .toString(),
                      context),
                  3: buildSegment(
                      DateFormat.EEEE()
                          .format(today.subtract(const Duration(days: 3)))
                          .toString(),
                      DateFormat.d()
                          .format(today.subtract(const Duration(days: 3)))
                          .toString(),
                      context),
                  4: buildSegment(
                      DateFormat.EEEE()
                          .format(today.subtract(const Duration(days: 4)))
                          .toString(),
                      DateFormat.d()
                          .format(today.subtract(const Duration(days: 4)))
                          .toString(),
                      context),
                  5: buildSegment(
                      DateFormat.EEEE()
                          .format(today.subtract(const Duration(days: 5)))
                          .toString(),
                      DateFormat.d()
                          .format(today.subtract(const Duration(days: 5)))
                          .toString(),
                      context),
                  6: buildSegment(
                      DateFormat.EEEE()
                          .format(today.subtract(const Duration(days: 6)))
                          .toString(),
                      DateFormat.d()
                          .format(today.subtract(const Duration(days: 6)))
                          .toString(),
                      context),
                },
                onValueChanged: (value) {
                  setState(() {
                    groupValue = value;
                  });
                })),
      );
    }

    return Column(
      children: [
        calendarBox(context),
        VerticalList(date: pastWeek[groupValue!]),
      ],
    );
  }
}

class VerticalList extends StatefulWidget {
  VerticalList({required this.date});
  late DateTime date;

  @override
  State<VerticalList> createState() => _VerticalListState();
}

class _VerticalListState extends State<VerticalList> {
  @override
  Widget build(BuildContext context) {
    /// 增加餘額
    incrementBalance(int amount, int date) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      /// 欲刪除的日期是這個月的話，才會更動餘額。
      if (DateTime.now().month ==
          DateTime.fromMillisecondsSinceEpoch(date * 1000).month) {
        setState(() {
          /// 增減時，只更動浮動值，在下個月就會被重置為固定值。
          int balance = (prefs.getInt("prefBalance") ?? 10000) + amount;
          prefs.setInt("prefBalance", balance);
        });
      }
    }

    /// 減少花費
    decreaseExpense(int amount, int date) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      /// 欲刪除的日期是這個月的話，才會更動花費。
      if (DateTime.now().month ==
          DateTime.fromMillisecondsSinceEpoch(date * 1000).month) {
        setState(() {
          int expense = (prefs.getInt("prefExpense") ?? 0) - amount;
          prefs.setInt("prefExpense", expense);
        });
      }
    }

    return FutureBuilder<List<Expense>>(
      future: DatabaseHelper.instance
          .getExpensesByDate(DateFormat('yyyy-MM-dd').format(widget.date)),
      builder: (BuildContext context, AsyncSnapshot<List<Expense>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error loading expenses: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const NoExpense();
        }
        final expenses = snapshot.data!;

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 5),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: expenses.length,
          itemBuilder: (context, int index) {
            final expense = expenses[index];
            return Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  shape: const Border(
                    top: BorderSide(width: 0.5, color: Colors.black26),
                  ),
                  leading: expenseIcon(expense: expense),
                  title: expenseAmount(expense: expense),
                  subtitle: expenseCategory(expense: expense),
                  trailing: expenseDate(expense: expense),
                  onLongPress: () {
                    DeleteExpenseDialog(
                        context, expense, incrementBalance, decreaseExpense);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<dynamic> DeleteExpenseDialog(
      BuildContext context,
      Expense expense,
      Future<void> Function(int amount, int date) incrementBalance,
      Future<void> Function(int amount, int date) decreaseExpense) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(
              child: Text("確定刪除該筆紀錄 ？"),
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
                      setState(() {
                        DatabaseHelper.instance.deleteExpense(expense.id!);
                        incrementBalance(expense.amount, expense.dateTime);
                        decreaseExpense(expense.amount, expense.dateTime);
                      });

                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
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
                    },
                    color: Colors.redAccent,
                    child: const Text(
                      "確定",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}

class expenseIcon extends StatelessWidget {
  const expenseIcon({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity, child: categoryIcon(expense.category));
  }
}

class expenseAmount extends StatelessWidget {
  const expenseAmount({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Text(
      "\$ ${expense.amount.toString()}",
      style: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.greenAccent[400],
      ),
    );
  }
}

class expenseCategory extends StatelessWidget {
  const expenseCategory({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Text(
      expense.category,
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w200,
      ),
    );
  }
}

class expenseDate extends StatelessWidget {
  const expenseDate({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('yyyy / M / d EEE', "zh_CN").format(
        DateTime.fromMillisecondsSinceEpoch(expense.dateTime * 1000),
      ),
      style: GoogleFonts.inter(
        fontSize: 14,
      ),
    );
  }
}

class NoExpense extends StatelessWidget {
  const NoExpense({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Divider(
                color: Colors.black38,
                height: 0.5,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  '無花費紀錄',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
