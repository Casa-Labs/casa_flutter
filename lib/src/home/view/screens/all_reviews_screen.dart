import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/color_constant.dart';
import '../../controller/home_controller.dart';
import '../../model/review_response.dart';

class AllReviewsScreen extends StatelessWidget {
  final String productId;
  final String productName;

  const AllReviewsScreen({
    super.key,
    required this.productId,
    required this.productName,
  });

  String _formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reviews for $productName',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (logic) {
          return FutureBuilder<GetProductReviewModel?>(
            future: logic.getReviews(productId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error loading reviews: ${snapshot.error}'),
                );
              }

              final reviews = snapshot.data?.getProductInteractions ?? [];

              if (reviews.isEmpty) {
                return const Center(
                  child: Text('No reviews yet'),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            border: Border.all(color: ButtonColor.black),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: CircleAvatar(
                            maxRadius: 28,
                            backgroundColor: const Color(0xFF002957),
                            child: Text(
                              review.user?.name
                                      ?.substring(0, 1)
                                      .toUpperCase() ??
                                  "U",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: TextColor.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.user?.name ?? 'Anonymous',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  ...List.generate(
                                    5,
                                    (i) => Icon(
                                      Icons.star,
                                      size: 16,
                                      color: i < (review.rating ?? 0)
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${review.rating ?? 0}/5',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              if (review.comment != null &&
                                  review.comment!.isNotEmpty) ...[
                                const SizedBox(height: 5),
                                Text(
                                  review.comment!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                              const SizedBox(height: 5),
                              Text(
                                _formatDate(review.createdAt),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
