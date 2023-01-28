import 'package:flutter/material.dart';

class CreateExpensePage extends StatefulWidget {
  @override
  State<CreateExpensePage> createState() => _CreateExpensePageState();
}

class _CreateExpensePageState extends State<CreateExpensePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      //child: Text("新增花費頁"),
      child: ElevatedButton(
        child: const Text("Open"),
        onPressed: () {
          _CreateExpensePage();
        },
      ),
    );
  }

  void _CreateExpensePage() {
    showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400,
            color: Colors.black,
            child: Center(
              child: ElevatedButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
  }
}
