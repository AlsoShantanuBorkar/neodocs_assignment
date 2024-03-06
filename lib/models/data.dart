import 'package:neodocs_assignment/models/bar_section_model.dart';

Map<String, dynamic> table = {
  "data_from_api": {
    0: {
      "range": {
        "lowerLimit": 0,
        "upperLimit": 30,
      },
      "meaning": "Dangerous",
      "color": "Red",
    },
    1: {
      "range": {
        "lowerLimit": 30,
        "upperLimit": 40,
      },
      "meaning": "Moderate",
      "color": "Orange",
    },
    2: {
      "range": {
        "lowerLimit": 40,
        "upperLimit": 60,
      },
      "meaning": "Ideal",
      "color": "Green",
    },
    3: {
      "range": {
        "lowerLimit": 60,
        "upperLimit": 70,
      },
      "meaning": "Moderate",
      "color": "Orange",
    },
    4: {
      "range": {
        "lowerLimit": 70,
        "upperLimit": 120,
      },
      "meaning": "Dangerous",
      "color": "Red",
    },
  }
};

List<BarSectionModel> data = List.generate(table["data_from_api"].length,
    (index) => BarSectionModel.fromMap(table["data_from_api"][index]));
