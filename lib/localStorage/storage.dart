import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Storage {
  final String filename;

  Storage(this.filename);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  Future<String> read() async {
    final file = await _localFile;
    return await file.readAsString();
  }

  Future<bool> exists() async {
    final file = await _localFile;
    return await file.exists();
  }

  Future<File> write(String content) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(content);
  }

  Future<File> delete() async {
    final file = await _localFile;
    if (await file.exists()) {
      return file.delete();
    }
    return null;
  }
}