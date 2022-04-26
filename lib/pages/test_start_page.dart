import 'package:flutter/material.dart';
import '../components/test_file_listing.dart';
import '../constants/text_constants.dart';

class TestStartPage extends StatefulWidget {
  const TestStartPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TestStartPage> createState() => _TestStartPageState();
}

class _TestStartPageState extends State<TestStartPage> {
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
        child: Column(children: [
          Text(kYourEstimatesDescr),
          TestFileListing(),
        ]),
      ),
    );
  }
}
