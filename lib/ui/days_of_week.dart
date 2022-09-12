import 'package:flutter/material.dart';
import 'package:mealplan/models/meal_planned.dart';
import 'package:mealplan/ui/day_planned_list_item.dart';


class DayOfWeeks extends StatelessWidget {
  const DayOfWeeks({required this.days, super.key});

  final List<MealPlanned> days;

  @override
  Widget build(BuildContext context) {
    void _handleClick(MealPlanned mealPlanned) {}
    return ListView.separated(
      padding: const EdgeInsets.only(left: 0, top: 8.0, right: 0, bottom: 8.0),
      itemCount: days.length,
      itemBuilder: (context, i) {
        return DayPlannedListItem(
          mealPlanned: days[i],
          onOpenMealPlanned: _handleClick,
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
