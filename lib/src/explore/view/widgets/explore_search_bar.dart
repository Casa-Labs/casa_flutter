import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/common/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExploreSearchBar extends StatelessWidget {
  const ExploreSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 20),
        Expanded(
          child: SizedBox(
            height: 40,
            child: CustomSearchBar(
              onTap: () {
                context.pushNamed(RouteNames.searchView);
              },
            ),
            // child: TextFormField(
            //   // textAlign: TextAlign.center,
            //   decoration: InputDecoration(
            //     hintText: 'Search',
            //     hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(),
            //     prefixIcon: Icon(
            //       Icons.search,
            //       size: 15,
            //     ),
            //     fillColor: TextFieldColor.offWhite,
            //     filled: true,
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(100),
            //       borderSide: BorderSide.none,
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(100),
            //       borderSide: BorderSide.none,
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(100),
            //       borderSide: BorderSide.none,
            //     ),
            //   ),
            //   onTap: () {
            //     context.pushNamed(RouteNames.searchView);
            //   },
            // ),
          ),
        ),
        SizedBox(width: 20),
        // IconButton(
        //     onPressed: () {
        //       context.pushNamed(RouteNames.search);
        //     },
        //     iconSize: 20,
        //     icon: Icon(Icons.tune))
      ],
    );
  }
}
