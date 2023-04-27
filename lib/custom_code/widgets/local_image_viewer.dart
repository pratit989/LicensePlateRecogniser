// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class LocalImageViewer extends StatefulWidget {
  const LocalImageViewer({
    Key? key,
    this.width,
    this.height,
    required this.imageData,
  }) : super(key: key);

  final double? width;
  final double? height;
  final FFUploadedFile imageData;

  @override
  _LocalImageViewerState createState() => _LocalImageViewerState();
}

class _LocalImageViewerState extends State<LocalImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Image.memory(
      widget.imageData.bytes ?? Uint8List(0),
      width: widget.width,
      height: widget.height,
      fit: BoxFit.fill,
      errorBuilder: (_, __, ___) => Container(
        height: widget.height,
        width: widget.width,
      ),
    );
  }
}
