import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Plate Recognizer API Group Code

class PlateRecognizerAPIGroup {
  static String baseUrl = 'https://api.platerecognizer.com/v1';
  static Map<String, String> headers = {
    'Authorization': 'Token 21cf0eb07075952f4f698ff93dcaa28f61019c4d',
  };
  static ReadNumberPlatesFromAnImageCall readNumberPlatesFromAnImageCall =
      ReadNumberPlatesFromAnImageCall();
}

class ReadNumberPlatesFromAnImageCall {
  Future<ApiCallResponse> call({
    String? upload = '',
    String? uploadUrl = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Read Number Plates from an Image',
      apiUrl: '${PlateRecognizerAPIGroup.baseUrl}/plate-reader/',
      callType: ApiCallType.POST,
      headers: {
        ...PlateRecognizerAPIGroup.headers,
      },
      params: {
        'upload_url': uploadUrl,
        'upload': upload,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic plateNumber(dynamic response) => getJsonField(
        response,
        r'''$.results[:].plate''',
      );
  dynamic timeStamp(dynamic response) => getJsonField(
        response,
        r'''$.timestamp''',
      );
}

/// End Plate Recognizer API Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar) {
  jsonVar ??= {};
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return '{}';
  }
}
