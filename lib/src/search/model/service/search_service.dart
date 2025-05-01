import 'package:casaflutterapp/network/graph_ql_manager.dart';
import 'package:casaflutterapp/src/search/controller/search_view_controller.dart';
import 'package:casaflutterapp/src/search/model/search_models.dart';
import 'package:casaflutterapp/utils/utils.dart';
import 'package:get/get.dart';

class SearchService {
  final searchViewCtrl = Get.find<SearchViewController>();

  Future<void> searchProducts({required String searchText}) async {
    var response =
        await GraphQLManager().getProductsForSearch({"search": searchText});

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
