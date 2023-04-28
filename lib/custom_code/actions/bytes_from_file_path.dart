// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';

Future<String> bytesFromFilePath(String filePath) async {
  // uint8list from file path

  Uint8List bytes = Uint8List(0);
  await File(filePath).readAsBytes().then((value) {
    bytes = Uint8List.fromList(value);
  });
  return bytes.toString();
}
