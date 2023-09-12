import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';
import '../widget/my_bottom_navbar.dart';

class LocationProvider with ChangeNotifier {
  String currentAddress = " ";
  var locality;
  var country;
  var postalCode;
  Position? currentPosition;
  double? lat;
  double? long;
  // new function
  locationDeatials() async {
    final _fireStore = FirebaseFirestore.instance;
    await _fireStore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "lat": loclat ?? "",
      "lng": loclng ?? "",
      "address": locadd ?? "",
      "locality": local ?? "",
    });
  }

  String loclat = "";
  String loclng = "";
  String locadd = "";
  String? local = "";

  void getLocation() async {
    if (IS_USER_LOGIN) {
      var location = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      locadd = location.data()?['address'];
      loclat = location.data()!['lat'] ?? "0.000000";
      loclng = location.data()!['lng'] ?? "0.000000";
      local = location.data()?['locality'];
    }
  }

  // fetching current position
  Future fetchCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    await Geolocator.getCurrentPosition().then((value) async {
      try {
        List<Placemark> placeMarks = await placemarkFromCoordinates(value.latitude, value.longitude);
        lat = value.latitude;
        long = value.longitude;

        Placemark place = placeMarks[0];

        currentPosition = value;
        currentAddress = "${place.locality}, ${place.postalCode}, ${place.administrativeArea}";
        locality = place.locality!;
        UserCity = locality.toString();
        UserState = place.administrativeArea!.toString();
        postalCode = place.postalCode!;
        country = place.country!;
        log(currentAddress);
        log(lat.toString());
        log(value.longitude.toString());
        loclat = lat.toString();
        loclng = value.longitude.toString();
        locadd = currentAddress;
        local = place.locality!;
        notifyListeners();
        //return currentAddress ;
      } catch (e) {
        log(e.toString());
      }
    });
    // registerUserSignupPage();
    notifyListeners();
  }

  // fetching latitude and longitude
  List<Location> newLatLongList = [];

  Future<List<Location>> getLatLong(BuildContext context, String address) async {
    await locationFromAddress(address).then((value) async {
      //newLatLongList.clear();
      for (var data in value) {
        newLatLongList.add(data);
        log(newLatLongList.toString());
        lat = newLatLongList.first.latitude;
        long = newLatLongList.first.longitude;
        getAddressFromLatLng(newLatLongList.first.latitude, newLatLongList.first.longitude).then((value) {
          currentAddress = value!;
        });
      }
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
      Navigator.pop(context);
    });

    notifyListeners();
    return newLatLongList;
  }

  // fetching address from latitude and longitude
  static const String _mapApiKey = "AIzaSyBtvEIVojiFHFC62dxHdpaCL5r5VFotq9s";

  Future<String?> getAddressFromLatLng(double lat, double lng) async {
    String host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$host?key=$_mapApiKey&language=en&latlng=$lat,$lng';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      String formattedAddress = data["results"][0]["formatted_address"];
      log("response ==== $formattedAddress");
      currentAddress = formattedAddress;
      //return currentAddress;
    } else {
      return null;
    }
  }

  // delete user location
  Future<void> deleteLocations(List<dynamic> list) async {
    await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid.substring(0, 20)).update({"address": list});
    notifyListeners();
  }
}

class festivalLocationProvider with ChangeNotifier {
  String currentAddress = " ";
  var locality;
  var country;
  var postalCode;
  var distance;
  Position? currentPosition;
  double? lat;
  double? long;
  // new function
  locationDeatials() async {
    final _fireStore = FirebaseFirestore.instance;
    await _fireStore
        .collection("festivals")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"lat": loclat ?? "", "lng": loclng ?? "", "address": locadd ?? "", "locality": local ?? "", "CarTime": cartime, "TrainTime": traintime});
  }

  String loclat = "";
  String loclng = "";
  String locadd = "";
  String local = "";
  double cartime = 0.0;
  double traintime = 0.0;
  void getLocation() async {
    if (IS_USER_LOGIN) {
      var location = await FirebaseFirestore.instance.collection('festivals').doc(FirebaseAuth.instance.currentUser!.uid).get();
      locadd = location.data()?['address'];
      loclat = location.data()?['lat'];
      loclng = location.data()?['lng'];
      local = location.data()?['locality'];
      cartime = location.data()?['CarTime'];
      traintime = location.data()?['TrainTime'];
    }
  }

  // fetching current position
  Future fetchCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    await Geolocator.getCurrentPosition().then((value) async {
      try {
        List<Placemark> placeMarks = await placemarkFromCoordinates(value.latitude, value.longitude);
        lat = value.latitude;
        long = value.longitude;

        Placemark place = placeMarks[0];

        currentPosition = value;
        currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
        double distancemeter = 0.0;
        // double storelat = 26.2593607;
        // double storelng = 72.9795197;

        distancemeter =
            await Geolocator.distanceBetween(currentPosition!.latitude, currentPosition!.longitude, currentPosition!.longitude, currentPosition!.latitude);
        distance = distancemeter?.round().toInt();
        var dis = (distance! / 100);
        locality = place.locality!;
        postalCode = place.postalCode!;
        country = place.country!;
        log(currentAddress);
        log(lat.toString());
        log(value.longitude.toString());
        loclat = lat.toString();
        loclng = value.longitude.toString();
        locadd = currentAddress;
        local = place.locality!;
        cartime = dis / 150;
        traintime = dis / 300;
        notifyListeners();
        //return currentAddress ;
      } catch (e) {
        log(e.toString());
      }
    });
    notifyListeners();
  }

  // fetching latitude and longitude
  List<Location> newLatLongList = [];

  Future<List<Location>> getLatLong(BuildContext context, String address) async {
    await locationFromAddress(address).then((value) async {
      //newLatLongList.clear();
      for (var data in value) {
        newLatLongList.add(data);
        log(newLatLongList.toString());
        lat = newLatLongList.first.latitude;
        long = newLatLongList.first.longitude;
        getAddressFromLatLng(newLatLongList.first.latitude, newLatLongList.first.longitude).then((value) {
          currentAddress = value!;
        });
      }
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
      Navigator.pop(context);
    });

    notifyListeners();
    return newLatLongList;
  }

  // fetching address from latitude and longitude
  static const String _mapApiKey = "AIzaSyBtvEIVojiFHFC62dxHdpaCL5r5VFotq9s";

  Future<String?> getAddressFromLatLng(double lat, double lng) async {
    String host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$host?key=$_mapApiKey&language=en&latlng=$lat,$lng';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      String formattedAddress = data["results"][0]["formatted_address"];
      log("response ==== $formattedAddress");
      currentAddress = formattedAddress;
      //return currentAddress;
    } else {
      return null;
    }
  }

  // delete user location
  Future<void> deleteLocations(List<dynamic> list) async {
    await FirebaseFirestore.instance.collection("festivals").doc(FirebaseAuth.instance.currentUser!.uid.substring(0, 20)).update({"address": list});
    notifyListeners();
  }
}
