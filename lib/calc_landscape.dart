import 'package:calculator/infobutton.dart';
import 'package:flutter/material.dart';
import 'package:calculator/buttons.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CalcLandscape extends StatefulWidget {
  String input = '';
  Color bgColor = Colors.white;
  Color buttonColor = Color.fromARGB(239, 255, 255, 255);
  Color textColor = Colors.black;
  void Function(String) characters;
  void Function() delete;
  void Function() allClear;
  void Function() calculation;
  void Function() changLandscapeToPortrait;
  List<String> leftBrackets = ["{", "(", "["];
  List<String> rightBrackets = ["}", ")", "]"];
  String? selectedItem;

  CalcLandscape(
    this.input,
    this.bgColor,
    this.buttonColor,
    this.textColor,
    this.characters,
    this.delete,
    this.allClear,
    this.calculation,
    this.changLandscapeToPortrait, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _CalcLandscape();
  }
}

class _CalcLandscape extends State<CalcLandscape> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bgColor,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 60),
              Button(
                'extendOperation',
                'assets/icons/expand.svg',
                Colors.blue,
                widget.textColor,
                27,
                0.09,
                45,
                widget.changLandscapeToPortrait,
              ),
              SizedBox(width: 25),
              Button(
                'AC',
                'null',
                Color.fromARGB(255, 231, 26, 11),
                widget.textColor,
                27,
                0.165,
                45,
                () {
                  widget.allClear();
                },
              ),
              SizedBox(width: 25),
              Text(
                'To view how to use the extended operations, hold them for a second.',
                style: GoogleFonts.eduSaBeginner(fontSize: 18),
              ),
            ],
          ),

          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 60),
              Button(
                '^',
                'null',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("^");
                },
              ),
              SizedBox(width: 15, height: 15),
              Button(
                '/',
                'assets/icons/division.svg',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("/");
                },
              ),
              SizedBox(width: 15, height: 15),
              Button(
                '*',
                'assets/icons/multiplication.svg',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("*");
                },
              ),
              SizedBox(width: 15, height: 15),
              Button(
                '+',
                'assets/icons/plus.svg',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("+");
                },
              ),
              SizedBox(width: 15, height: 15),
              Button(
                '-',
                'assets/icons/minus.svg',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("-");
                },
              ),

              SizedBox(width: 25),
              Button(
                '7',
                'null',
                widget.buttonColor,
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("7");
                },
              ),

              SizedBox(width: 15, height: 15),
              Button(
                '8',
                'null',
                widget.buttonColor,
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("8");
                },
              ),

              SizedBox(width: 15, height: 15),
              Button(
                '9',
                'null',
                widget.buttonColor,
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("9");
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 60),

              Button(
                '(',
                'null',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("(");
                },
              ),
              // DropdownButton(
              //   value: widget.selectedItem,
              //   isExpanded: true,
              //   items:
              //       widget.leftBrackets.map((bracket) {
              //         return DropdownMenuItem<String>(
              //           value: bracket,
              //           child: Text(bracket),
              //         );
              //       }).toList(),
              //   onChanged: (String? value) {
              //     setState(() {
              //       widget.selectedItem = value;
              //     });
              //   },
              // ),
              SizedBox(width: 15, height: 15),
              Button(
                ')',
                'null',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters(")");
                },
              ),
              SizedBox(width: 15, height: 15),
              InfoButton(
                'Square Root',
                'assets/icons/sqrt.svg',
                'Use as √(value) not as √value.',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                30,
                0.09,
                45,
                () {
                  widget.characters("sqrt");
                },
              ),
              SizedBox(width: 15, height: 15),
              InfoButton(
                'Nth Square Root',
                'assets/icons/nthsquareroot.svg',
                'Used to find the nth square root of given value.\nFirst input the value and then press this operation.',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                20,
                0.09,
                45,
                () {
                  widget.characters("^(-1)");
                },
              ),
              SizedBox(width: 15, height: 15),
              InfoButton(
                'Factorial',
                'assets/icons/factorial.svg',
                'It is been used as value!',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("!");
                },
              ),
              SizedBox(width: 25),
              Button(
                '4',
                'null',
                widget.buttonColor,
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("4");
                },
              ),

              SizedBox(width: 15, height: 15),
              Button(
                '5',
                'null',
                widget.buttonColor,
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("5");
                },
              ),

              SizedBox(width: 15, height: 15),
              Button(
                '6',
                'null',
                widget.buttonColor,
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("6");
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 60),
              InfoButton(
                'sin',
                'null',
                'Trigonometric function.\nUse as sin(degrees).\nDon\'t as sindegrees.',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                18,
                0.09,
                45,
                () {
                  widget.characters("sin");
                },
              ),
              SizedBox(width: 15, height: 15),
              InfoButton(
                'cos',
                'null',
                'Trigonometric function.\nUse as cos(degrees).\nDon\'t as cosdegrees.',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                18,
                0.09,
                45,
                () {
                  widget.characters("cos");
                },
              ),
              SizedBox(width: 15, height: 15),
              InfoButton(
                'tan',
                'null',
                'Trigonometric function.\nUse as tan(degrees).\nDon\'t as tandegrees.',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                18,
                0.09,
                45,
                () {
                  widget.characters("tan");
                },
              ),
              SizedBox(width: 15, height: 15),
              Button(
                'log',
                'null',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                18,
                0.09,
                45,
                () {
                  widget.characters("log");
                },
              ),
              SizedBox(width: 15, height: 15),
              InfoButton(
                'ln',
                'null',
                'Natual logoritmic Function.\nIt\'s base is e.\nIf you want to change the base like lnₓ(y), use ln(y) / ln(x).',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                18,
                0.09,
                45,
                () {
                  widget.characters("ln");
                },
              ),

              SizedBox(width: 25),
              Button(
                '1',
                'null',
                widget.buttonColor,
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("1");
                },
              ),

              SizedBox(width: 15, height: 15),
              Button(
                '2',
                'null',
                widget.buttonColor,
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("2");
                },
              ),

              SizedBox(width: 15, height: 15),
              Button(
                '3',
                'null',
                widget.buttonColor,
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("3");
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 60),
              InfoButton(
                'e',
                'null',
                'e -> Euclid Number.\nUse it as e(no) or eno or e^no.\nDon\'t use it alone.',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("e");
                },
              ),
              SizedBox(width: 15, height: 15),
              InfoButton(
                'pi',
                'assets/icons/pi2.svg',
                'Math constant.\nValue = 3.141592653589793',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                23,
                0.09,
                45,
                () {
                  widget.characters("pi");
                },
              ),
              SizedBox(width: 15, height: 15),
              InfoButton(
                'mod',
                'null',
                'Used to find the remainder for X / Y.',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                15,
                0.09,
                45,
                () {
                  widget.characters("%");
                },
              ),
              SizedBox(width: 15, height: 15),
              InfoButton(
                '1/x',
                'null',
                'Find the inverse of the x\nFirst input value, then press this.',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                20,
                0.09,
                45,
                () {
                  widget.characters("-");
                },
              ),
              SizedBox(width: 15, height: 15),
              Button(
                'X',
                'assets/icons/backspace.svg',
                Colors.redAccent,
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.delete();
                },
              ),
              SizedBox(width: 25),
              Button(
                '.',
                'null',
                widget.buttonColor,
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters(".");
                },
              ),

              SizedBox(width: 15, height: 15),
              Button(
                '0',
                'null',
                widget.buttonColor,
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.characters("0");
                },
              ),

              SizedBox(width: 15, height: 15),
              Button(
                '=',
                'assets/icons/equal.svg',
                Color.fromARGB(255, 255, 208, 0),
                widget.textColor,
                27,
                0.09,
                45,
                () {
                  widget.calculation();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
