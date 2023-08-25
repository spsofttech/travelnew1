import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelnew_app/Api/pref_halper.dart';

import 'ApiModel.dart';
import 'api_url.dart';

class ApiHelper {
  Preferences preferences = Preferences();

  Future<int> loginWithEmailApiCall({required String email, required String password,required String name,required String birth_date,required String contactNum }) async {
    http.Response res = await http.post(
      Uri.parse(ApiUrl.userLogin),
      headers: <String, String>{'authorization': ApiUrl.basicAuth},
      body: {'email': email, 'password': password,'name':name,'birth_date':birth_date,'contact':contactNum},
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = await jsonDecode(res.body);

      if (data['status'] == 1) {
        IS_USER_LOGIN = await Preferences.preferences.saveBool(key: PrefKeys.isUaseLogin, value: true);

       // Preferences.preferences.saveInt(key: PrefKeys.userId,value: data['status']['data'][''] );
        return 0;
      }
      else {
        return 1;
      }
    }
    else {
      return 1;
    }
  }

  Future<create_trip_get_model> createa_trip_Apicall({required create_trip_send_model model}) async {
    http.Response res = await http.post(
      Uri.parse(ApiUrl.userLogin),
      headers: <String, String>{'authorization': ApiUrl.basicAuth},
      body:model.toJson()
    );
    if (res.statusCode == 200) {
      create_trip_get_model data = create_trip_get_model.fromJson( jsonDecode(res.body));

      if (data.status == 1) {
        IS_USER_LOGIN = await Preferences.preferences.saveBool(key: PrefKeys.isUaseLogin, value: true);
        return data;
      } else {
        return data;
      }
    } else {
      return create_trip_get_model(status: 0);
    }
  }
}
