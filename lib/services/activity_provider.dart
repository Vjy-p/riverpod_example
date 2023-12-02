import 'dart:convert';
import 'package:example_riverpod/Models/activity_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final activityProvider = FutureProvider.autoDispose((ref) async {
  final response = await http.get(Uri.https('boredapi.com', '/api/activity'));

  debugPrint("\nresp ${response.body} ${response.statusCode}");
  final json = jsonDecode(response.body) as Map<String, dynamic>;

  return Activity.fromJson(json);
});
