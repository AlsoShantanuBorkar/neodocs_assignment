import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neodocs_assignment/models/bar_section_model.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final ValueNotifier<int> _listenableValue;
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController(text: "0");
    _listenableValue = ValueNotifier<int>(0);
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double barWidth = MediaQuery.of(context).size.width * .8;
    final double iconSize = MediaQuery.of(context).size.width * .05;
    final double containerWidth = MediaQuery.of(context).size.width * .95;
    List<BarSectionModel> data = List.generate(table["data_from_api"].length,
        (index) => BarSectionModel.fromMap(table["data_from_api"][index]));

    final int realBarLength = data.last.range.upperLimit;
    return MaterialApp(
      home: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: containerWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: SizedBox(
                        width: containerWidth,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: barWidth,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(data.length, (index) {
                                    double sectionWidthPercentage =
                                        (data[index].range.upperLimit -
                                                data[index].range.lowerLimit) /
                                            realBarLength;
                                    return SizedBox(
                                      width: barWidth * sectionWidthPercentage,
                                      child: Container(
                                        width:
                                            barWidth * sectionWidthPercentage,
                                        height: 20,
                                        color: colorMap[data[index].color],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            ...List.generate(
                              data.length,
                              (index) => Positioned(
                                top: 0,
                                left: barWidth *
                                        data[index].range.upperLimit /
                                        realBarLength +
                                    (containerWidth - barWidth) / 2 -
                                    7,
                                child: Text(
                                  ((index == 0) || index % 2 == 0) ||
                                          (index == data.length - 1 &&
                                              index % 2 != 0)
                                      ? data[index].range.upperLimit.toString()
                                      : "",
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            ...List.generate(
                              data.length,
                              (index) => Positioned(
                                bottom: 0,
                                left: (barWidth *
                                        data[index].range.lowerLimit /
                                        realBarLength) +
                                    (containerWidth - barWidth) / 2 -
                                    (index == 0 ? 3 : 7),
                                child: Text(
                                  index % 2 == 0
                                      ? data[index].range.lowerLimit.toString()
                                      : "",
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: _listenableValue,
                      builder: (context, value, child) {
                        return SizedBox(
                          width: barWidth + iconSize,
                          height: 40,
                          child: Stack(
                            children: [
                              Positioned(
                                left: barWidth * value / realBarLength,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      size: iconSize,
                                    ),
                                    Text(
                                      value.toString(),
                                      style: const TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            child: Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: containerWidth / 1.5,
                    height: 50,
                    child: TextFormField(
                      controller: _controller,
                      validator: (value) {
                        if (value == null) {
                          return "Required";
                        }
                        if (value.isEmpty) {
                          return "Enter a value";
                        }

                        if (int.parse(value) > realBarLength) {
                          return "Value cannot be larger than $realBarLength";
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 10),
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 10),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (_controller.text.isEmpty) {
                            _listenableValue.value = 0;
                            return;
                          }
                          if (int.parse(_controller.text) > realBarLength) {
                            _listenableValue.value = 120;
                            return;
                          }

                          _listenableValue.value = int.parse(_controller.text);
                          log(_listenableValue.value.toString());
                        }
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          size: 20,
                        ),
                      )),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

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

Map<String, Color> colorMap = {
  'Red': Colors.red,
  'Orange': Colors.orange,
  'Green': Colors.green,
};
