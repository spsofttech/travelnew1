class prima_spot_get_model {
  int? status;
  Data? data;
  String? message;

  prima_spot_get_model({this.status, this.data, this.message});

  prima_spot_get_model.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? state;
  String? city;
  String? type;
  List<TouristSpot>? touristSpot;

  Data({this.id, this.state, this.city, this.type, this.touristSpot});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
    city = json['city'];
    type = json['type'];
    if (json['tourist_spot'] != null) {
      touristSpot = <TouristSpot>[];
      json['tourist_spot'].forEach((v) {
        touristSpot!.add(new TouristSpot.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    data['city'] = this.city;
    data['type'] = this.type;
    if (this.touristSpot != null) {
      data['tourist_spot'] = this.touristSpot!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TouristSpot {
  int? id;
  String? state;
  String? city;
  String? touristSpot;
  String? touristSpotId;
  String? address;
  String? latitude;
  String? longitude;
  String? rank;
  String? type1;
  String? type2;
  String? interest1;
  String? interest2;
  String? timeSpend;
  String? description;
  String? image;

  TouristSpot(
      {this.id,
        this.state,
        this.city,
        this.touristSpot,
        this.touristSpotId,
        this.address,
        this.latitude,
        this.longitude,
        this.rank,
        this.type1,
        this.type2,
        this.interest1,
        this.interest2,
        this.timeSpend,
        this.description,
        this.image});

  TouristSpot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
    city = json['city'];
    touristSpot = json['tourist_spot'];
    touristSpotId = json['tourist_spot_id'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    rank = json['rank'];
    type1 = json['type1'];
    type2 = json['type2'];
    interest1 = json['interest1'];
    interest2 = json['interest2'];
    timeSpend = json['time_spend'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    data['city'] = this.city;
    data['tourist_spot'] = this.touristSpot;
    data['tourist_spot_id'] = this.touristSpotId;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['rank'] = this.rank;
    data['type1'] = this.type1;
    data['type2'] = this.type2;
    data['interest1'] = this.interest1;
    data['interest2'] = this.interest2;
    data['time_spend'] = this.timeSpend;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
