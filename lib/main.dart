import 'package:flutter/material.dart';
import 'package:calculator/calc.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';


void main() {
  debugPaintSizeEnabled = true;
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() {
    return _App();
  }
}

class _App extends State<App> {
  bool isDarkMode = false;
  Color bgColor = Colors.white;
  Color buttonColor = Color.fromARGB(189, 255, 255, 255);
  Color textColor = Colors.black;
  String theme = 'assets/icons/lightmode.svg';

  void changeIntoDark() {
    setState(() {
      isDarkMode = !isDarkMode;
      theme =
          isDarkMode
              ? 'assets/icons/darkmode.svg'
              : 'assets/icons/lightmode.svg';
      bgColor = isDarkMode ? Colors.black : Colors.white;
      textColor = isDarkMode ? Colors.white : Colors.black;
      buttonColor =
          isDarkMode
              ? Color.fromARGB(225, 33, 33, 33)
              : Color.fromARGB(189, 255, 255, 255);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 5, 15),
            child: SvgPicture.asset(
              'assets/icons/calculate.svg',
              color: textColor,
              height: 40,
              width: 40,
            ),
          ),
          title: Text(
            'Calculator',
            style: TextStyle(color: textColor, fontSize: 25),
            textAlign: TextAlign.start,
          ),
          titleSpacing: 0,
          elevation: 0,
          actions: [
            ElevatedButton(
              onPressed: changeIntoDark,
              style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
              child: SvgPicture.asset(
                theme,
                height: 25,
                colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
              ),
            ),
          ],
          actionsPadding: EdgeInsets.all(10),
        ),
        body: Calc(isDarkMode),
        backgroundColor: bgColor,
      ),
    );
  }
}
