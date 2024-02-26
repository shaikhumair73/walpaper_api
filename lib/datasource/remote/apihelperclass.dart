import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:walpaper_api/datasource/remote/app_exception.dart';
import 'package:walpaper_api/datasource/remote/urls.dart';

class ApiHelper {
  Future<dynamic> getApi(String url, {Map<String, String>? header}) async {
    var uri = Uri.parse(url);
    try {
      var response =
          await http.get(uri, headers: header ?? {"Authorization": Url.Key});
      return returnDataException(response);
    } on SocketException {
      throw FetchDataException(body: "network error");
    }
  }

  dynamic returnDataException(http.Response res) {
    switch (res.statusCode) {
      case 200:
        var actRes = res.body;
        print(actRes);
        print("status code ${res.statusCode}");
        var mdata = jsonDecode(actRes);
        return mdata;
      case 400:
        throw BadRequestException(body: res.body.toString());
      case 401:
        throw UnauthorisedException(body: res.body.toString());
      case 403:
        throw UnauthorisedException(body: res.body.toString());
      case 500:
      default:
        throw FetchDataException(
            body:
                "error occured while communication with server with status code ${res.statusCode}");
    }
  }
}
