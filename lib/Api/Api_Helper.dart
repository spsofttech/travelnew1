import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelnew_app/Api/pref_halper.dart';

import '../model/getAllUserModel.dart'as allUserModel;
import 'ApiModel.dart';
import 'api_url.dart';
import 'model/aspiredTrip_detail_model.dart';
import 'model/aspired_trip_model.dart';
import 'model/cteate_new_trip_model.dart';
import 'model/day_vise_data_model.dart';
import 'model/event_trip_get_model.dart';
import 'model/get_trip_city_model.dart';
import 'model/prima_sopt_model.dart';
import 'model/prima_trip_publish_send_model.dart';
import 'model/prima_type_dropdwon_model.dart';
import 'model/user_trip_interest_Model.dart';

List<allUserModel.Data> all_user_list=[];
List<allUserModel.Data> all_user_Search_list=[];
class ApiHelper {
  Preferences preferences = Preferences();

  Future<int> signupWithEmailApiCall({required String email, required String password,required String name,required String birth_date,required String contactNum }) async {

    http.Response res = await http.post(
      Uri.parse(ApiUrl.userSignUp),
      headers: <String, String>{'authorization': ApiUrl.basicAuth},
      body: {'email': email, 'password': password,'name':name,'birth_date':birth_date,'contact':contactNum},
    );

    print("LOGIN Res -- ${res.body}");

    if (res.statusCode == 200) {
      Map<String, dynamic> data = await jsonDecode(res.body);

      if (data['status'] == 1) {
        IS_USER_LOGIN = await Preferences.preferences.saveBool(key: PrefKeys.isUaseLogin, value: true);

        USER_ID_pref =data['status']['data']['user_id'];
        await Preferences.preferences.saveString(key: PrefKeys.userId,value: USER_ID_pref);
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

  Future<int> loginWithEmailApiCall({required String email, required String password}) async {
    http.Response res = await http.post(
      Uri.parse(ApiUrl.user_login),
      headers: <String, String>{'authorization': ApiUrl.basicAuth},
      body: {'email': email, 'password': password},
    );

    print("LOGIN Res -- ${res.body}");
    if (res.statusCode == 200) {

      Map<String, dynamic> data = await jsonDecode(res.body);

      if (data['status'] == 1) {

        IS_USER_LOGIN = await Preferences.preferences.saveBool(key: PrefKeys.isUaseLogin, value: true);
        USER_ID_pref =data['data']['user_id'];
        await Preferences.preferences.saveString(key: PrefKeys.userId,value: USER_ID_pref);
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

   // print("Explore Trip  ${model.toJson()}-");
    http.Response res = await http.post(
      Uri.parse(ApiUrl.exploreTrip),
      headers: <String, String>{'authorization': ApiUrl.basicAuth,'Content-Type':'application/json'},
      body:jsonEncode(model.toJson())
    );

    print("Explore Trip  ${jsonDecode(res.body)}-");


    if (res.statusCode == 200) {

      create_trip_get_model data = create_trip_get_model.fromJson( jsonDecode(res.body));

      if (data.data == 1) {
        // USER_ID =data['status']['data']['user_id'];
        // await Preferences.preferences.saveInt(key: PrefKeys.userId,value: USER_ID);
        // IS_USER_LOGIN = await Preferences.preferences.saveBool(key: PrefKeys.isUaseLogin, value: true);
        return data;
      }
      else
      {
        return data;
      }

    }
    else
    {
      return create_trip_get_model(status: 0,);
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

  static Future<TripCity_get_model> get_tripCity_api_call({ String state =""}) async {
    // type  ==0  = travelnew category &  type ==1 = quick escap
    Map _body= {
    'state':state
    };
    http.Response res = await http.post(
      Uri.parse(ApiUrl.get_tripcity_url),

      headers: <String, String>{'authorization': ApiUrl.basicAuth,},
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

  Future<Day_vise_data_get_model> get_days_api_call({ required int trip_id,required int days}) async {
    // type  ==0  = travelnew category &  type ==1 = quick escap
    print("--------------  ");
    Map _body ={
      'trip_id':trip_id,
      'days':days
    };

    http.Response res = await http.post(
        Uri.parse(ApiUrl.get_tn_days),
        headers: <String, String>{'authorization': ApiUrl.basicAuth,'Content-Type':'application/json'},
        body:jsonEncode(_body)
    );



    if (res.statusCode == 200) {

      Day_vise_data_get_model data = Day_vise_data_get_model.fromJson( jsonDecode(res.body));


      if (data.status == 1)
      {
        return data;
      }
      else
      {
        return data;
      }

    }
    else
    {
      return Day_vise_data_get_model(status: 0,data: []);
    }

  }

  static Future<bool> get_allUser_api_call({ required int user_id,required int page}) async {
    bool isLastPage=false;
    // type  ==0  = travelnew category &  type ==1 = quick escap

    Map _body ={
      'page':page,
      'user_id':user_id
    };

    http.Response res = await http.post(
        Uri.parse(ApiUrl.get_all_user),
        headers: <String, String>{'authorization': ApiUrl.basicAuth,'Content-Type':'application/json'},
        body:jsonEncode(_body)
    );


    if (res.statusCode == 200) {

      //all_user_list.clear();
      allUserModel.UserFriend_details_Get_model data = allUserModel.UserFriend_details_Get_model.fromJson( jsonDecode(res.body));
      all_user_list.addAll(data.data!);
      isLastPage= data.nextPage=="0";
      print("--------------  ${data.nextPage!}");
    return  isLastPage;

    }
    else
    {
      return isLastPage;
    }

  }

  static Future<bool> get_allUser_search_api_call({ required String name,required int page}) async {
    bool isLastPage=false;
    // type  ==0  = travelnew category &  type ==1 = quick escap

    Map _body ={
      'page':page,
      'name':name
    };

    http.Response res = await http.post(
        Uri.parse(ApiUrl.get_all_search_user),
        headers: <String, String>{'authorization': ApiUrl.basicAuth,'Content-Type':'application/json'},
        body:jsonEncode(_body)
    );


    if (res.statusCode == 200) {
      //all_user_list.clear();
      allUserModel.UserFriend_details_Get_model data = allUserModel.UserFriend_details_Get_model.fromJson( jsonDecode(res.body));
      all_user_Search_list.addAll(data.data!);
      isLastPage= data.nextPage=="0";
      print("--------------  ${data.nextPage!}");
    return  isLastPage;
    }
    else
    {
      return isLastPage;
    }

  }

  static Future<bool> create_new_trip_Apicall({required create_new_Trip_send_model model}) async {

    bool success=false;
     print("Explore Trip  ${model.toJson()}-");
    http.Response res = await http.post(
        Uri.parse(ApiUrl.create_tn_trip),
        headers: <String, String>{'authorization': ApiUrl.basicAuth,'Content-Type':'application/json'},
        body:jsonEncode(model.toJson())
    );

    print("create Trip Trip  ${res.body}-");

    if (res.statusCode == 200) {
      success=jsonDecode(res.body)['status']==1;
    }
    else
    {
      success=false;
    }

    return success;
  }

  static  Future<prima_type_dropdown> get_prima_type_dropdown() async {
    // type  ==0  = travelnew category &  type ==1 = quick escap

    http.Response res = await http.post(
        Uri.parse(ApiUrl.get_prima_type),

        headers: <String, String>{'authorization': ApiUrl.basicAuth},
    );

    if (res.statusCode == 200) {
prima_type_dropdown data = prima_type_dropdown.fromJson( jsonDecode(res.body));

      if (data.status == 1)
      {
        return data;
      }
      else
      {
        return data;
      }

    }
    else {
      return prima_type_dropdown(status: 0);
    }
  }

  static Future<prima_spot_get_model> get_prima_spot_api_call({ required String city,required String type}) async {

    prima_spot_get_model alldata=prima_spot_get_model();
    // type  ==0  = travelnew category &  type ==1 = quick escap

    Map _body = {
      'city':city,
      'type':type
    };

    http.Response res = await http.post(
        Uri.parse(ApiUrl.get_prima_spot),
        headers: <String, String>{'authorization': ApiUrl.basicAuth,'Content-Type':'application/json'},
        body:jsonEncode(_body)
    );


    if (res.statusCode == 200) {
      //all_user_list.clear();
      prima_spot_get_model data = prima_spot_get_model.fromJson( jsonDecode(res.body));
      alldata=data;
      return  alldata;
    }
    else
    {
      return alldata;
    }

  }

  static Future<bool> prima_publish_Apicall({required prima_trip_publish_send_model model}) async {

    bool success=false;
    print("Explore Trip  ${model.toJson()}-");
    http.Response res = await http.post(
        Uri.parse(ApiUrl.prima_publish),
        headers: <String, String>{'authorization': ApiUrl.basicAuth,'Content-Type':'application/json'},
        body:jsonEncode(model.toJson())
    );

    print("create Trip Trip  ${res.body}-");

    if (res.statusCode == 200) {
      success=jsonDecode(res.body)['status']==1;
    }
    else
    {
      success=false;
    }

    return success;
  }

  static  Future<event_trip_get_model> get_event_trip_apiCall({required int month}) async {
    // type  ==0  = travelnew category &  type ==1 = quick escap
  String monthString=month<10?"0$month":"$month";
  // String monthString="$month";
  print(monthString);
    Map _body ={
      'month':"$month"
    };
    http.Response res = await http.post(
      Uri.parse(ApiUrl.event_trip),
      headers: <String, String>{'authorization': ApiUrl.basicAuth},
      body: _body
    );

    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
      event_trip_get_model data = event_trip_get_model.fromJson(jsonDecode(res.body));
      /*if (data.status == 1)
      {
        return data;
      }
      else
      {
        return data;
      }*/
      return data;
    }
    else {
      return event_trip_get_model(status: 0);
    }
  }

  static  Future<aspire_trip_get_model> get_aspired_trip_apiCall() async {
    // type  ==0  = travelnew category &  type ==1 = quick escap
  // String monthString=month<10?"0$month":"$month";
  // print(monthString);
  //   Map _body ={
  //     'month':monthString
  //   };
    http.Response res = await http.post(
      Uri.parse(ApiUrl.get_aspired_trip),
      headers: <String, String>{'authorization': ApiUrl.basicAuth},
    );

    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
      aspire_trip_get_model data = aspire_trip_get_model.fromJson( jsonDecode(res.body));

      if (data.status == 1)
      {
        return data;
      }
      else
      {
        return data;
      }

    }
    else {
      return aspire_trip_get_model(status: 0);
    }
  }

  static  Future<aspire_trip_detail_get_model> get_aspired_trip_details_apiCall({required int id}) async {
    // type  ==0  = travelnew category &  type ==1 = quick escap
  //String monthString=month<10?"0$month":"$month";
  //print(monthString);
    Map _body ={
      'trip id':id
    };
    http.Response res = await http.post(
      Uri.parse(ApiUrl.get_aspired_days),
      headers: <String, String>{'authorization': ApiUrl.basicAuth},
      body: _body
    );

    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
      aspire_trip_detail_get_model data = aspire_trip_detail_get_model.fromJson( jsonDecode(res.body));

      if (data.status == 1)
      {
        return data;
      }
      else
      {
        return data;
      }

    }
    else {
      return aspire_trip_detail_get_model(status: 0);
    }
  }





}


