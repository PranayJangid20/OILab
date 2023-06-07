import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oilab_task/utils/app_constant.dart';

class NetworkService {
  static Future<Map<String, dynamic>> get(String page) async {
    String url = AppConstant.url + page;
    try {
      var response = await http.get(Uri.parse(url));
      return _fetchResponse(response);
    } catch (e) {
      return {'success': false, 'result': 501};
    }
  }

  static dynamic _fetchResponse(http.Response response) {
    var responseJson;
    if (response.body.isNotEmpty) {
      responseJson = json.decode(response.body);
    } else {
      responseJson = <dynamic, String>{};
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'success': true, 'data': responseJson};
    } else {
      return {'success': false};
    }
  }
}
