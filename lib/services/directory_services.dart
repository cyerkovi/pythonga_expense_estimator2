import 'dart:io' as io;
import 'dart:async';
import 'package:path_provider/path_provider.dart' as pathprvdrpkg;
import 'package:path/path.dart' as pathpkg;
import '../constants/text_constants.dart';

class DirectoryHelper {
  static Future<Map<io.FileSystemEntity, String>> listOfFiles() async {
    List<io.FileSystemEntity> fileSystemEntityList =
        io.Directory(await localPath()).listSync();
    Map<io.FileSystemEntity, String> fileMap = {};
    for (int i = 0; i < fileSystemEntityList.length; i++) {
      if (pathpkg.extension(fileSystemEntityList[i].path) ==
          kEstimateFileExtension) {
        fileMap[fileSystemEntityList[i]] = fileSystemEntityList[i].path;
      }
    }
    return fileMap;
  }

  static localPath() async {
    // finds the correct local path using path_provider package
    try {
      final directory = await pathprvdrpkg.getApplicationDocumentsDirectory();
      // print("directory.path in DirectoryPath.localPath");
      return directory.path;
    } catch (e) {
      return Exception('Error: $e');
    }
  }
}
