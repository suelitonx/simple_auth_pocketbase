import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String ipPocketbase = "http://127.0.0.1:8090";

final pbServiceProvider = ChangeNotifierProvider<PocketbaseService>((ref) => PocketbaseService());

class PocketbaseService extends ChangeNotifier {
  PocketBase pb = PocketBase(ipPocketbase);

  bool duplicate = false;

  PocketbaseService() {
    validateLogin();
  }

  Future<void> validateLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final store = AsyncAuthStore(
      save: (String data) async => prefs.setString('pb_auth', data),
      initial: prefs.getString('pb_auth'),
      clear: () async => prefs.remove('pb_auth'),
    );

    pb = PocketBase(ipPocketbase, authStore: store);

    if (pb.authStore.isValid) {
      await pb.collection('users').authRefresh(expand: "escola").then((result) {
        pb.authStore.save(result.token, result.record);
      }).catchError((dynamic error) {
        pb.authStore.clear();
      });
    }

    pb.authStore.onChange.listen((event) {
      if (kDebugMode) {
        print('authStore.onChange');
      }
      notifyListeners();
    });

    notifyListeners();
  }

  Future<bool> login({required String email, required String password}) async {
    if (email.isEmpty || password.length < 8) {
      return false;
    }

    bool result = false;

    await pb.collection('users').authWithPassword(email, password).then((value) {
      if (kDebugMode) {
        //print(value);
        pb.authStore.save(value.token, value.record);
      }
      result = true;
      notifyListeners();
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
    });

    return result;
  }

  Future<bool> register({required String email, required String password, required String name, String username = ''}) async {
    bool result = false;
    Map<String, dynamic> data = {
      "username": username,
      "email": email,
      "emailVisibility": true,
      "password": password,
      "passwordConfirm": password,
      "name": name,
    };

    await pb.collection('users').create(body: data).then((value) {
      result = true;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      result = false;
    });

    return result;
  }

  Future<void> logout() async {
    pb.authStore.clear();
    notifyListeners();
  }
}
