import 'package:flutter/material.dart';
import 'package:calculator/calc.dart';
import 'package:flutter_svg/svg.dart';

void main() {
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
      buttonColor = isDarkMode ? Color.fromARGB(225, 33, 33, 33) : Color.fromARGB(189, 255, 255, 255);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculator', style: TextStyle(color: textColor)),
          backgroundColor: bgColor,
          actions: [
            ElevatedButton(
              onPressed: changeIntoDark,
              style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
              child: SvgPicture.asset(
                theme,
                height: 35,
                colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
              ),
            ),
          ],
          elevation: 0,
        ),
        body: Calc(isDarkMode),
        backgroundColor: bgColor,
      ),
    );
  }
}
