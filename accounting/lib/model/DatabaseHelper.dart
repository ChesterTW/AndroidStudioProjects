import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Expense {
  Expense(
      {this.id,
      required this.category,
      required this.dateTime,
      required this.amount});

  factory Expense.fromMap(Map<String, dynamic> json) => Expense(
        id: json['id'],
        category: json['category'],
        dateTime: json['dateTime'],
        amount: json['amount'],
      );

  final int? id;
  final String category;
  final int dateTime;
  final int amount;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'dateTime': dateTime,
      'amount': amount,
    };
  }
}

class Total {
  Total(
      {required this.category, required this.total, required this.percentage});

  factory Total.fromMap(Map<String, dynamic> json) => Total(
        category: json['category'],
        total: json['total'],
        percentage: json['percentage'],
      );

  final String category;
  final int total;
  final int percentage;

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'total': total,
      'percentage': percentage,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  // Check if Database not Excesses, Create one.
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'expenses.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

// Create Database
  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE expenses(
  id INTEGER PRIMARY KEY,
  category STRING,
  dateTime INTEGER,
  amount INTEGER
  )
  ''');
  }

  Future<List<Expense>> getExpenses() async {
    Database db = await instance.database;
    var expenses = await db.query('expenses', orderBy: 'dateTime');
    List<Expense> expenseList = expenses.isNotEmpty
        ? expenses.map((c) => Expense.fromMap(c)).toList()
        : [];
    return expenseList;
  }

  Future<List<Expense>> getExpensesByDate(String date) async {
    Database db = await instance.database;
    var expenses = await db.rawQuery('''SELECT * FROM expenses 
        WHERE strftime('%Y-%m-%d',datetime(dateTime, 'unixepoch', 'localtime')) = ?''',
        [date]);
    List<Expense> expenseList = expenses.isNotEmpty
        ? expenses.map((c) => Expense.fromMap(c)).toList()
        : [];
    return expenseList;
  }

  Future<List<Total>> getTotalByDate(int startDate) async {
    Database db = await instance.database;

    List<Map<String, Object?>> total = [];

    if (startDate == 1) {
      total = await db.rawQuery('''
        SELECT category, SUM(amount) AS total,
            CAST(SUM(amount) * 100.0 /
            (SELECT SUM(amount) FROM expenses WHERE strftime('%Y-%m', datetime(dateTime, 'unixepoch', 'localtime')) = strftime('%Y-%m', date('now')))
            AS INTEGER) AS percentage
        FROM expenses
        WHERE strftime('%Y-%m', datetime(dateTime, 'unixepoch', 'localtime')) = strftime('%Y-%m', date('now'))
        GROUP BY category
        ORDER BY total DESC;
        ''');
    } else if (DateTime.now().day < startDate) {
      /// 小於設定日期
      total = await db.rawQuery('''
        SELECT category, SUM(amount) AS total,
               CAST(SUM(amount) * 100.0 /
               (SELECT SUM(amount) FROM expenses
                WHERE strftime('%Y-%m-%d', datetime(dateTime, 'unixepoch', 'localtime')) >= date('now', 'start of month', '-1 month', ?)
                AND strftime('%Y-%m-%d', datetime(dateTime, 'unixepoch', 'localtime')) <= date('now', 'start of month', ?))
               AS INTEGER) AS percentage
        FROM expenses
        WHERE strftime('%Y-%m-%d', datetime(dateTime, 'unixepoch', 'localtime')) >= date('now', 'start of month', '-1 month', ?)
        AND strftime('%Y-%m-%d', datetime(dateTime, 'unixepoch', 'localtime')) <= date('now', 'start of month', ?)
        GROUP BY category
        ORDER BY total DESC;
        ''', [
        "+${(startDate - 1).toString()} day",
        "+${(startDate - 2).toString()} day",
        "+${(startDate - 1).toString()} day",
        "+${(startDate - 2).toString()} day"
      ]);
    } else if (DateTime.now().day >= startDate) {
      /// 大於等於設定日期
      total = await db.rawQuery('''
      SELECT category, SUM(amount) AS total,
             CAST(SUM(amount) * 100.0 /
             (SELECT SUM(amount) FROM expenses
              WHERE strftime('%Y-%m-%d', datetime(dateTime, 'unixepoch', 'localtime')) >= date('now', 'start of month', ?)
              AND strftime('%Y-%m-%d', datetime(dateTime, 'unixepoch', 'localtime')) <= date('now', 'start of month', '+1 month', ?))
             AS INTEGER) AS percentage
      FROM expenses
      WHERE strftime('%Y-%m-%d', datetime(dateTime, 'unixepoch', 'localtime')) >= date('now', 'start of month', ?)
      AND strftime('%Y-%m-%d', datetime(dateTime, 'unixepoch', 'localtime')) <= date('now', 'start of month', '+1 month', ?)
      GROUP BY category
      ORDER BY total DESC;
      ''', [
        "+${(startDate - 1).toString()} day",
        "+${(startDate - 2).toString()} day",
        "+${(startDate - 1).toString()} day",
        "+${(startDate - 2).toString()} day"
      ]);
    }

    List<Total> totalList =
        total.isNotEmpty ? total.map((c) => Total.fromMap(c)).toList() : [];

    return totalList;
  }

  Future<int> getSumByDate(int startDate) async {
    Database db = await instance.database;
    List total = [];

    if (startDate == 1) {
      total = await db.rawQuery('''
        SELECT SUM(amount) AS sum
        FROM expenses
        WHERE strftime('%Y-%m', datetime(dateTime, 'unixepoch', 'localtime')) = strftime('%Y-%m', date('now'))
        ORDER BY sum DESC;
        ''');
    } else if (DateTime.now().day < startDate) {
      /// 小於設定日期
      total = await db.rawQuery('''
        SELECT SUM(amount) AS sum
        FROM expenses
        WHERE strftime('%Y-%m-%d', datetime(dateTime, 'unixepoch', 'localtime')) >= date('now', 'start of month', '-1 month', ?)
        AND strftime('%Y-%m-%d', datetime(dateTime, 'unixepoch', 'localtime')) <= date('now', 'start of month', ?)
        ORDER BY sum DESC;
        ''', [
        "+${(startDate - 1).toString()} day",
        "+${(startDate - 2).toString()} day"
      ]);
    } else if (DateTime.now().day >= startDate) {
      /// 大於等於設定日期
      total = await db.rawQuery('''
      SELECT SUM(amount) AS sum
      FROM expenses
      WHERE strftime('%Y-%m-%d', datetime(dateTime, 'unixepoch', 'localtime')) >= date('now', 'start of month', ?)
      AND strftime('%Y-%m-%d', datetime(dateTime, 'unixepoch', 'localtime')) <= date('now', 'start of month', '+1 month', ?)
      ORDER BY sum DESC;
      ''', [
        "+${(startDate - 1).toString()} day",
        "+${(startDate - 2).toString()} day"
      ]);
    }

    List totalList =
        total.isNotEmpty ? total.map((c) => c['sum'] as int).toList() : [];

    //int sum = totalList[0];

    int sum = totalList.isNotEmpty ? totalList[0] : 0;

    return sum;
  }

  // Need to change or not ?
  Future<int> addExpense(Expense expense) async {
    Database db = await instance.database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<int> deleteExpense(int id) async {
    Database db = await instance.database;
    return await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
