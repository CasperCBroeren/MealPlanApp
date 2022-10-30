import 'dart:convert';

import 'package:mealplan/models/meal_planned.dart';

class Plan {
  const Plan(this.week, this.year, this.items);

  final int week;
  final int year;
  final List<MealPlanned> items;

  factory Plan.fromJson(dynamic json) {

    List<dynamic> items = json['items'];
    return Plan(json['week'],json['year'],  List<MealPlanned>.from(
        items.map((model) => MealPlanned.fromJson(model))));
  }

  factory Plan.fromJsonInternal(dynamic json) {
    List<dynamic> items = jsonDecode(json['items']);
    return Plan(json['week'],json['year'],  List<MealPlanned>.from(
        items.map((model) => MealPlanned.fromJson(jsonDecode(model)))));
  }

  Map<String, dynamic> toJson() {
      return {
        'week': week,
        'year': year,
        'items': jsonEncode(items)
      };
  }
}
