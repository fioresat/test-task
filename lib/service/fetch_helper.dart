import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task/consts/service_strings.dart';
import '../consts/consts.dart';

class FetchHelper {
  Future<dynamic> getData() async {
    print(ServiceStrings.request);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      http.Response response = await http.get(Uri.parse(Consts.baseUrl));
      if (response.statusCode == 200) {
        prefs.setString('cache', (response.body));
        print(prefs.getString('cache'));
        final body = jsonDecode(response.body);

        return body;
      } else {
        print(response.statusCode);
      }
    } on SocketException catch (_) {
      print(ServiceStrings.noInternetConnection);
      if (prefs.getString('cache') != null) {
        final body = jsonDecode(prefs.getString('cache')!);
        return body;
      }
      else {print(ServiceStrings.failed);}
    }
  }
}
