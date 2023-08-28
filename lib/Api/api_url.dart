
import 'dart:convert';

class ApiUrl {
  static String baseUrl="https://spsofttech.com/projects/travel_new/api/";
  static String basicAuth = 'Basic ${base64Encode(utf8.encode('user:password'))}';


  static String userLogin="${baseUrl}user_login";
  static String createPlanTrip="${baseUrl}create_trip";
  static String get_state_url="${baseUrl}get_state";
  static String get_tripcity_url="${baseUrl}get_tripcity";
  static String get_tn_category="${baseUrl}get_tn_category";
  static String get_tn_interest="${baseUrl}get_interest";


}