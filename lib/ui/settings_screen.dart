import 'package:flutter/material.dart';
import 'package:mealplan/models/week_plan.dart';
import 'package:mealplan/ui/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen>
{
  String accountSetting = "";

  @override
  void initState()
  {
    super.initState();
    SharedPreferences.getInstance().then((pref) => {
      accountSetting = pref.getString('account') ?? 'public'
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? accountSetting = "boo";
    SharedPreferences.getInstance().then((pref) {
      accountSetting = pref.getString("account");
    });


    void saveClick(BuildContext context) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("account", accountSetting ?? "public");
      Provider.of<WeekPlan>(context, listen: false).fetch().then((value) => null);
      Navigator.pop(context);
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lime,
            title: const Text('Settings'),
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
                          onChanged: (text){
                            accountSetting = text;
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Account',
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Center(
                                child: ElevatedButton(
                                    onPressed: ()  {saveClick(context);},
                                    child: const Text(
                                      "Opslaan",
                                      style: TextStyle(fontSize: 21),
                                    )))),
                        Center(
                            child: TextButton(
                                onPressed: () => {Navigator.pop(context)},
                                child: const Text(
                                  "<< Terug",
                                  style: TextStyle(fontSize: 17),
                                )))
                      ],
                    )))));
  }
}
