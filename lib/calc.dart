import 'package:calculator/calc_landscape.dart';
import 'package:calculator/calc_portrait.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

class Calc extends StatefulWidget {
  final bool isDarkMode;
  final bool isPortrait;

  const Calc(this.isDarkMode, this.isPortrait, {super.key});

  @override
  State<Calc> createState() {
    return _Calc();
  }
}

class _Calc extends State<Calc> {
  String input = '';
  String result = '';
  RegExp mixedPattern = RegExp(r'[\+\-\*\^/]{2,}');
  RegExp startEndPattern = RegExp(r'^[\+\-\*\^/]|[\+\-\*\^/]$');
  RegExp decimalPointPattern = RegExp(r'\.{2,}|\.$');
  RegExp numberLimit = RegExp(r'\d+');
  RegExp trignometricPattern = RegExp(r'(sin|cos|tan)\(([^()]+)\)');
  RegExp logarithmicPattern = RegExp(r'(log)\(([^()]+)\)');
  Color bgColor = Colors.white;
  Color buttonColor = Color.fromARGB(189, 255, 255, 255);
  Color textColor = Colors.black;
  double textSize = 0;
  double screenHeight = 0;
  double screenWidth = 0;
  double resultScreenHeight = 0;

  void characters(String char) {
    setState(() {
      input = input + char;
    });
  }

  void delete() {
    setState(() {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    });
  }

  void allClear() {
    setState(() {
      input = '';
      result = '';
    });
  }

  void calculation() async {
    try {
      if (mixedPattern.hasMatch(input)) {
        throw FormatException(
          "Invalid Expression: Mixed or Repeated Operators the next",
        );
      } else if (startEndPattern.hasMatch(input)) {
        throw FormatException(
          "Invalid Expression: Operators at start or end of expression",
        );
      } else if (decimalPointPattern.hasMatch(input)) {
        throw FormatException(
          "Invalid Expression: Consecutive decimal points or trailing decimal points",
        );
      }

      // ignore: deprecated_member_use
      Parser p = Parser();
      Expression exp = p.parse(
        input
            .replaceAll('x', '*')
            .replaceAllMapped(trignometricPattern, (match) {
              final func = match.group(1)!;
              final angleInDegrees = match.group(2);
              return "$func(($angleInDegrees) * (pi/180))";
            })
            .replaceAllMapped(logarithmicPattern, (match) {
              final value = match.group(2);
              return "ln($value) / ln(10)";
            }),
      );

      ContextModel cm = ContextModel();
      cm.bindVariable(Variable('pi'), Number(math.pi));
      cm.bindVariableName('e', Number(math.e));

      double value = exp.evaluate(EvaluationType.REAL, cm);
      Iterable<RegExpMatch> numbers = numberLimit.allMatches(input);

      for (var number in numbers) {
        if (number.group(0)!.length > 15) {
          throw FormatException('The input number exceeds the max digit');
        }
      }
      if (value == value.roundToDouble()) {
        setState(() {
          result = value.toInt().toString();
        });
      } else {
        setState(() {
          result = value.toString();
        });
      }
    } catch (err) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }

  void changePortraitToLandscape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void changeLandscapeToPortrait() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  // void resetOrientation() async {
  //   await SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.landscapeRight,
  //   ]);

  // }

  @override
  Widget build(context) {
    final bool isDarkMode = widget.isDarkMode;
    final bool isPortrait = widget.isPortrait;

    double sizeWidth = MediaQuery.of(context).size.width;
    double sizeHeight = MediaQuery.of(context).size.height;

    bgColor = isDarkMode ? Colors.black : Colors.white;
    buttonColor =
        isDarkMode
            ? Color.fromARGB(187, 33, 33, 33)
            : Color.fromARGB(189, 255, 255, 255);
    textColor = isDarkMode ? Colors.white : Colors.black;
    textSize = isPortrait ? 50 : 30;
    screenHeight = isPortrait ? sizeHeight * 0.215 : sizeHeight * 0.1;
    screenWidth = isPortrait ? sizeWidth * 0.95 : sizeWidth * 0.85;
    resultScreenHeight = isPortrait ? sizeHeight * 0.09 : sizeHeight * 0.085;

    return Column(
      children: [
        isPortrait ? SizedBox(height: 0) : SizedBox(height: 15),
        SizedBox(
          height: screenHeight,
          width: screenWidth,

          child: Container(
            color: bgColor,
            alignment: Alignment.bottomRight,
            child: SingleChildScrollView(
              scrollDirection: isPortrait ? Axis.vertical : Axis.horizontal,
              reverse: true,
              child: Text(
                input
                    .replaceAll('pi', 'π')
                    .replaceAll('*', 'x')
                    .replaceAll('/', '÷')
                    .replaceAll('sqrt', '√'),
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: resultScreenHeight,
          width: screenWidth,

          child: Container(
            color: bgColor,
            alignment: Alignment.bottomRight,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                result,
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: isPortrait ? 25 : 15),
        isPortrait
            ? CalcPortrait(
              input,
              bgColor,
              buttonColor,
              textColor,
              characters,
              delete,
              allClear,
              calculation,
              changePortraitToLandscape,
            )
            : CalcLandscape(
              input,
              bgColor,
              buttonColor,
              textColor,
              characters,
              delete,
              allClear,
              calculation,
              changeLandscapeToPortrait,
            ),
      ],
    );
  }
}
