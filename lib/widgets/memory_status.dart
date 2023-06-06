import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:linux_assistant/widgets/hardware_info.dart';
import 'package:linux_assistant/widgets/single_bar_chart.dart';
import 'package:linux_assistant/services/linux.dart';

class MemoryStatus extends StatefulWidget {
  const MemoryStatus({Key? key}) : super(key: key);

  @override
  State<MemoryStatus> createState() => _MemoryStatusState();
}

class _MemoryStatusState extends State<MemoryStatus> {
  @override
  Widget build(BuildContext context) {
    late Future<String> memoryText = Linux.runCommandAndGetStdout("free -m");
    return FutureBuilder<String>(
      future: memoryText,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> lines = snapshot.data!.split("\n");
          List<Widget> widgets = [];

          // RAM
          if (lines.length >= 2) {
            List<String> values = convertLineToList(lines[1]);
            widgets.add(SingleBarChart(
              value: double.parse(values[2]) / double.parse(values[1]),
              fillColor: Color.fromARGB(255, 70, 153, 221),
              tooltip: convertToGB(values[2]) + "/" + convertToGB(values[1]),
              text: "RAM",
            ));
          }

          widgets.add(SizedBox(
            width: 20,
          ));

          // SWAP:
          if (lines.length >= 3) {
            List<String> values = convertLineToList(lines[2]);
            widgets.add(SingleBarChart(
              value: double.parse(values[2]) / double.parse(values[1]),
              fillColor: Color.fromARGB(255, 223, 157, 58),
              tooltip: convertToGB(values[2]) + "/" + convertToGB(values[1]),
              text: "Swap",
            ));

            widgets.add(SizedBox(
              width: 20,
            ));
          }

          // Remove last widget if the swap is not available
          widgets.removeLast();

          widgets.add(const SizedBox(
            width: 20,
          ));

          widgets.add(const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HardwareInfo(),
            ],
          ));

          return Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: widgets,
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  List<String> convertLineToList(String line) {
    List<String> values = line.split(" ");
    values.removeWhere((element) => element == "");
    return values;
  }

  String convertToGB(string) {
    double value = double.parse(string);
    value /= 100;
    int v1 = value.ceil();
    double v2 = v1 / 10;
    return v2.toString() + "G";
  }
}
