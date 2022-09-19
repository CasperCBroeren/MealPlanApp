import 'package:flutter/material.dart';
import 'package:mealplan/models/meal_planned.dart';
import 'package:mealplan/models/week_plan.dart';
import 'package:mealplan/ui/meal_type_select.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditDayScreen extends StatelessWidget {
  EditDayScreen({required this.mealPlanned, Key? key}) : super(key: key)  {
    newDescription = mealPlanned.description;
    newType = mealPlanned.type;
  }
  final MealPlanned mealPlanned;
  String newDescription = '';
  String newType= '';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    void saveClick(BuildContext context) async {
       var newItem = MealPlanned(mealPlanned.day, mealPlanned.date, newType, newDescription);
       Provider.of<WeekPlan>(context, listen: false).setItem(newItem);
       Navigator.pop(context);
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lime,
            title: Text('${AppLocalizations.of(context)!.planFor} ${mealPlanned.day}'),
            automaticallyImplyLeading: false),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MealTypeSelect(initialSelectedType: mealPlanned.type, onChange: (type) {
                          newType = type;
                        }),
                        TextFormField(
                          style: const TextStyle(fontSize: 21),
                          initialValue: mealPlanned.description,
                          onChanged: (text){
                            newDescription = text;
                          },
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: AppLocalizations.of(context)!.mealDescription,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Center(
                                child: ElevatedButton(
                                    onPressed: ()  {saveClick(context);},
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
