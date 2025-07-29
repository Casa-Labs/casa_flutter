import 'package:casaflutter/network/graph_ql_manager.dart';
import 'package:casaflutter/src/search/controller/search_view_controller.dart';
import 'package:casaflutter/src/search/model/search_models.dart';
import 'package:casaflutter/utils/utils.dart';
import 'package:get/get.dart';

class SearchService {
  final searchViewCtrl = Get.find<SearchViewController>();

  Future<void> searchProducts(Map<String, dynamic> params) async {
    var response =
        await GraphQLManager().getProductsForSearch(params);

    if (!response.hasException && response.data != null) {
      final productsResponse =
          SearchProductsResponseModel.fromJson(response.data!);
      searchViewCtrl.productsList
          .assignAll(productsResponse.getProducts?.data ?? []);
    } else {
      logg.e('Search clothes Exception: ${response.exception}');
    }
  }
}
