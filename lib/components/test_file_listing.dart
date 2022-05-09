import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart' as pathpkg;
import '../components/bottom_button.dart';
import '../services/directory_services.dart';

class TestFileListing extends StatefulWidget {
  const TestFileListing();

  @override
  State<TestFileListing> createState() => _TestFileListingState();
}

class _TestFileListingState extends State<TestFileListing> {
  Map fileMap = {};

  Future<Map> getSavedEstimates() async {
    try {
      var savedEstimates = await DirectoryHelper.listOfFiles().then((resp) {
        print("resp is");
        print(resp);
        return resp;
      });
      // var savedEstimates = await DirectoryHelper.listOfFiles();
      print('saved Estimates');
      print(savedEstimates);
      savedEstimates.forEach((key, value) => print(key));
      return savedEstimates;
    } catch (e) {
      throw Exception("Could Not Retrieve list of saved files");
    }
  }

  // final Future<List<Widget>> cyFileList = fileListMappedAsWidget();

  Future<List<Widget>> fileListMappedAsWidget() async {
    var fileHits =
        await getSavedEstimates(); //returns Future<Map<dynamic,dynamic>>
    List<Widget> newList = [];
    fileHits.forEach((k, v) {
      newList.add(Row(
        children: [
          Text(pathpkg.basename(v)),
          BottomButton(
              buttonTitle: 'Delete',
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

  final Future<Map> testRetrieve = Future<Map>.delayed(
    const Duration(seconds: 2),
    () => {'key1': 'value 1', 'key2': 'value2'},
  );

  /*final Future<List> testRetrieve = Future<List>.delayed(
    const Duration(seconds: 2),
    () => ['file1.txt', 'file2.txt'],
  );*/

  /*final Future<String> testRetrieve = Future<String>.delayed(
    const Duration(seconds: 2),
    // List testList = ['file 1.txt', 'file 2.txt'];
    // () => ['file1.txt', 'file2.txt'],
    () => 'Data Loaded',
  );
*/
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: fileListMappedAsWidget(),
          // future: testRetrieve,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            List<Widget> children;
            print(snapshot.connectionState);
            if (snapshot.hasData) {
              print('snapshot has data');
              print(snapshot.data);
              print(snapshot.data.runtimeType);
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
