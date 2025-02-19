import 'package:casa_flutter/routes/app_routes.dart';
import 'package:casa_flutter/src/auth/view/widgets/auth_button.dart';
import 'package:casa_flutter/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/custom_text_form_field_widget.dart';

class SignUpDetailsScreen extends StatelessWidget {
  const SignUpDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Column(
                  children: [
                    Text(
                      'CASA',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      'Where your style journey begins',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Text(
                  'Personal Details',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('First Name'),
                    CustomTextFormField(),
                    SizedBox(height: 20),
                    Text('Last Name'),
                    CustomTextFormField(),
                    SizedBox(height: 20),
                    Text('Phone Number'),
                    CustomTextFormField(),
                    SizedBox(height: 30),
                  ],
                ),
                ChipList(
                  heading: 'Style Preferences',
                  items: [
                    'Casual',
                    'Formal',
                    'Boho',
                    'Chic',
                    'Preppy',
                    'Sporty',
                    'Retro',
                    'Western',
                  ],
                ),
                ChipList(
                  heading: 'Body Type',
                  items: [
                    'Hourglass',
                    'Pear',
                    'Apple',
                    'Athletic',
                    'Tall',
                    'Oval',
                    'Petite',
                  ],
                ),
                ChipList(
                  heading: 'Fit Preferences',
                  items: [
                    'Slim',
                    'Regular',
                    'Relaxed',
                    'Over sized',
                  ],
                ),
                Divider(color: DividerColor.grey),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Delivery Address',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text('Street Address'),
                    CustomTextFormField(),
                    SizedBox(height: 20),
                    Text('City'),
                    CustomTextFormField(),
                    SizedBox(height: 20),
                    Text('State'),
                    CustomTextFormField(),
                    SizedBox(height: 20),
                    Text('ZIP Code'),
                    CustomTextFormField(),
                    SizedBox(height: 30),
                  ],
                ),
                const SizedBox(height: 30),
                AuthButton(
                    type: AuthButtonType.start,
                    onPressed: () {
                      context.pushNamed(RouteNames.navigation);
                    }),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChipList extends StatelessWidget {
  final String heading;
  final List<String> items;

  const ChipList({
    super.key,
    required this.heading,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: DividerColor.grey),
        const SizedBox(height: 30),
        Center(
          child: Text(
            heading,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 20,
          runSpacing: 25,
          children: items
              .map((item) => Chip(
                    label: Text(item),
                  ))
              .toList(),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
