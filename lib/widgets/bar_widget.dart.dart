import 'package:flutter/material.dart';
import 'package:neodocs_assignment/models/bar_section_model.dart';

class BarWidget extends StatefulWidget {
  const BarWidget(
      {super.key, required this.listenableValue, required this.data});
  final ValueNotifier<int> listenableValue;
  final List<BarSectionModel> data;
  @override
  State<BarWidget> createState() => _BarWidgetState();
}

class _BarWidgetState extends State<BarWidget> {
  @override
  Widget build(BuildContext context) {
    final double barWidth = MediaQuery.of(context).size.width * .8;
    final double iconSize = MediaQuery.of(context).size.width * .05;
    final double containerWidth = MediaQuery.of(context).size.width * .95;

    final int realBarLength = widget.data.last.range.upperLimit;
    return SizedBox(
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
                      Bar(
                        barWidth: barWidth,
                        realBarLength: realBarLength,
                        data: widget.data,
                      ),
                      ...List.generate(
                        widget.data.length,
                        (index) => Positioned(
                          top: 0,
                          left: barWidth *
                                  widget.data[index].range.upperLimit /
                                  realBarLength +
                              (containerWidth - barWidth) / 2 -
                              7,
                          child: Text(
                            ((index == 0) || index % 2 == 0) ||
                                    (index == widget.data.length - 1 &&
                                        index % 2 != 0)
                                ? widget.data[index].range.upperLimit.toString()
                                : "",
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      ...List.generate(
                        widget.data.length,
                        (index) => Positioned(
                          bottom: 0,
                          left: (barWidth *
                                  widget.data[index].range.lowerLimit /
                                  realBarLength) +
                              (containerWidth - barWidth) / 2 -
                              (index == 0 ? 3 : 7),
                          child: Text(
                            index % 2 == 0
                                ? widget.data[index].range.lowerLimit.toString()
                                : "",
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              BarPointer(
                widget: widget,
                barWidth: barWidth,
                iconSize: iconSize,
                realBarLength: realBarLength,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BarPointer extends StatelessWidget {
  const BarPointer({
    super.key,
    required this.widget,
    required this.barWidth,
    required this.iconSize,
    required this.realBarLength,
  });

  final BarWidget widget;
  final double barWidth;
  final double iconSize;
  final int realBarLength;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.listenableValue,
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
    );
  }
}

class Bar extends StatelessWidget {
  const Bar({
    super.key,
    required this.barWidth,
    required this.realBarLength,
    required this.data,
  });

  final double barWidth;
  final int realBarLength;
  final List<BarSectionModel> data;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: barWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(data.length, (index) {
            double sectionWidthPercentage =
                (data[index].range.upperLimit - data[index].range.lowerLimit) /
                    realBarLength;
            return SizedBox(
              width: barWidth * sectionWidthPercentage,
              child: Container(
                width: barWidth * sectionWidthPercentage,
                height: 20,
                color: colorMap[data[index].color],
              ),
            );
          }),
        ),
      ),
    );
  }
}

Map<String, Color> colorMap = {
  'Red': Colors.red,
  'Orange': Colors.orange,
  'Green': Colors.green,
};
