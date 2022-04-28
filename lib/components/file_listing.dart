import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:convert';
// import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as pathpkg;
import '../components/bottom_button.dart';
import '../components/round_icon_button.dart';
import '../components/rounded_icon_button.dart';
import '../constants/style_constants.dart';
import '../services/directory_services.dart';
import '../pages/input_page.dart';

class FileListing extends StatefulWidget {
  FileListing();

  @override
  State<FileListing> createState() => _FileListingState();
}

class _FileListingState extends State<FileListing> {
  Map fileMap = {};

  Future<Map> getSavedEstimates() async {
    try {
      var savedEstimates = await DirectoryHelper.listOfFiles().then((resp) {
        // print("resp is");
        // print(resp);
        return resp;
      });
      //print('saved Estimates');
      //print(savedEstimates);
      savedEstimates.forEach((key, value) => print(key));
      return savedEstimates;
    } catch (e) {
      throw Exception("Could Not Retrieve list of saved files");
    }
  }

  // the following is a copy of what's in InputPage class;
  // both need to be factored out to a separate class;

  static DateTime transformJsonDateTime(jsonDateTime) {
    if (jsonDateTime == null) {
      return DateTime.now();
    } else {
      return DateTime.parse(jsonDateTime);
    }
  }

  String filenameAlias(file) {
    //sync read will not work
    // try async read
    String fileContent = file.readAsStringSync();
    // sleep(const Duration(seconds: 5));
    Map decodedData = {"estimate_name": "fake_trip"};
    // var decodedData = jsonDecode(fileContent);
    String estimateName = 'bb';
    if (decodedData.containsKey('estimate_name')) {
      if (decodedData['estimate_name'].isEmpty) {
        estimateName = 'cc';
      } else {
        estimateName = decodedData['estimate_name'];
      }
    } else {
      estimateName = 'dd';
    }
    return estimateName;
  }

  /*
  String filenameAlias(file) {
    String fileContent = file.readAsStringSync();
    var decodedData = jsonDecode(fileContent);
    if (decodedData['arrival_date'] == null) {
      return 'No Date';
    }
    DateTime arrivalDate = transformJsonDateTime(decodedData['arrival_date']);
    DateTime departureDate =
        transformJsonDateTime(decodedData['departure_date']);
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    String formattedArrivalDate = formatter.format(arrivalDate);
    String formattedDepartureDate = formatter.format(departureDate);
    String returnName = '$formattedArrivalDate to $formattedDepartureDate';
    return returnName;
  }

   */

  Future<List<Widget>> fileListMappedAsWidget() async {
    var fileHits =
        await getSavedEstimates(); //returns Future<Map<dynamic,dynamic>>
    List<Widget> newList = [];
    fileHits.forEach((k, v) {
      String fileNameUserFacing = filenameAlias(k);
      newList.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(pathpkg.basename(v)),
          // Text(fileNameUserFacing, style: kEstimateListingTextStyle),
          SizedBox(width: 50),
          RoundedIconButton(
              icon: Icons.edit,
              onPressed: () => () {
                    String fileContent = k.readAsStringSync();
                    var decodedData = jsonDecode(fileContent);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return InputPage.fromJson(decodedData);
                      }),
                    );
                  }),
          RoundedIconButton(
              icon: Icons.delete,
              onPressed: () => () {
                    setState(() {
                      k.deleteSync();
                      fileMap.remove(k);
                    });
                  })
        ],
      ));
    });
    // () => newList;
    return newList;
    // throw ("f");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: fileListMappedAsWidget(),
          // future: testRetrieve,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            List<Widget> children;
            // print(snapshot.connectionState);
            if (snapshot.hasData) {
              //print('snapshot has data');
              //print(snapshot.data);
              //print(snapshot.data.runtimeType);
              List<Widget> childStuff = [];
              for (int i = 0; i < snapshot.data!.length; i++) {
                childStuff.add(snapshot.data![i]);
              }

              children = childStuff;

              //children = <Widget>[
              //snapshot.data?.forEach((e) {
              //  Text("Result: $e");
              // })

              // Text('Result: ${snapshot.data}'),

            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(Icons.error_outline, color: Colors.red, size: 60),
                Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'))
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                    width: 60, height: 60, child: CircularProgressIndicator()),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting Result'),
                )
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
          }),
    );
  }
}
