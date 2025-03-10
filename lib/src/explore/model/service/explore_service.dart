import 'package:casa_flutter/src/explore/model/trending_products_model.dart';
import 'package:get/get.dart';

import '../../../../network/graph_ql_manager.dart';
import '../../../../utils/utils.dart';
import '../../controller/explore_controller.dart';

class ExploreService {
  final exploreCtrl = Get.find<ExploreController>();

  Future<void> getTrendingNowProducts({String? search}) async {
    var response = await GraphQLManager()
        .getTrendingProducts(exploreCtrl.page(), exploreCtrl.limit(), search);

    if (!response.hasException && response.data != null) {
      final trendingProductsResponse =
          TrendingProductsResponseModel.fromJson(response.data!);
      exploreCtrl.trendingProducts.assignAll(
          trendingProductsResponse.getTrendingProducts?.products ?? []);
    } else {
      logg.e('Get trending products Exception: ${response.exception}');
    }
  }
}
