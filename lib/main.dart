import 'package:flutter/material.dart';
import 'package:calculator/calc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

void main() async {
  //debugPaintSizeEnabled = true;

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.system,
      home: const CalculateApp(),
    );
  }
}

class CalculateApp extends StatelessWidget {
  const CalculateApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color bgColor = isDarkMode ? Colors.black : Colors.white;
    Color textColor = isDarkMode ? Colors.white : Colors.black;

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return isPortrait
        ? Scaffold(
          appBar: AppBar(
            backgroundColor: bgColor,
            leading: Padding(
              padding:
                  isPortrait
                      ? EdgeInsets.fromLTRB(15, 15, 5, 15)
                      : EdgeInsets.fromLTRB(5, 5, 2, 5),
              child: SvgPicture.asset(
                'assets/icons/calculate.svg',
                // ignore: deprecated_member_use
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
          ),
          body: Calc(isDarkMode, isPortrait),
          backgroundColor: bgColor,
        )
        : Scaffold(body: Calc(isDarkMode, isPortrait));
  }
}
