import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealplan/models/meal_planned.dart';
import 'package:mealplan/models/week_plan.dart';
import 'package:mealplan/ui/week_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      localizationsDelegates: const {
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      },
      supportedLocales: const [
        Locale('nl', ''),
        Locale('en', ''),
      ],
      theme: ThemeData(
          textTheme: GoogleFonts.montserratAlternatesTextTheme(
              Theme.of(context).textTheme),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
          scaffoldBackgroundColor: Colors.lightGreen.shade50),
      initialRoute: '/',
      routes: {'/': (context) => const WeekScreen()},
    );
  }
}
