import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/preference_manager.dart';

class ChangeAddress extends StatefulWidget {
  const ChangeAddress({super.key});

  @override
  State<ChangeAddress> createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var address =
        PreferenceManager.getString(PreferenceManager.keyAddress) ?? "";
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Use current address",
            style: textTheme.bodyLarge?.copyWith(color: Colors.black),
          ),
          InkWell(
            onTap: () {
              context.pop();
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 0.3),
              ),
              child: address.isNotEmpty
                  ? Text(
                      address,
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                    )
                  : SizedBox(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "or",
              style: textTheme.bodyMedium?.copyWith(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              color: ButtonColor.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                  surfaceTintColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  context
                      .pushNamed(RouteNames.location)
                      .then((value) => context.pop());
                },
                child: Text(
                  "Change address",
                  style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ).paddingSymmetric(horizontal: 10)),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
