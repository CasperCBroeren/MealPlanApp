import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mealplan/models/plan.dart';
import 'package:mealplan/models/week_plan_store.dart';
import 'package:mealplan/ui/days_of_week.dart';
import 'package:mealplan/ui/error_screen.dart';
import 'package:mealplan/ui/meal_icons.dart';
import 'package:mealplan/ui/settings_screen.dart';
import 'package:provider/provider.dart';

class WeekScreen extends StatelessWidget {
  const WeekScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 3);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    const pageTurnDuration = Duration(milliseconds: 500);
    const pageTurnCurve = Curves.ease;
    void prevWeek() {
      pageController.previousPage(
          duration: pageTurnDuration, curve: pageTurnCurve);
    }

    void nextWeek() {
      pageController.nextPage(duration: pageTurnDuration, curve: pageTurnCurve);
    }

    void currentWeek() {
      pageController.jumpToPage(3);
    }
    var store = Provider.of<WeekPlanStore>(context, listen: false);

    return FutureBuilder<List<Plan>>(
        future: store.fetchFromApi(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorScreen(message: snapshot.error.toString());
          } else {
            return Scaffold(
                key: scaffoldKey,
                drawer: Drawer(
                    child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                      ),
                      child: Text(
                          '${AppLocalizations.of(context)!.applicationTitle} v0.0.5'),
                    ),
                    ListTile(
                        leading: const Icon(Meal.food),
                        title: Text(AppLocalizations.of(context)!.refreshData),
                        onTap: () {
                          Provider.of<WeekPlanStore>(context, listen: false)
                              .fetchFromApi()
                              .then((value) => null);
                          scaffoldKey.currentState?.closeDrawer();
                        }),
                    ListTile(
                        leading: const Icon(Meal.arrowBack),
                        title: Text(AppLocalizations.of(context)!.prevWeek),
                        onTap: () => {prevWeek()}),
                    ListTile(
                        leading: const Icon(Meal.arrowForward),
                        title: Text(AppLocalizations.of(context)!.nextWeek),
                        onTap: () => {nextWeek()}),
                    ListTile(
                        leading: const Icon(Meal.meat),
                        title: Text(AppLocalizations.of(context)!.settings),
                        onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const SettingScreen(),
                                  fullscreenDialog: true,
                                ),
                              )
                            }),
                  ],
                )),
                appBar: AppBar(
                  leading: IconButton(
                      icon: const Icon(Meal.food, color: Colors.black54),
                      onPressed: () => scaffoldKey.currentState?.openDrawer()),
                  title: GestureDetector(
                    onDoubleTap: () => {currentWeek()},
                    child: Consumer<WeekPlanStore>(
                        builder: (context, plan, child) => Text(
                              "${AppLocalizations.of(context)!.mealsOfWeek} ${plan.week} ${plan.year}",
                              style: const TextStyle(color: Colors.black54),
                            )),
                  ),
                ),
                body: PageView.builder(
                    itemBuilder: (context, position) {
                      return Consumer<WeekPlanStore>(
                        builder: (context, plan, child) {
                          return DayOfWeeks(days: plan.plans[position].items);
                        },
                      );
                    },
                    controller: pageController,
                    itemCount: 6,
                    onPageChanged: (position) {
                      Provider.of<WeekPlanStore>(context, listen: false)
                          .weekBaseOnPosition(position);
                    }));
          }
        });
  }
}
