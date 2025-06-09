import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Button extends StatelessWidget {
  final VoidCallback operation;
  final String label;
  final Color bgColor;
  final Color textColor;
  String symbol;

  Button(
    this.label,
    this.symbol,
    this.bgColor,
    this.textColor,
    this.operation, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    double sizeHeight = MediaQuery.of(context).size.height;
    sizeWidth =
        (label.compareTo("AC") == 0) ? sizeWidth * 0.68 : sizeWidth * 0.2;

    return SizedBox(
      height: 60,
      width: sizeWidth,

      child: ElevatedButton(
        onPressed: operation,

        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          elevation: 1.0,
        ),
        child:
            symbol.compareTo('null') == 0
                ? Text(label, style: TextStyle(fontSize: 25, color: textColor))
                : SvgPicture.asset(symbol, height: 35, color: textColor),
      ),
    );
  }
}
