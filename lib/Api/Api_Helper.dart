import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelnew_app/Api/pref_halper.dart';

import 'ApiModel.dart';
import 'api_url.dart';
import 'model/user_trip_interest_Model.dart';

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

  Future<create_trip_get_model> explore_trip_Apicall({required create_trip_send_model model}) async {
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

  Future<TravelNew_Category_get_model> get_tn_category_api_call({ int type =0}) async {
    // type  ==0  = travelnew category &  type ==1 = quick escap
    Map _body= {
    "type":type
    };
    http.Response res = await http.post(
      Uri.parse(ApiUrl.get_tn_category),

      headers: <String, String>{'authorization': ApiUrl.basicAuth,'Content-Type':'application/json'},
      body:jsonEncode(_body)
    );
    if (res.statusCode == 200) {
      TravelNew_Category_get_model data = TravelNew_Category_get_model.fromJson( jsonDecode(res.body));

      print("-------   --${jsonDecode(res.body)}");
      if (data.status == 1) {

        return data;
      } else {
        return data;
      }
    } else {
      return TravelNew_Category_get_model(status: 0);
    }
  }

  Future<TravelNew_StateDropdown_get_model> get_tripSate_api_call({ String state =""}) async {
    // type  ==0  = travelnew category &  type ==1 = quick escap
    Map _body= {
    'state':state
    };
    http.Response res = await http.post(
      Uri.parse(ApiUrl.get_state_url),

      headers: <String, String>{'authorization': ApiUrl.basicAuth},
      body:jsonEncode(_body)
    );

    if (res.statusCode == 200) {
      TravelNew_StateDropdown_get_model data = TravelNew_StateDropdown_get_model.fromJson( jsonDecode(res.body));

      if (data.status == 1) {
        return data;
      }
      else {
        return data;
      }

    }
    else {
      return TravelNew_StateDropdown_get_model(status: 0);
    }
  }

  Future<TripCity_get_model> get_tripCity_api_call({ String state =""}) async {
    // type  ==0  = travelnew category &  type ==1 = quick escap
    Map _body= {
    'state':state
    };
    http.Response res = await http.post(
      Uri.parse(ApiUrl.get_tripcity_url),

      headers: <String, String>{'authorization': ApiUrl.basicAuth},
      body:jsonEncode(_body)
    );

    if (res.statusCode == 200) {
      TripCity_get_model data = TripCity_get_model.fromJson( jsonDecode(res.body));

      if (data.status == 1) {
        return data;
      }
      else {
        return data;
      }

    }
    else {
      return TripCity_get_model(status: 0);
    }
  }

  Future<User_Trip_Interest_Model> get_userIntrest_api_call() async {
    // type  ==0  = travelnew category &  type ==1 = quick escap

    // Map _body= {
    // 'state':state
    // };
    http.Response res = await http.post(
      Uri.parse(ApiUrl.get_tn_interest),

      headers: <String, String>{'authorization': ApiUrl.basicAuth},
    );

    if (res.statusCode == 200) {
      User_Trip_Interest_Model data = User_Trip_Interest_Model.fromJson( jsonDecode(res.body));

      if (data.status == 1) {
        return data;
      }
      else
      {
        return data;
      }

    }
    else {
      return User_Trip_Interest_Model(status: 0);
    }
  }


}
