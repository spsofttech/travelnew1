



class create_trip_send_model {
  String? category;
  String? state;
  String? days;
  String? travelMode;
  String? userId;

  create_trip_send_model(
      {this.category, this.state, this.days, this.travelMode, this.userId});

  // create_trip_send_model.fromJson(Map<String, dynamic> json) {
  //   category = json['category'];
  //   state = json['state'];
  //   days = json['days'];
  //   travelMode = json['travel_mode'];
  //   userId = json['user_id'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['state'] = this.state;
    data['days'] = this.days;
    data['travel_mode'] = this.travelMode!.toLowerCase();
    data['user_id'] = this.userId;
    return data;
  }
}

class create_trip_get_model {
  int? status;
  Data? data;
  String? message;

  create_trip_get_model({this.status, this.data, this.message});

  create_trip_get_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }

}

class Data {
  String? userId;
  String? state;
  String? category;
  String? tripId;
  String? days;
  String? travelMode;

  Data(
      {this.userId,
        this.state,
        this.category,
        this.tripId,
        this.days,
        this.travelMode});

  Data.fromJson(Map<String, dynamic> json) {
   // print("\n${json['trip_id']}");
    userId = json['user_id'].toString();
    //print("\n${json['user_id']}");
    state = json['state'].toString();
    //print("\n${json['state']}");
    category = json['category'].toString();
    //print("\n${json['category']}");
    tripId = json['trip_id'].toString();

    days = json['days'].toString();
    //print("\n${json['days']}");
    travelMode = json['travel_mode'].toString();
    // print("\n${json['travel_mode']}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['state'] = this.state;
    data['category'] = this.category;
    data['trip_id'] = this.tripId;
    data['days'] = this.days;
    data['travel_mode'] = this.travelMode;
    return data;
  }
}

class TravelNew_Category_get_model {
  int? status;
  List<Data1>? data;
  String? message;

  TravelNew_Category_get_model({this.status, this.data, this.message});

  TravelNew_Category_get_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data1>[];
      json['data'].forEach((v) {
        data!.add(new Data1.fromJson(v));
      });
    }
    message = json['message'];
  }


  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }

}

class Data1 {
  String? type;
  String? category;

  Data1({this.type, this.category});

  Data1.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['category'] = this.category;
    return data;
  }
}



class TravelNew_StateDropdown_get_model {
  int? status;
  List<Data2>? data;
  String? message;

  TravelNew_StateDropdown_get_model({this.status, this.data, this.message});

  TravelNew_StateDropdown_get_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data2>[];
      json['data'].forEach((v) {
        data!.add(new Data2.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data2 {
  int? stateId;
  String? state;

  Data2({this.stateId, this.state});

  Data2.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = this.stateId;
    data['state'] = this.state;
    return data;
  }
}

class TripCity_get_model {
  int? status;
  List<Data3>? data;
  String? message;

  TripCity_get_model({this.status, this.data, this.message});

  TripCity_get_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data3>[];
      json['data'].forEach((v) {
        data!.add(new Data3.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data3 {
  int? cityId;
  int? stateId;
  String? state;
  String? city;
  String? rank;
  String? railway;
  String? airport;
  String? latitude;
  String? longitude;
  String? image;

  Data3(
      {this.cityId,
        this.stateId,
        this.state,
        this.city,
        this.rank,
        this.railway,
        this.airport,
        this.latitude,
        this.longitude,
        this.image});

  Data3.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    stateId = json['state_id'];
    state = json['state'];
    city = json['city'];
    rank = json['rank'];
    railway = json['railway'];
    airport = json['airport'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['state_id'] = this.stateId;
    data['state'] = this.state;
    data['city'] = this.city;
    data['rank'] = this.rank;
    data['railway'] = this.railway;
    data['airport'] = this.airport;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['image'] = this.image;
    return data;
  }
}



