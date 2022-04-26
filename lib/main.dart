import 'package:flutter/material.dart';
import 'constants/text_constants.dart';
import 'pages/start_page.dart';
import 'pages/test_start_page.dart';

void main() => runApp(PythongaVisitCostCalculator());

class PythongaVisitCostCalculator extends StatelessWidget {
  const PythongaVisitCostCalculator({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: kAppTitle1,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.lightBlue,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
          ),
        ),
        home: StartPage(title: kYourTripsDescr));
  }
}
