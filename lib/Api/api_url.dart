
import 'dart:convert';

class ApiUrl {

  static String baseUrl="https://spsofttech.com/projects/travel_new/api/";
  static String basicAuth = 'Basic ${base64Encode(utf8.encode('user:password'))}';
  static String userSignUp="${baseUrl}user_signup";
  static String user_login="${baseUrl}user_login";
  static String exploreTrip="${baseUrl}explore_trip";
  static String get_state_url="${baseUrl}get_state";
  static String get_tripcity_url="${baseUrl}get_tripcity";
  static String get_tn_category="${baseUrl}get_tn_category";
  static String get_tn_interest="${baseUrl}get_interest";
  static String get_tn_days="${baseUrl}tn_days_data";
  static String create_tn_trip="${baseUrl}create_tn_trip";
  static String get_all_user="${baseUrl}get_user";
  static String get_all_search_user="${baseUrl}search_user";

}