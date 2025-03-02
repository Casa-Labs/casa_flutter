import 'dart:convert';

extension ModelExtensions on dynamic {
  String toJsonString() {
    final jsonString = jsonEncode(this.toJson());
    return jsonString;
  }

//  Model myModel = ModelExtensions.fromJsonString<Model>(json);
  static T fromJsonString<T>(String jsonString) {
    final jsonData = jsonDecode(jsonString);
    if (T is Map) {
      return _fromJson<T>(jsonData);
    } else {
      throw Exception('Invalid type. Expected Map.');
    }
  }

  static T _fromJson<T>(Map<String, dynamic> json) {
    if (T == dynamic) {
      return json as T;
    } else if (T == String) {
      return json.toString() as T;
    } else {
      throw Exception('Unsupported type.');
    }
  }
}
