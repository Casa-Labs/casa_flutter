class AddPreferencesResponseModel {
  AddPreferences? addPreferences;

  AddPreferencesResponseModel({
    this.addPreferences,
  });

  AddPreferencesResponseModel.fromJson(Map<String, dynamic>? json) {
    addPreferences = json?['addPreferences'] != null
        ? AddPreferences.fromJson(json?['addPreferences'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addPreferences != null) {
      data['addPreferences'] = addPreferences!.toJson();
    }
    return data;
  }
}

class AddPreferences {
  String? id;
  String? userId;

  AddPreferences({
    this.id,
    this.userId,
  });

  AddPreferences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    return data;
  }
}
