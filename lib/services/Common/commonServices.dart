import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommonServices {
  var client = http.Client();
  Map<String, String> headers = {};

  Future getUrl({required Uri url}) async {
    String token = "";
    // data!.headers['Content-Type'] = 'application/json';
    // data.headers['Authorization'] = 'bearer $token';
    headers['Content-Type'] = 'application/json';
    headers['Authorization'] = 'bearer $token';
    try {
      var response = await client.get(url, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint("\nerror status Code ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("\ncatch Error $e");
      return null;
    }
  }

  postUrl({required Uri url, required Map<String, dynamic> body}) async {
    String token = "";

    headers['Content-Type'] = 'application/json';
    headers['Authorization'] = 'bearer $token';
    try {
      var response =
          await client.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint("\nerror ${response.statusCode}");
        return;
      }
    } catch (e) {
      debugPrint("\ncatch Error $e");
      return;
    }
  }
}
