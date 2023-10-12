class prima_trip_publish_send_model {
  String? userId;
  String? startLocation;
  String? tripType;
  String? whereTo;
  String? travelBy;
  String? startDate;
  String? endDate;
  String? days;
  String? image;
  String? doingInTrip;
  String? tripSeen;
  String? memberType;
  String? maxMembers;
  String? distributed;
  String? tripMembers;

  prima_trip_publish_send_model(
      {this.userId,
        this.startLocation,
        this.tripType,
        this.whereTo,
        this.travelBy,
        this.startDate,
        this.endDate,
        this.days,
        this.image,
        this.doingInTrip,
        this.tripSeen,
        this.memberType,
        this.maxMembers,
        this.distributed,
        this.tripMembers});

  prima_trip_publish_send_model.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    startLocation = json['start_location'];
    tripType = json['trip_type'];
    whereTo = json['where_to'];
    travelBy = json['travel_by'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    days = json['days'];
    image = json['image'];
    doingInTrip = json['doing_in_trip'];
    tripSeen = json['trip_seen'];
    memberType = json['member_type'];
    maxMembers = json['max_members'];
    distributed = json['distributed'];
    tripMembers = json['trip_members'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['start_location'] = this.startLocation;
    data['trip_type'] = this.tripType;
    data['where_to'] = this.whereTo;
    data['travel_by'] = this.travelBy;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['days'] = this.days;
    data['image'] = this.image;
    data['doing_in_trip'] = this.doingInTrip;
    data['trip_seen'] = this.tripSeen;
    data['member_type'] = this.memberType;
    data['max_members'] = this.maxMembers;
    data['distributed'] = this.distributed;
    data['trip_members'] = this.tripMembers;
    return data;
  }
}
