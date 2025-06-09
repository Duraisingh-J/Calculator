import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/buttons.dart';

class Calc extends StatefulWidget {
  final bool isDarkMode;
  const Calc(this.isDarkMode, {super.key});

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
  RegExp decimalPointPattern = RegExp(r'\.{2, }|\.$');
  RegExp numberLimit = RegExp(r'\d+');
  Color bgColor = Colors.white;
  Color buttonColor = Color.fromARGB(189, 255, 255, 255);
  Color textColor = Colors.black;

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

      Parser p = Parser();
      Expression exp = p.parse(input);
      ContextModel cm = ContextModel();
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

  @override
  Widget build(context) {
    final bool isDarkMode = widget.isDarkMode;

    bgColor = isDarkMode ? Colors.black : Colors.white;
    buttonColor =
        isDarkMode
            ? Color.fromARGB(187, 33, 33, 33)
            : Color.fromARGB(189, 255, 255, 255);
    textColor = isDarkMode ? Colors.white : Colors.black;
    double sizeWidth = MediaQuery.of(context).size.width;
    double sizeHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: sizeHeight * 0.18,
          width: sizeWidth * 0.95,

          child: Container(
            color: bgColor,
            alignment: Alignment.bottomRight,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,
              child: Text(
                input,
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: textColor),
              ),
            ),
          ),
        ),
        SizedBox(
          height: sizeHeight * 0.09,
          width: sizeWidth * 0.95,

          child: Container(
            color: bgColor,
            alignment: Alignment.bottomRight,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                result,
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: textColor),
              ),
            ),
          ),
        ),

        SizedBox(height: 40),
        Button('AC', Color.fromARGB(255, 231, 26, 11), textColor,  () {
          allClear();
        }),

        SizedBox(height: 15),
        Column(
          children: [
            Row(
              children: [
                SizedBox(width: 15, height: 15),
                Button('/', Colors.greenAccent, textColor, () {
                  characters("/");
                }),
                SizedBox(width: 15, height: 15),
                Button('*', Colors.greenAccent, textColor, () {
                  characters("*");
                }),
                SizedBox(width: 15, height: 15),
                Button('+', Colors.greenAccent, textColor, () {
                  characters("+");
                }),
                SizedBox(width: 15, height: 15),
                Button('-', Colors.greenAccent, textColor, () {
                  characters("-");
                }),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 15, height: 15),
                Button('7', buttonColor, textColor, () {
                  characters("7");
                }),

                SizedBox(width: 15, height: 15),
                Button('8', buttonColor, textColor, () {
                  characters("8");
                }),

                SizedBox(width: 15, height: 15),
                Button('9', buttonColor, textColor, () {
                  characters("9");
                }),

                SizedBox(width: 15, height: 15),
                Button('(', Colors.greenAccent, textColor, () {
                  characters("(");
                }),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 15, height: 15),
                Button('4', buttonColor, textColor, () {
                  characters("4");
                }),

                SizedBox(width: 15, height: 15),
                Button('5', buttonColor, textColor, () {
                  characters("5");
                }),

                SizedBox(width: 15, height: 15),
                Button('6', buttonColor, textColor, () {
                  characters("6");
                }),

                SizedBox(width: 15, height: 15),
                Button(')', Colors.greenAccent, textColor, () {
                  characters(")");
                }),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 15, height: 15),
                Button('1', buttonColor, textColor, () {
                  characters("1");
                }),

                SizedBox(width: 15, height: 15),
                Button('2', buttonColor, textColor, () {
                  characters("2");
                }),

                SizedBox(width: 15, height: 15),
                Button('3', buttonColor, textColor, () {
                  characters("3");
                }),

                SizedBox(width: 15, height: 15),
                Button('^', Colors.greenAccent, textColor, () {
                  characters("^");
                }),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 15, height: 15),
                Button('.', buttonColor, textColor, () {
                  characters(".");
                }),

                SizedBox(width: 15, height: 15),
                Button('0', buttonColor, textColor, () {
                  characters("0");
                }),

                SizedBox(width: 15, height: 15),
                Button('=', Color.fromARGB(255, 255, 208, 0), textColor, () {
                  calculation();
                }),

                SizedBox(width: 15, height: 15),
                Button('X', Colors.redAccent, textColor, () {
                  delete();
                }),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
