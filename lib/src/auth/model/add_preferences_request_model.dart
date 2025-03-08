class AddPreferencesRequestModel {
  String? userId;
  List<String>? styles;
  List<String>? bodyTypes;
  List<String>? fitPreference;

  AddPreferencesRequestModel({
    this.userId,
    this.styles,
    this.bodyTypes,
    this.fitPreference,
  });

  AddPreferencesRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    styles = json['styles'].cast<String>();
    bodyTypes = json['bodyTypes'].cast<String>();
    fitPreference = json['fitPrefrence'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    if ((styles ?? []).isNotEmpty) {
      data['styles'] = styles;
    }
    if ((bodyTypes ?? []).isNotEmpty) {
      data['bodyTypes'] = bodyTypes;
    }
    if ((fitPreference ?? []).isNotEmpty) {
      data['fitPrefrence'] = fitPreference;
    }
    return data;
  }
}
