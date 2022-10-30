import 'dart:convert';


class MealPlanned {

  const MealPlanned(this.day, this.date, this.type, this.description);

  final String day;
  final String date;
  final String description;
  final String type;

  String toJson() {
    return json.encode({
      "day": day,
      "date": date,
      "type": type,
      "description": description
    });
  }

  factory MealPlanned.fromJson(dynamic json) {
    return MealPlanned(json['day'], json['date'], json['type'],json['description']);
  }


}
