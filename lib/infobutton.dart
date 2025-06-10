import 'dart:async' as async;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class InfoButton extends StatefulWidget {
  final VoidCallback operation;
  final String label;
  final Color bgColor;
  final Color textColor;
  final String info;
  double buttonWidth;
  double buttonHeight;
  final double textSize;
  String symbol;

  InfoButton(
    this.label,
    this.symbol,
    this.info,
    this.bgColor,
    this.textColor,
    this.textSize,
    this.buttonWidth,
    this.buttonHeight,
    this.operation, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _InfoButton();
  }
}

class _InfoButton extends State<InfoButton> {
  async.Timer? _longPressTimer;

  void _showPopup(context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(widget.label),
            content: Text(widget.info),

            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  void _startTimer(context) {
    _longPressTimer = async.Timer(Duration(milliseconds: 200), () {
      _showPopup(context);
    });
  }

  void _cancelTimer() {
    if (_longPressTimer != null && _longPressTimer!.isActive) {
      _longPressTimer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    //double sizeHeight = MediaQuery.of(context).size.height;
    widget.buttonWidth = sizeWidth * widget.buttonWidth;

    return SizedBox(
      width: widget.buttonWidth,
      height: widget.buttonHeight,
      child: GestureDetector(
        onTap: widget.operation,
        onLongPressStart: (_) => {_startTimer(context)},
        onLongPressEnd: (_) => {_cancelTimer()},
      
        child: ElevatedButton(
          onPressed: widget.operation,
      
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.bgColor,
            elevation: 1.0,
          ),
          child:
              widget.symbol.compareTo('null') == 0
                  ? Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: widget.textSize,
                      color: widget.textColor,
                    ),
                  )
                  
                  : SvgPicture.asset(
                    widget.symbol,
                    height: widget.textSize + 5,
                    alignment: Alignment.center,
                    // ignore: deprecated_member_use
                    color: widget.textColor,
                  ),
        ),
      ),
    );
  }
}
