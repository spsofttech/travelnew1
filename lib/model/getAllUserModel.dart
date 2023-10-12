class UserFriend_details_Get_model {
  int? status;
  List<Data>? data;
  String? nextPage;
  String? message;

  UserFriend_details_Get_model(
      {this.status, this.data, this.nextPage, this.message});

  UserFriend_details_Get_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    nextPage = json['next_page'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['next_page'] = this.nextPage;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? userId;
  String? name;
  String? birthDate;
  String? email;
  String? password;
  String? friends;
  String? travelInvites;

  Data(
      {this.userId,
        this.name,
        this.birthDate,
        this.email,
        this.password,
        this.friends,
        this.travelInvites});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    birthDate = json['birth_date'];
    email = json['email'];
    password = json['password'];
    friends = json['friends'];
    travelInvites = json['travel_invites'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['birth_date'] = this.birthDate;
    data['email'] = this.email;
    data['password'] = this.password;
    data['friends'] = this.friends;
    data['travel_invites'] = this.travelInvites;
    return data;
  }
}
