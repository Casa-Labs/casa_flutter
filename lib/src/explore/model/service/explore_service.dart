import 'package:casa_flutter/src/explore/model/explore_models.dart';
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
      logg.e(
          'Get trending products : ${trendingProductsResponse.data!.getTrendingProducts!.totalCount}');
    } else {
      logg.e('Get trending products Exception: ${response.exception}');
    }
  }
}
