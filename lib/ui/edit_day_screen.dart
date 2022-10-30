import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mealplan/models/meal_planned.dart';
import 'package:mealplan/models/week_plan_store.dart';
import 'package:mealplan/ui/meal_type_select.dart';
import 'package:provider/provider.dart';

class EditDayScreen extends StatefulWidget {
  const EditDayScreen({required this.mealPlanned, Key? key}) : super(key: key);

  final MealPlanned mealPlanned;

  @override
  EditDayScreenState createState() => EditDayScreenState();
}

class EditDayScreenState extends State<EditDayScreen> {
  @override
  void initState() {
    super.initState();
    newDescription = widget.mealPlanned.description;
    newType = widget.mealPlanned.type;
    day = widget.mealPlanned.day;
    date = widget.mealPlanned.date;
  }

  String day = "";
  String date = "";
  String newDescription = '';
  String newType = '';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    void saveClick(BuildContext context) async {
      var newItem = MealPlanned(day, date, newType, newDescription);
      Provider.of<WeekPlanStore>(context, listen: false).setItem(newItem);
      Navigator.pop(context);
    }

    String getDayTranslated(BuildContext context, String day) {
      var map = {
        'zondag': AppLocalizations.of(context)!.sunday,
        'sunday': AppLocalizations.of(context)!.sunday,
        'maandag': AppLocalizations.of(context)!.monday,
        'monday': AppLocalizations.of(context)!.monday,
        'dinsdag': AppLocalizations.of(context)!.tuesday,
        'tuesday': AppLocalizations.of(context)!.tuesday,
        'woensdag': AppLocalizations.of(context)!.wednesday,
        'wednesday': AppLocalizations.of(context)!.wednesday,
        'donderdag': AppLocalizations.of(context)!.thursday,
        'thursday': AppLocalizations.of(context)!.thursday,
        'vrijdag': AppLocalizations.of(context)!.friday,
        'friday': AppLocalizations.of(context)!.friday,
        'zaterdag': AppLocalizations.of(context)!.saturday,
        'saturday': AppLocalizations.of(context)!.saturday,
      };
      
      return map[day] ?? 'Unknown';
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green.shade800,
            title: Text(
                '${AppLocalizations.of(context)!.planFor} ${getDayTranslated(context, day)}'),
            automaticallyImplyLeading: false),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MealTypeSelect(
                            initialSelectedType: newType,
                            onChange: (type) {
                              newType = type;
                            }),
                        TextFormField(
                          style: const TextStyle(fontSize: 21),
                          initialValue: newDescription,
                          onChanged: (text) {
                            newDescription = text;
                          },
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText:
                                AppLocalizations.of(context)!.mealDescription,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      saveClick(context);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.save,
                                      style: const TextStyle(fontSize: 21),
                                    )))),
                        Center(
                            child: TextButton(
                                onPressed: () => {Navigator.pop(context)},
                                child: Text(
                                  AppLocalizations.of(context)!.back,
                                  style: const TextStyle(fontSize: 17),
                                )))
                      ],
                    )))));
  }
}
