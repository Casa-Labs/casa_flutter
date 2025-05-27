import 'package:get/get.dart';

class FilterController extends GetxController {
  RxMap<String, List<String>> filters = <String, List<String>>{}.obs;

  void updateFilter(String key, List<String> selectedIds) {
    filters[key] = selectedIds;
  }

  void clearFilter(String key) {
    filters.remove(key);
  }

  List<String> getFilter(String key) {
    return filters[key] ?? [];
  }

  Map<String, dynamic> getCleanFilters() {
    final clean = <String, dynamic>{};
    filters.forEach((key, value) {
      if (value.isNotEmpty) clean[key] = value;
    });
    return clean;
  }
}
