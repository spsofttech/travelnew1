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