import 'package:flutter/material.dart';
import 'package:mealplan/models/plan.dart';
import 'package:mealplan/models/week_plan.dart';
import 'package:mealplan/ui/days_of_week.dart';
import 'package:mealplan/ui/meal_icons.dart';
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
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return Scaffold(
                key: scaffoldKey,
                drawer: Drawer(

                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        ListTile(
                            leading: const Icon(Meal.food),
                            title: const Text("Refresh"),
                            onTap: ()  {
                              Provider.of<WeekPlan>(context, listen: false).fetch().then((value) => null);
                              scaffoldKey.currentState?.closeDrawer();
                            }),
                        ListTile(
                            leading: const Icon(Meal.arrow_back),
                            title: const Text('Previous week'),
                            onTap: () => {prevWeek()}),
                        ListTile (
                            leading: const Icon(Meal.arrow_forward),
                            title: const Text('Next week'),
                            onTap: () => {nextWeek()}),
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
