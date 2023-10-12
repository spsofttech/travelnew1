// class StateCatGetDataModel {
//   List<StateCatGetModel> data;
//   StateCatGetDataModel({required this.data});
//   factory StateCatGetDataModel.fromJson(data) {
//     return StateCatGetDataModel(data: [StateCatGetModel.fromJson(data)]);
//   }
// }

class StateCatGetModel {
  List<ColId>? colId;

  StateCatGetModel({this.colId});

  StateCatGetModel.fromJson(Map<String, dynamic> json) {
    // print(json['colID']);
    if (json['colID'] != null) {
      colId = <ColId>[];
      json['colID'].forEach((v) {
        colId!.add(ColId.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.colId != null) {
  //     data['colID'] = this.colId!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class ColId {
  String? category;
  String? city;
  String? id;
  List? interest;
  List? visibleTo;
  String? state;
  String? image;

  ColId({this.category, this.city, this.id, this.interest, this.visibleTo, this.state, this.image});

  ColId.fromJson(Map<String, dynamic> json) {
    // print("${json['category']}\n${json['city']}\n${json['id']}\n${json['interest']}\n${json['visible_to']}\n${json['state']}\n${"--" + json['image']}");
    category = json['category'];
    city = json['city'];
    id = json['id'];
    interest = json['interest'];
    visibleTo = json['visible_to'];
    state = json['state'];
    image = json['image'];

    // print("${category} \n${city} \n${id} \n${interest} \n${visibleTo} \n${state} \n${image} \n");
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['category'] = this.category;
  //   data['city'] = this.city;
  //   data['id'] = this.id;
  //   data['interest'] = this.interest;
  //   data['visible_to'] = this.visibleTo;
  //   data['state'] = this.state;
  //   return data;
  // }
}
