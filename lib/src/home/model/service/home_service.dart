import '../../../../network/graph_ql_manager.dart';
import '../../../../utils/utils.dart';
import '../add_review_model.dart';
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

  Future<AddReviewModel?> registerProductReview({
    required AddReviewRequestModel addReviewRRequestModel,
  }) async {
    final AddReviewModel addReviewModel;

    final response = await _graphQLManager.registerProductReview(
      productId: addReviewRRequestModel.productId,
      userId: addReviewRRequestModel.userId,
      liked: addReviewRRequestModel.liked,
      disliked: addReviewRRequestModel.disliked,
      viewed: addReviewRRequestModel.viewed,
      rating: addReviewRRequestModel.rating,
      comment: addReviewRRequestModel.comment,
    );

    addReviewModel = AddReviewModel.fromJson(
      response.data!,
    );

    logg.d(response.data!);

    return addReviewModel;
  }
}
