



class create_trip_send_model {
  String? category;
  int? state;
  int? days;
  String? travelMode;
  int? userId;

  create_trip_send_model(
      {this.category, this.state, this.days, this.travelMode, this.userId});

  create_trip_send_model.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    state = json['state'];
    days = json['days'];
    travelMode = json['travel_mode'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['state'] = this.state;
    data['days'] = this.days;
    data['travel_mode'] = this.travelMode;
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
  int? userId;
  int? state;
  String? category;
  int? tripId;
  int? days;
  String? travelMode;

  Data(
      {this.userId,
        this.state,
        this.category,
        this.tripId,
        this.days,
        this.travelMode});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    state = json['state'];
    category = json['category'];
    tripId = json['trip_id'];
    days = json['days'];
    travelMode = json['travel_mode'];
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


