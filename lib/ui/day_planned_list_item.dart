import 'package:flutter/material.dart';
import 'package:mealplan/main.dart';
import 'package:mealplan/models/meal_planned.dart';
import 'package:mealplan/ui/edit_day_screen.dart';
import 'package:mealplan/ui/'
    'meal_icons.dart';

class DayPlannedListItem extends StatelessWidget {
  DayPlannedListItem({
    required this.mealPlanned,
    required this.onOpenMealPlanned,
  }) : super(key: ObjectKey(mealPlanned));
  final MealPlanned mealPlanned;
  final DayClickedCallBack onOpenMealPlanned;
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    IconData getIcon(String type) {
      if (type == "🍃") {
        return Meal.leaf_1;
      }
      if (type == "🍖") {
        return Meal.meat;
      }
      if (type == "🐟") {
        return Meal.fish;
      }

      return Meal.food;
    }

    String getShortDay(String day) {
      return day.substring(0, 2).toUpperCase();
    }

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                EditDayScreen(mealPlanned: mealPlanned),
            fullscreenDialog: true,
          ),
        );
        onOpenMealPlanned(mealPlanned);
      },
      leading:
          Icon(getIcon(mealPlanned.type), color: Colors.lightGreen.shade800),
      title: Text(mealPlanned.description, style: _biggerFont),
      trailing: CircleAvatar(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        child: Text(getShortDay(mealPlanned.day)),
      ),
    );
  }
}
