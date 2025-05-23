class GetColorResponseModel {
  List<GetColors>? getColors;

  GetColorResponseModel({this.getColors});

  GetColorResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['getColors'] != null) {
      getColors = <GetColors>[];
      json['getColors'].forEach((v) {
        getColors!.add(new GetColors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getColors != null) {
      data['getColors'] = this.getColors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetColors {
  String? id;
  String? name;

  GetColors({this.id, this.name});

  GetColors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
