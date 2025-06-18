import 'package:flutter/material.dart';
import 'package:calculator/buttons.dart';

// ignore: must_be_immutable
class CalcPortrait extends StatefulWidget {
  String input;
  Color bgColor = Colors.white;
  Color buttonColor = Color.fromARGB(189, 255, 255, 255);
  Color textColor = Colors.black;
  void Function(String) characters;
  void Function() delete;
  void Function() allClear;
  void Function() calculation;
  void Function() changePortraitToLandscape;

  CalcPortrait(
    this.input,
    this.bgColor,
    this.buttonColor,
    this.textColor,
    this.characters,
    this.delete,
    this.allClear,
    this.calculation,
    this.changePortraitToLandscape, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _CalcPortrait();
  }
}

class _CalcPortrait extends State<CalcPortrait> {
  // @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     await SystemChrome.setPreferredOrientations([

  //       DeviceOrientation.landscapeLeft,
  //       DeviceOrientation.landscapeRight,
  //       DeviceOrientation.portraitUp,
  //     ]);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bgColor,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 15),
              Button(
                'extendOperation',
                'assets/icons/expand.svg',
                Colors.blue,
                widget.textColor,
                25,
                0.2,
                60,
                widget.changePortraitToLandscape,
              ),
              SizedBox(width: 15),
              Button(
                'AC',
                'null',
                Color.fromARGB(255, 231, 26, 11),
                widget.textColor,
                25,
                0.68,
                60,
                () {
                  widget.allClear();
                },
              ),
            ],
          ),

          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15, height: 15),
              Button(
                '/',
                'assets/icons/division.svg',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                25,
                0.2,
                60,
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
                25,
                0.2,
                60,
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
                25,
                0.2,
                60,
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
                25,
                0.2,
                60,
                () {
                  widget.characters("-");
                },
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15, height: 15),
              Button(
                '7',
                'null',
                widget.buttonColor,
                widget.textColor,
                25,
                0.2,
                60,
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
                25,
                0.2,
                60,
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
                25,
                0.2,
                60,
                () {
                  widget.characters("9");
                },
              ),

              SizedBox(width: 15, height: 15),
              Builder(
                builder: (context) {
                  return  Button(
                    '(',
                    'null',
                    const Color.fromARGB(212, 0, 255, 81),
                    widget.textColor,
                    25,
                    0.2,
                    60,
                    () async {
                      final RenderBox button =
                          context.findRenderObject() as RenderBox;
                      final overlay =
                          Overlay.of(context).context.findRenderObject()
                              as RenderBox;
                      final position = RelativeRect.fromRect(
                        Rect.fromPoints(
                          button.localToGlobal(Offset.zero, ancestor: overlay),
                          button.localToGlobal(
                            button.size.bottomRight(Offset.zero),
                            ancestor: overlay,
                          ),
                        ),
                        Offset.zero & overlay.size,
                      );
                      final selected = await showMenu(
                        context: context,
                        position: position,
                        items: [
                          PopupMenuItem(value: '(', child: Text('(')),
                          PopupMenuItem(value: '{', child: Text('{')),
                          PopupMenuItem(value: '[', child: Text('[')),
                        ],
                      );

                      if (!mounted || selected == null) return;

                      widget.characters(selected);
                    },
                  );
                }
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15, height: 15),
              Button(
                '4',
                'null',
                widget.buttonColor,
                widget.textColor,
                25,
                0.2,
                60,
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
                25,
                0.2,
                60,
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
                25,
                0.2,
                60,
                () {
                  widget.characters("6");
                },
              ),

              SizedBox(width: 15, height: 15),
              Builder(
                builder: (context) {
                  return Button(
                    ')',
                    'null',
                    const Color.fromARGB(212, 0, 255, 81),
                    widget.textColor,
                    25,
                    0.2,
                    60,
                    () async {
                      final RenderBox button =
                          context.findRenderObject() as RenderBox;
                      final overlay =
                          Overlay.of(context).context.findRenderObject()
                              as RenderBox;
                      final position = RelativeRect.fromRect(
                        Rect.fromPoints(
                          button.localToGlobal(Offset.zero, ancestor: overlay),
                          button.localToGlobal(
                            button.size.bottomRight(Offset.zero),
                            ancestor: overlay,
                          ),
                        ),
                        Offset.zero & overlay.size,
                      );
                      final selected = await showMenu(
                        context: context,
                        position: position,
                        items: [
                          PopupMenuItem(value: ')', child: Text(')')),
                          PopupMenuItem(value: '}', child: Text('}')),
                          PopupMenuItem(value: ']', child: Text(']')),
                        ],
                      );

                      if (!mounted || selected == null) return;

                      widget.characters(selected);
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15, height: 15),
              Button(
                '1',
                'null',
                widget.buttonColor,
                widget.textColor,
                25,
                0.2,
                60,
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
                25,
                0.2,
                60,
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
                25,
                0.2,
                60,
                () {
                  widget.characters("3");
                },
              ),

              SizedBox(width: 15, height: 15),
              Button(
                '^',
                'null',
                const Color.fromARGB(212, 0, 255, 81),
                widget.textColor,
                25,
                0.2,
                60,
                () {
                  widget.characters("^");
                },
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15, height: 15),
              Button(
                '.',
                'null',
                widget.buttonColor,
                widget.textColor,
                25,
                0.2,
                60,
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
                25,
                0.2,
                60,
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
                25,
                0.2,
                60,
                () {
                  widget.calculation();
                },
              ),

              SizedBox(width: 15, height: 15),
              Button(
                'X',
                'assets/icons/backspace.svg',
                Colors.redAccent,
                widget.textColor,
                25,
                0.2,
                60,
                () {
                  widget.delete();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
