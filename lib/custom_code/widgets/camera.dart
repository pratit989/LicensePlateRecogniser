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
import '../../backend/api_requests/api_calls.dart';
import 'package:image/image.dart' hide Image;
import 'package:flutter_native_image/flutter_native_image.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';

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
    required this.resetManualEntry,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Future<dynamic> Function() resetManualEntry;

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  bool refresh = false;
  bool processingImage = true;

  @override
  Widget build(BuildContext context) {
    if (!refresh) {
      return CameraAwesomeBuilder.custom(
        builder: (cameraState, previewSize, previewRect) {
          return StreamBuilder<MediaCapture?>(
            stream: cameraState.captureState$,
            builder: (context, snapshot) {
              if (!snapshot.hasData && processingImage) {
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

              File capturedImage = File(snapshot.requireData!.filePath);
              if (snapshot.requireData!.status == MediaCaptureStatus.success) {
                FlutterNativeImage.compressImage(capturedImage.path,
                        quality: 60, percentage: 100)
                    .then((compressedImage) {
                  Uint8List byteData = compressedImage.readAsBytesSync();
                  print((byteData.lengthInBytes / 1024) / 1024);
                  if (processingImage) {
                    PlateRecognizerAPIGroup.readNumberPlatesFromAnImageCall
                        .call(
                            upload:
                                FFUploadedFile(bytes: byteData, name: "test"))
                        .then((value) {
                      Future.delayed(
                          Duration(),
                          () => setState(() {
                                processingImage = false;
                              }));
                      FFAppState().update(() {
                        FFAppState().numberPlate = PlateRecognizerAPIGroup
                            .readNumberPlatesFromAnImageCall
                            .plateNumber(value.jsonBody);
                      });
                    });
                  }
                });
                return Stack(
                  children: [
                    Image.file(capturedImage),
                    processingImage
                        ? const Center(child: CircularProgressIndicator())
                        : Container(),
                    Align(
                      alignment: AlignmentDirectional(1, -1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 8,
                          borderWidth: 1,
                          buttonSize: 40,
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          icon: Icon(
                            Icons.close,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 20,
                          ),
                          onPressed: () async {
                            Future.delayed(
                                Duration(),
                                () => setState(() {
                                      refresh = true;
                                      processingImage = true;
                                    }));
                            FFAppState().update(() {
                              FFAppState().numberPlate = "";
                            });
                            // Navigator.of(context, rootNavigator:
                            // true).push(MaterialPageRoute(builder: (builder) => HomePageWidget()));
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }

              return const Center(child: CircularProgressIndicator());
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
    } else {
      Future.delayed(
          Duration(seconds: 1),
          () => setState(() {
                refresh = false;
              }));
      return const Center(child: CircularProgressIndicator());
    }
  }
}
