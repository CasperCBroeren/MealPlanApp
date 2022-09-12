import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealplan/models/meal_planned.dart';
import 'package:mealplan/models/plan.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WeekPlan extends ChangeNotifier {
  final String defaultAccount = 'public';

  Future<List<Plan>> fetch() async {
    final prefs = await SharedPreferences.getInstance();
    final headers = {
      'x-account': prefs.getString('account') ?? defaultAccount,
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http
        .get(Uri.parse('https://mealplaapi.azurewebsites.net/weekPlan'),
        headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic>  data = jsonDecode(response.body);

      List<dynamic> items = data['plans'];
      _plans = List<Plan>.from(
          items.map((model) => Plan.fromJson(model)));
      notifyListeners();
      return _plans;
    }
    throw Exception('Failed to load plans');
  }

  static int isoWeekNumber(DateTime date) {
    int daysToAdd = DateTime.thursday - date.weekday;
    DateTime thursdayDate = daysToAdd > 0
        ? date.add(Duration(days: daysToAdd))
        : date.subtract(Duration(days: daysToAdd.abs()));
    int dayOfYearThursday = dayOfYear(thursdayDate);
    return 1 + ((dayOfYearThursday - 1) / 7).floor();
  }

  static int dayOfYear(DateTime date) {
    return date.difference(DateTime(date.year, 1, 1)).inDays;
  }
  List<Plan> _plans = [];
  int year = DateTime.now().year;
  int week = isoWeekNumber(DateTime.now());

  UnmodifiableListView<Plan> get plans => UnmodifiableListView(_plans);

  void setItem(MealPlanned item)  {
    Plan plan = _plans.firstWhere((x) => x.week == week && x.year == year);
    int indexOfDay = plan.items.indexWhere((element) => element.day == item.day);
    plan.items.removeAt(indexOfDay);
    plan.items.insert(indexOfDay, item);

    SharedPreferences.getInstance().then((prefs) =>
    {
        http.put(Uri.parse('https://mealplaapi.azurewebsites.net/mealPlan'),
                headers:  {
                    'x-account': prefs.getString('account') ?? defaultAccount,
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: item.toJson())
                    .then((response) => {
                notifyListeners()
                })});


  }

  void weekBaseOnPosition(int position)  {
    Plan plan = _plans[position];
    year = plan.year;
    week = plan.week;
    notifyListeners();
  }

  void setToCurrentWeek() {
    year = DateTime.now().year;
    week = isoWeekNumber(DateTime.now());

    notifyListeners();
  }
}
