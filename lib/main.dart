import 'package:flutter/material.dart';
import 'package:neodocs_assignment/models/data.dart';
import 'package:neodocs_assignment/widgets/bar_form.dart';
import 'package:neodocs_assignment/widgets/bar_widget.dart.dart';

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
  @override
  void initState() {
    _listenableValue = ValueNotifier<int>(0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BarWidget(
            listenableValue: _listenableValue,
            data: data,
          ),
          SizedBox(
            height: 20,
          ),
          BarForm(
            listenableValue: _listenableValue,
          )
        ],
      )),
    );
  }
}
