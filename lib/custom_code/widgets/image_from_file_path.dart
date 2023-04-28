// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';

class ImageFromFilePath extends StatefulWidget {
  const ImageFromFilePath({
    Key? key,
    this.width,
    this.height,
    required this.imgFilePath,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String imgFilePath;

  @override
  _ImageFromFilePathState createState() => _ImageFromFilePathState();
}

class _ImageFromFilePathState extends State<ImageFromFilePath> {
  @override
  Widget build(BuildContext context) {
    return Image.file(File(widget.imgFilePath));
  }
}
