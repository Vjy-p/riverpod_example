import 'dart:convert';

import 'package:example_riverpod/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MapServices {
  static Future getTimedist(sourcelat, sourcelong, destlat, destlong) async {
    http.Response response;
    try {
      response = await http.get(
          Uri.parse(
              "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$destlat,$destlong&origins=$sourcelat,$sourcelong&units=imperial&key=${Constants.googleKey}"),
          headers: {
            'Content-Type': 'application/json',
          });
      debugPrint("\nrespone $response");
      if (response.statusCode == 200) {
        debugPrint("\nrespone ${response.body}");
        return jsonDecode(response.body);
      }
    } catch (e) {
      debugPrint("\nexception $e");
      return e;
    }
  }

  //  data.headers['Authorization'] = 'bearer $token';
}
