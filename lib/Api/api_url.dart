
import 'dart:convert';

class ApiUrl {
  static String baseUrl="https://spsofttech.com/projects/travel_new/api/";
  static String basicAuth = 'Basic ${base64Encode(utf8.encode('user:password'))}';
  static String userLogin="${baseUrl}user_login";
  static String createPlanTrip="${baseUrl}create_trip";

}