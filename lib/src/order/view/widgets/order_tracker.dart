import 'package:flutter/material.dart';


class OrderTracker extends StatelessWidget {
  const OrderTracker({super.key, required this.statuses});
  final List<OrderTrackerModel> statuses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(statuses.length * 2 - 1, (index) {
                if (index % 2 == 0) {
                  final int statusIndex = index ~/ 2;
                  final isCompleted = statuses[statusIndex].isCompleted;

                  return Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: isCompleted ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                } else {
                  final int previousStatusIndex = (index - 1) ~/ 2;
                  final isPreviousCompleted =
                      statuses[previousStatusIndex].isCompleted;

                  final isCurrentCompleted =
                      statuses[previousStatusIndex + 1].isCompleted;
                  final isLineGreen = isPreviousCompleted && isCurrentCompleted;
                  return Expanded(
                    child: Container(
                      height: 1.5,
                      color: isLineGreen ? Colors.green : Colors.grey,
                    ),
                  );
                }
              }),
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: statuses.map((status) {
              return Text(
                status.status,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                      // Center-align text
                    ),
                softWrap: true, // Allow wrapping
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class OrderTrackerModel {
  String status;
  bool isCompleted;
  OrderTrackerModel({required this.status, this.isCompleted = false});
}
