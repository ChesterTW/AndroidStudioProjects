import 'package:flutter/material.dart';

Widget categoryIcon(category) {
  switch (category) {
    case "餐飲":
      //print("widget.date:${widget.date}");
      return const Icon(
        Icons.dining_outlined,
        size: 40,
      );
    case "食材":
      return const Icon(
        Icons.food_bank_outlined,
        size: 40,
      );
    case "服飾":
      return const Icon(
        Icons.checkroom_rounded,
        size: 40,
      );
    case "家用":
      return const Icon(
        Icons.other_houses_outlined,
        size: 40,
      );
    case "娛樂":
      return const Icon(
        Icons.sports_bar_rounded,
        size: 40,
      );
    case "交通":
      return const Icon(
        Icons.local_gas_station_outlined,
        size: 40,
      );
    case "通訊":
      return const Icon(
        Icons.wifi_rounded,
        size: 40,
      );
    case "健康":
      return const Icon(
        Icons.health_and_safety_outlined,
        size: 40,
      );
    case "學習":
      return const Icon(
        Icons.lightbulb_outline_rounded,
        size: 40,
      );
    case "購物":
      return const Icon(
        Icons.shopping_bag_outlined,
        size: 40,
      );
    case "費用":
      return const Icon(
        Icons.money_off_csred_rounded,
        size: 40,
      );
    case "雜費":
      return const Icon(
        Icons.list_alt_rounded,
        size: 40,
      );
  }

  return const Icon(
    Icons.question_mark_rounded,
    size: 40,
  );
}
