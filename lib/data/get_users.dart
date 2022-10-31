import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:providers_riverpods/model/user_model.dart';

List<Data> parseUser(String response) {
  var list = json.decode(response) as Map<String, dynamic>;
  final User user = User.fromJson(list);
  print(user);
  return user.data;
}

Future<List<Data>> getUsers() async {
  final response =
      await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
  final body = response.body;
  return compute(parseUser, body);
}



