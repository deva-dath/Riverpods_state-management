import 'package:providers_riverpods/data/get_users.dart';
import 'package:providers_riverpods/model/user_model.dart';
import 'dart:convert';
import 'package:riverpod/riverpod.dart';

final userStateFuture = FutureProvider<List<Data>>((ref) async {
  return getUsers();
});
bool isNotifiable = false;

void toggleNotification({bool isNotifiable = true}) {}
