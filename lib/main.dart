import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealplan/models/meal_planned.dart';
import 'package:mealplan/models/week_plan.dart';
import 'package:mealplan/ui/week_screen.dart';
import 'package:provider/provider.dart';

typedef DayClickedCallBack = Function(MealPlanned mealPlanned);

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => WeekPlan(), child: const MealPlanner()));
}

class MealPlanner extends StatelessWidget {
  const MealPlanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maaltijdplanner',
      theme: ThemeData(
          textTheme: GoogleFonts.montserratAlternatesTextTheme(
              Theme.of(context).textTheme),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightGreen),
          scaffoldBackgroundColor: Colors.lightGreen.shade50),
      initialRoute: '/',
      routes: {'/': (context) => WeekScreen()},
    );
  }
}
