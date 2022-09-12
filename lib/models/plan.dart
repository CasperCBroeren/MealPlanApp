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
}
