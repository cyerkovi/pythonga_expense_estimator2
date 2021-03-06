//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/round_icon_button.dart';

//import 'package:pythonga_expense_estimator/components/bottom_button.dart';
import '../components/file_listing.dart';

//import 'package:pythonga_expense_estimator/components/test_file_listing.dart';
import '../pages/input_page.dart';
import '../constants/text_constants.dart';
import '../constants/style_constants.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  Map fileList = {};

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppTitle2),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  kYourEstimatesDescr,
                  style: kHeaderTextStyle,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundIconButton(
                  icon: FontAwesomeIcons.plus,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return InputPage(
                          title: 'New Estimate',
                          isNewEstimate: true,
                          fileName: 'xx');
                    }));
                  }),
            ],
          ),
          const FileListing(),
        ]),
      ),
    );
  }
}
