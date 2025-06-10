import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  final VoidCallback operation;
  final String label;
  final Color bgColor;
  final Color textColor;
  double buttonWidth;
  double buttonHeight;
  final double textSize;
  String symbol;

  Button(
    this.label,
    this.symbol,
    this.bgColor,
    this.textColor,
    this.textSize,
    this.buttonWidth,
    this.buttonHeight,
    this.operation, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    //double sizeHeight = MediaQuery.of(context).size.height;
    buttonWidth = sizeWidth * buttonWidth;

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,

      child: ElevatedButton(
        onPressed: operation,

        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          elevation: 1.0,
        ),
        child:
            symbol.compareTo('null') == 0 
                ? Text(label, style: TextStyle(fontSize: textSize, color: textColor))
                // ignore: deprecated_member_use
                : SvgPicture.asset(symbol, height: textSize + 5, color: textColor),
      ),
    );
  }
}
