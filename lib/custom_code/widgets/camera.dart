// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:better_open_file/better_open_file.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/generated/i18n.dart';
import 'package:camerawesome/pigeon.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> path(CaptureMode captureMode) async {
  final Directory extDir = await getTemporaryDirectory();
  final testDir =
      await Directory('${extDir.path}/test').create(recursive: true);
  final String fileExtension = captureMode == CaptureMode.photo ? 'jpg' : 'mp4';
  final String filePath =
      '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
  FFAppState().update(() => FFAppState().uploadedFilePath = filePath);
  return filePath;
}

class Camera extends StatefulWidget {
  const Camera({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    return CameraAwesomeBuilder.awesome(
      saveConfig: SaveConfig.photo(
        pathBuilder: () => path(CaptureMode.photo),
      ),
      enablePhysicalButton: true,
      filter: AwesomeFilter.None,
      flashMode: FlashMode.auto,
      aspectRatio: CameraAspectRatios.ratio_1_1,
      previewFit: CameraPreviewFit.fitWidth,
      onMediaTap: (mediaCapture) {
        OpenFile.open(mediaCapture.filePath);
      },
    );
  }
}
