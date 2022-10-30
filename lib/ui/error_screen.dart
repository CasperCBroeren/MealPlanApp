import 'package:flutter/material.dart';
import 'package:mealplan/ui/meal_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                          leading: const Icon(Meal.meat),
                          title: Text(
                              AppLocalizations.of(context)!.generalError),
                          subtitle: Text(message))
                    ]))));
  }
}