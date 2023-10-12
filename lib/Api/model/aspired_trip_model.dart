class aspire_trip_get_model {
  int? status;
  List<Data>? data;
  String? message;

  aspire_trip_get_model({this.status, this.data, this.message});

  aspire_trip_get_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? tripId;
  String? tripName;
  int? category;
  int? travelAgent;
  int? tripCity;
  String? startDate;
  String? endDate;
  String? image;
  String? organizedBy;
  String? includes;
  String? homeLocation;
  String? tripExperience;
  String? description;
  String? highlight;

  Data(
      {this.tripId,
        this.tripName,
        this.category,
        this.travelAgent,
        this.tripCity,
        this.startDate,
        this.endDate,
        this.image,
        this.organizedBy,
        this.includes,
        this.homeLocation,
        this.tripExperience,
        this.description,
        this.highlight});

  Data.fromJson(Map<String, dynamic> json) {
    tripId = json['trip_id'];
    tripName = json['trip_name'];
    category = json['category'];
    travelAgent = json['travel_agent'];
    tripCity = json['trip_city'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    image = json['image'];
    organizedBy = json['organized_by'];
    includes = json['includes'];
    homeLocation = json['home_location'];
    tripExperience = json['trip_experience'];
    description = json['description'];
    highlight = json['highlight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trip_id'] = this.tripId;
    data['trip_name'] = this.tripName;
    data['category'] = this.category;
    data['travel_agent'] = this.travelAgent;
    data['trip_city'] = this.tripCity;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['image'] = this.image;
    data['organized_by'] = this.organizedBy;
    data['includes'] = this.includes;
    data['home_location'] = this.homeLocation;
    data['trip_experience'] = this.tripExperience;
    data['description'] = this.description;
    data['highlight'] = this.highlight;
    return data;
  }
}
