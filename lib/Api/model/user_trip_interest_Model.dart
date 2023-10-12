class User_Trip_Interest_Model {
  int? status;
  List<Data>? data;
  String? message;

  User_Trip_Interest_Model({this.status, this.data, this.message});

  User_Trip_Interest_Model.fromJson(Map<String, dynamic> json) {
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
  int? categoryId;
  String? category;
  List<Interest>? interest;

  Data({this.categoryId, this.category, this.interest});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    category = json['category'];
    if (json['interest'] != null) {
      interest = <Interest>[];
      json['interest'].forEach((v) {
        interest!.add(new Interest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category'] = this.category;
    if (this.interest != null) {
      data['interest'] = this.interest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Interest {
  int? id;
  String? category;
  String? name;

  Interest({this.id, this.category, this.name});

  Interest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['name'] = this.name;
    return data;
  }
}
