import 'package:flutter/material.dart';
import 'package:mealplan/models/plan.dart';
import 'package:mealplan/models/week_plan.dart';
import 'package:mealplan/ui/days_of_week.dart';
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
      pageController.previousPage(duration: pageTurnDuration, curve: pageTurnCurve);
    }

    void nextWeek() {
      pageController.nextPage(duration: pageTurnDuration, curve: pageTurnCurve);
    }

    void currentWeek() {
      pageController.jumpToPage(3);
    }

    return FutureBuilder<List<Plan>>(
        future: Provider.of<WeekPlan>(context, listen: false).fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Er is iets mis gegaan!'),
            );
          } else if (snapshot.hasData) {
            return Scaffold(
                key: scaffoldKey,
                drawer: Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        const DrawerHeader(
                          decoration: BoxDecoration(
                            color: Colors.lightGreen,
                          ),
                          child: Text('Maaltijdplan v0.0.5'),
                        ),
                        ListTile(
                            leading: const Icon(Meal.food),
                            title: const Text("Ververs data"),
                            onTap: ()  {
                              Provider.of<WeekPlan>(context, listen: false).fetch().then((value) => null);
                              scaffoldKey.currentState?.closeDrawer();
                            }),
                        ListTile(
                            leading: const Icon(Meal.arrow_back),
                            title: const Text('Vorige week'),
                            onTap: () => {prevWeek()}),
                        ListTile (
                            leading: const Icon(Meal.arrow_forward),
                            title: const Text('Volgende week'),
                            onTap: () => {nextWeek()}),
                        ListTile (
                            leading: const Icon(Meal.meat),
                            title: const Text('Instellingen'),
                            onTap: () => {
                            Navigator.push(
                            context,
                              MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const SettingScreen(),
                              fullscreenDialog: true,
                            ),)}),
                      ],)
                ),
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(Meal.food),
                    onPressed: () => scaffoldKey.currentState?.openDrawer()
                  ),
                  title: GestureDetector(
                    onDoubleTap: () => {currentWeek()},
                    child: Consumer<WeekPlan>(builder: (context, plan, child) {
                      String title =
                          "Maaltijden week ${plan.week} ${plan.year}";
                      return Text(title);
                    }),
                  ),
                ),
                body: PageView.builder(
                  itemBuilder: (context, position) {
                    return Consumer<WeekPlan>(
                      builder: (context, plan, child) {
                        return DayOfWeeks(days: plan.plans[position].items);
                      },
                    );
                  },
                  controller: pageController,
                  itemCount: 6,
                  onPageChanged: (position) {
                    Provider.of<WeekPlan>(context, listen: false).weekBaseOnPosition(position);
                    }
                ));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
