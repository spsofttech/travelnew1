class DayTripModel {
  List<DayTripData> data;
  DayTripModel({required this.data});
  factory DayTripModel.fromJson(data) {
    return DayTripModel(data: [DayTripData.fromJson(data)]);
  }
}

class DayTripData {
  String? address;
  String? image;
  String? description;
  String? intrest1;
  String? intrest2;
  String? latitude;
  String? longitude;
  String? rank;
  String? state;
  String? timeSpend;
  String? touristSpot;
  String? tripCity;
  String? type1;
  String? type2;
  String? destination;
  String? tourist_spot_id;

  DayTripData(
      {this.address,
      this.image,
      this.latitude,
      this.type2,
      this.longitude,
      this.destination,
      this.description,
      this.type1,
      this.tourist_spot_id,
      this.touristSpot,
      this.intrest1,
      this.intrest2,
      this.rank,
      this.tripCity,
      this.state,
      this.timeSpend});

  DayTripData.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    image = json['image'];
    latitude = json['latitude'];
    type2 = json['type2'];
    longitude = json['longitude'];
    description = json['description'];
    type1 = json['type1'];
    tourist_spot_id = json['tourist_spot_id'];
    touristSpot = json['tourist_spot'];
    intrest1 = json['interest1'];
    intrest2 = json['interest2'];
    rank = json['rank'];
    tripCity = json['trip_city'];
    state = json['state'];
    timeSpend = json['time_spend'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['address'] = this.address;
  //   data['image'] = this.image;
  //   data['city_lat'] = this.latitude;
  //   data['type2'] = this.type2;
  //   data['longitude'] = this.longitude;
  //   data['nearest_railway'] = this.nearestRailway;
  //   data['column2'] = this.column2;
  //   data['destination'] = this.destination;
  //   data['description'] = this.description;
  //   data['type1'] = this.type1;
  //   data['distance_from_city_centre'] = this.tourist_spot_id;
  //   data['tourist_spot'] = this.touristSpot;
  //   data['trip_interest1'] = this.intrest1;
  //   data['trip_interest3'] = this.tripInterest3;
  //   data['trip_interest2'] = this.intrest2;
  //   data['rank'] = this.rank;
  //   data['trip_city'] = this.tripCity;
  //   data['state'] = this.state;
  //   data['city_long'] = this.cityLong;
  //   data['day'] = this.day;
  //   data['time_spend'] = this.timeSpend;
  //   return data;
  // }
}
