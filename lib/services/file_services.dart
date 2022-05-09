import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as pathpkg;
import '../services/directory_services.dart';

class FileHelper {
  FileHelper(this.fileName, this.fileContents);

  String fileName;
  String fileContents;

  static Future<String> getNewFileName() async {
    //print("in fileHelper.getNewFileName");
    var fileHits = await getSavedEstimates();
    //print("number of file hits is");
    //print(fileHits.length);
    //print(fileHits);
    List fileNamesAsInts = [];
    fileHits.forEach((k, v) {
      String fileNameString = pathpkg.basenameWithoutExtension(k.path);
      //print("fileNameString is");
      //print(fileNameString);
      if (isInteger(fileNameString)) {
        //print("file name is an integer");
        fileNamesAsInts.add(int.parse(fileNameString));
      }
    });
    //print("fileNamesAsInts length is");
    //print(fileNamesAsInts.length);
    //print(fileNamesAsInts);
    if (fileNamesAsInts.isEmpty) {
      return 1.toString();
    } else {
      fileNamesAsInts.sort();
      int highestFileNumber = fileNamesAsInts.last;
      String fileNameWithoutExtension = (highestFileNumber + 1).toString();
      return fileNameWithoutExtension;
    }
  }

  static Future<Map> getSavedEstimates() async {
    try {
      var savedEstimates = await DirectoryHelper.listOfFiles().then((resp) {
        // print("resp is");
        // print(resp);
        return resp;
      });
      //print('got all files from data folder');
      //print(savedEstimates);
      savedEstimates.forEach((key, value) => print(key));
      return savedEstimates;
    } catch (e) {
      throw Exception("Could Not Retrieve list of saved files");
    }
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static bool isInteger(String s) {
    if (isNumeric(s)) {
      //print('file name is numeric');
      num numToTest = int.parse(s);

      //print("numToTest is");
      //print(numToTest);
      //print(numToTest.runtimeType);
      //print("numToTest is int");
      //print(numToTest is int);

      return numToTest is int;
    }
    throw 'j';
  }

  Future<String> get localPath async {
    // finds the correct local path using path_provider package
    try {
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    } catch (e) {
      print(e);
      return "Error";
    }
  }

  Future<File> _localFile() async {
    // creates a reference to the file location
    final path = await localPath;
    // print('path is');
    // print(path);
    var newFile = File(path + '/' + fileName);
    // print('newFile path is');
    // print(newFile.path);
    return File(path + '/' + fileName);
  }

  Future<File> writeStringToFile() async {
    final file = await _localFile();
    try {
      //print("writing to file from writeStringToFile");
      return file.writeAsString(fileContents);
    } catch (e) {
      print("write failed");
      return file;
    }
  }

  Future<String> readStringFromFile() async {
    try {
      final file = await _localFile();
      final fileContents = await file.readAsString();
      // print(fileContents);
      return fileContents;
    } catch (e) {
      return 'Could Not Read File Contents';
    }
  }
}
