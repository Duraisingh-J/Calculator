import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Button extends StatelessWidget {
  final VoidCallback operation;
  final String label;
  final Color bgColor;
  final Color textColor;

  const Button(
    this.label,
    this.bgColor,
    this.textColor,
    this.operation, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    // double sizeHeight = MediaQuery.of(context).size.height;
    sizeWidth =
        (label.compareTo("AC") == 0) ? sizeWidth * 0.8 : sizeWidth * 0.2;

    return (label.compareTo("X") == 0)
        ? SizedBox(
          height: 60,
          width: sizeWidth,

          child: ElevatedButton(
            onPressed: operation,

            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              elevation: 1.0,
            ),
            child: SvgPicture.asset(
              'assets/icons/backspace.svg',
              height: 35,
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
            ),
          ),
        )
        : SizedBox(
          height: 60,
          width: sizeWidth,

          child: ElevatedButton(
            onPressed: operation,

            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              elevation: 1.0,
            ),
            child: Text(
              label,
              style: TextStyle(fontSize: 25, color: textColor),
            ),
          ),
        );
  }
}
