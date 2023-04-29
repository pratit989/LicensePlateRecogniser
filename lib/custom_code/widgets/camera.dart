// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
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
    return CameraAwesomeBuilder.custom(
      builder: (cameraState, previewSize, previewRect) {
        return StreamBuilder<MediaCapture?>(
          stream: cameraState.captureState$,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return cameraState.when(
                onPreparingCamera: (state) =>
                    const Center(child: CircularProgressIndicator()),
                onPhotoMode: (state) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AwesomeTopActions(
                      state: state,
                      children: [
                        AwesomeFlashButton(
                          state: state,
                        ),
                      ],
                    ),
                    AwesomeBottomActions(
                      // CameraState is required
                      state: state,
                      // Padding around the bottom actions
                      padding: const EdgeInsets.only(
                        bottom: 16,
                        left: 8,
                        right: 8,
                      ),
                      // Widget to the left of the captureButton
                      left: Container(),
                      // Widget to the right of the captureButton
                      right: Container(),
                      // Callback used by default values. Don't specify it if you override left and right widgets.
                      onMediaTap: null,
                    ),
                  ],
                ),
              );
            }
            return Image.file(File(snapshot.requireData!.filePath));
          },
        );
      },
      saveConfig: SaveConfig.photo(
        pathBuilder: () => path(CaptureMode.photo),
      ),
      enablePhysicalButton: true,
      filter: AwesomeFilter.None,
      flashMode: FlashMode.auto,
      aspectRatio: CameraAspectRatios.ratio_1_1,
      previewFit: CameraPreviewFit.fitWidth,
    );
  }
}
