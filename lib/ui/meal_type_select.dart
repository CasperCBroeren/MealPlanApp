import 'package:flutter/material.dart';
import 'package:mealplan/ui/meal_icons.dart';

class MealTypeSelect extends StatefulWidget {
  const MealTypeSelect({
    required this.initialSelectedType,
    required this.onChange,
    Key? key,
  }) : super(key: key);
  final String initialSelectedType;
  final Function(String type) onChange;

  @override
  State<MealTypeSelect> createState() => MealTypeSelectState();
}


class MealTypeSelectState extends State<MealTypeSelect> {
  @override
  initState() {
    super.initState();
    selectedType = widget.initialSelectedType;
  }

  String selectedType = "";

  Color getColor(String type, String selected) {
    if (type == selected) {
      return Colors.lightGreen.shade900;
    }
    return Colors.lightGreen.shade200;
  }

  void setType(String type) {
    setState(() {
      selectedType = type;
      widget.onChange(type);
    });
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 70;
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.002),
        height: MediaQuery.of(context).size.height * 0.2,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  setType("🍃");
                },
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Icon(Meal.leaf_1,
                        size: iconSize, color: getColor("🍃", selectedType)))),
            GestureDetector(
                onTap: () {
                  setType( "🍖");
                },
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Icon(Meal.meat,
                        size: iconSize, color: getColor("🍖", selectedType)))),
            GestureDetector(
                onTap: () {
                  setType("🐟");
                },
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Icon(Meal.fish,
                        size: iconSize, color: getColor("🐟", selectedType))))
          ],
        ));
  }
}

