import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
// import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pythonga_expense_estimator/constants/text_constants.dart';
import '../components/rounded_icon_button.dart';
import '../constants/style_constants.dart';
import '../services/directory_services.dart';
import '../pages/input_page.dart';

class FileListing extends StatefulWidget {
  const FileListing();

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

  String datesUsedForFilenameAlias(arrivalDate, departureDate) {
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    String formattedArrivalDate = formatter.format(arrivalDate);
    String formattedDepartureDate = formatter.format(departureDate);
    String returnName = '$formattedArrivalDate to $formattedDepartureDate';
    return returnName;
  }

  String filenameAlias(file) {
    String fileContent = file.readAsStringSync();
    // Map decodedData = {"estimate_name": "fake_trip"};
    var decodedData = jsonDecode(fileContent);
    String alias = 'Untitled Estimate';
    if (decodedData.containsKey('estimate_name')) {
      if (decodedData['estimate_name'].isNotEmpty) {
        alias = decodedData['estimate_name'];
      } else if (decodedData['arrival_date'] != null) {
        if (decodedData['arrival_date'].isNotEmpty &&
            decodedData['departure_date'].isNotEmpty) {
          DateTime arrivalDate =
              transformJsonDateTime(decodedData['arrival_date']);
          DateTime departureDate =
              transformJsonDateTime(decodedData['departure_date']);
          alias = datesUsedForFilenameAlias(arrivalDate, departureDate);
        }
      }
    } else {
      alias = 'Untitled';
    }
    return alias;
  }

  /*
  Widget cancelButton = TextButton(
    child: Text(kDoNotDeleteDescr),
    onPressed: () {},
  );
  Widget deleteButton = TextButton(
    child: Text(kDeleteDescr),
    onPressed: () {},
  );

  */

  Future<void> _showConfirmDeleteDialog(file, fileMap) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(kConfirmationDescr),
            actions: [
              TextButton(
                child: const Text(kDeleteDescr),
                onPressed: () {
                  setState(() {
                    file.deleteSync();
                    fileMap.remove(file);
                    Navigator.of(context).pop();
                  });
                },
              ),
              TextButton(
                child: const Text(kDoNotDeleteDescr),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
            content: SingleChildScrollView(
              child: Column(
                children: const [
                  Text(kConfirmationDescr2),
                ],
              ),
            ),
          );
        });
  }

  Future<List<Widget>> fileListMappedAsWidget() async {
    var fileHits =
        await getSavedEstimates(); //returns Future<Map<dynamic,dynamic>>
    List<Widget> newList = [];
    fileHits.forEach((k, v) {
      String fileNameUserFacing = filenameAlias(k);
      newList.add(Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text(pathpkg.basename(v)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(fileNameUserFacing, style: kEstimateListingTextStyle),
              ],
            ),
            //SizedBox(width: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                          // setState(() {
                          _showConfirmDeleteDialog(k, fileMap);
                          //k.deleteSync();
                          // fileMap.remove(k);
                          // });
                        })
              ],
            ),
          ],
        ),
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
