import 'package:casaflutterapp/src/home/controller/home_controller.dart';
import 'package:get/get.dart';

import '../../../../network/graph_ql_manager.dart';
import '../review_response.dart';

class HomeService {

  final GraphQLManager _graphQLManager = GraphQLManager();

  Future<GetProductReviewModel?> getReview({
    required String productId,
  }) async {
    final GetProductReviewModel reviewResponse;

    final response = await _graphQLManager.getProductReviews(productId);

    reviewResponse = GetProductReviewModel.fromJson(
      response.data!,
    );

      return reviewResponse;
  }

}
