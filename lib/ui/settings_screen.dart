import 'package:flutter/material.dart';
import 'package:mealplan/models/week_plan.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  String accountSetting = "";

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      accountSetting = (prefs.getString('account') ?? 'public');
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    void saveClick(BuildContext context) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("account", accountSetting);
      Provider.of<WeekPlan>(context, listen: false)
          .fetch()
          .then((value) => null);
      Navigator.pop(context);
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lime,
            title: Text(AppLocalizations.of(context)!.settings),
            automaticallyImplyLeading: false),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: const TextStyle(fontSize: 21),
                          initialValue: accountSetting,
                          onChanged: (text) {
                            accountSetting = text;
                          },
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: AppLocalizations.of(context)!.account,
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
