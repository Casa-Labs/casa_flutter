import 'package:casa_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class Address {
  final String label;
  final String address;

  Address({required this.label, required this.address});

  IconData get icon {
    switch (label.toLowerCase()) {
      case 'home':
        return Icons.home;
      case 'work':
        return Icons.work;
      default:
        return Icons.location_on;
    }
  }
}

class AddressDisplayBox extends StatelessWidget {
  final String address;

  const AddressDisplayBox({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section with title and navigation button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add new address',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                onPressed: () {
                  context.pushNamed(RouteNames.location);
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          address.isNotEmpty ?Text(
            address,
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium,
            softWrap: true,
          ):SizedBox(),
        ],
      ),
    );
  }
}
