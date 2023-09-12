class create_new_Trip_send_model {
  String? bookingId;
  String? date="";
  int? days;
  int? adult;
  int? children;
  String? hotelType;
  String? includes="";
  String? searchedId;

  create_new_Trip_send_model(
      {this.bookingId,
        this.date,
        this.days,
        this.adult,
        this.children,
        this.hotelType,
        this.includes,
        this.searchedId});

  create_new_Trip_send_model.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    date = json['date'];
    days = json['days'];
    adult = json['adult'];
    children = json['children'];
    hotelType = json['hotel_type'];
    includes = json['includes'];
    searchedId = json['searched_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['date'] = this.date;
    data['days'] = this.days;
    data['adult'] = this.adult;
    data['children'] = this.children;
    data['hotel_type'] = this.hotelType;
    data['includes'] = this.includes;
    data['searched_id'] = this.searchedId;
    return data;
  }
}
