import 'package:casa_flutter/src/common/widgets/common_app_bars.dart';
import 'package:casa_flutter/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/preference_manager.dart';
import '../widgets/address_display_box.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String shopFor = "women";
  String buyFrom = "Brands";
  String categories = "Shirt";
  String style = "Casual";

  List<BottomRadio> shopForList = [
    BottomRadio(name: "Women", slug: "women", isSelected: true),
    BottomRadio(name: "Men", slug: "men"),
    BottomRadio(name: "Both", slug: "both"),
  ];
  List<BottomRadio> buyFromList = [
    BottomRadio(name: "Brands", slug: "brands", isSelected: true),
    BottomRadio(name: "Thrift shores", slug: "thrift_shores"),
  ];
  List<BottomRadio> categoriesList = [
    BottomRadio(name: "Shirt", slug: "shirt", isSelected: true),
    BottomRadio(name: "Pents", slug: "pents"),
    BottomRadio(name: "Sportswear", slug: "sportswear"),
    BottomRadio(name: "Formal", slug: "formal"),
    BottomRadio(name: "Casual", slug: "casual"),
  ];
  List<BottomRadio> styleList = [
    BottomRadio(name: "Casual", slug: "casual", isSelected: true),
    BottomRadio(name: "Formal", slug: "formal"),
    BottomRadio(name: "Boho", slug: "boho"),
    BottomRadio(name: "Chic", slug: "chic"),
    BottomRadio(name: "Preppy", slug: "preppy"),
    BottomRadio(name: "Sporty", slug: "sporty"),
    BottomRadio(name: "Retro", slug: "retro"),
    BottomRadio(name: "Western", slug: "western"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: 'Narrow your search',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _materialWidget(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Would you like to shop for?',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 5),
                    _optionSection(shopFor, () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return BrandSelection(
                            titel: "Would you like to shop for?",
                            onTap: (p0, p1) {
                              for (var listData in shopForList) {
                                listData.isSelected = false;
                              }
                              shopForList[p1].isSelected = true;
                              shopFor = shopForList[p1].name;
                              setState(() {});
                            },
                            radioList: shopForList,
                            brandSelection: shopFor,
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _materialWidget(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Where would you like to buy from?',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 5),
                    _optionSection(buyFrom, () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return BrandSelection(
                            titel: "Where would you like to buy from?",
                            onTap: (p0, p1) {
                              for (var listData in buyFromList) {
                                listData.isSelected = false;
                              }
                              buyFromList[p1].isSelected = true;
                              buyFrom = buyFromList[p1].name;
                              setState(() {});
                            },
                            radioList: buyFromList,
                            brandSelection: buyFrom,
                          );
                        },
                      );
                    }),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Categories',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 5),
                    _optionSection(categories, () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return BrandSelection(
                            titel: "Select Categories",
                            onTap: (p0, p1) {
                              for (var listData in categoriesList) {
                                listData.isSelected = false;
                              }
                              categoriesList[p1].isSelected = true;
                              categories = categoriesList[p1].name;
                              setState(() {});
                            },
                            radioList: categoriesList,
                            brandSelection: categories,
                          );
                        },
                      );
                    }),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Style preferences',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 5),
                    _optionSection(style, () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return BrandSelection(
                            titel: "Style preferences",
                            onTap: (p0, p1) {
                              styleList[p1].isSelected =
                                  !styleList[p1].isSelected;
                              List<String> list = [];
                              for (var data in styleList) {
                                if (data.isSelected) {
                                  list.add(data.name);
                                }
                              }
                              String name = list.join(", ");
                              style = name;
                              setState(() {});
                            },
                            radioList: styleList,
                            brandSelection: style,
                            isGrid: true,
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Divider(color: DividerColor.grey),
              const SizedBox(height: 20),
              AddressDisplayBox(
                address: PreferenceManager.getString(PreferenceManager.keyAddress) ?? "",
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: _materialWidget(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Method?',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.black54,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _optionSection(String text, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFFC8C4C4))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              color: Colors.black54,
            )
          ],
        ),
      ),
    );
  }

  Widget _materialWidget(Widget data) {
    return Material(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFC8C4C4), width: 0.3)),
        child: Padding(padding: const EdgeInsets.all(8.0), child: data),
      ),
    );
  }
}

class FilterGender extends StatefulWidget {
  const FilterGender({super.key});

  @override
  State<FilterGender> createState() => _FilterGenderState();
}

class _FilterGenderState extends State<FilterGender> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    Get.back();
                  },
                ),
                const SizedBox(width: 60),
                Text(
                  'Would like to shop for?',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 20),
            RadioListTile<String>(
              value: 'Male',
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
                Get.back();
              },
              title: Text(
                'Male',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            RadioListTile<String>(
              value: 'Female',
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
                Get.back();
              },
              title: Text(
                'Female',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            RadioListTile<String>(
              value: 'Others',
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
                Get.back();
              },
              title: Text(
                'Both',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BrandSelection extends StatefulWidget {
  const BrandSelection(
      {super.key,
      this.brandSelection,
      required this.radioList,
      required this.onTap,
      required this.titel,
      this.isGrid = false});

  final String? brandSelection;
  final String titel;
  final bool isGrid;
  final List<BottomRadio> radioList;
  final Function(String, int) onTap;

  @override
  State<BrandSelection> createState() => _BrandSelectionState();
}

class _BrandSelectionState extends State<BrandSelection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.01,
                  child: InkWell(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 20)),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    widget.titel,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return !widget.isGrid
                ? ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: widget.radioList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var listData = widget.radioList[index];
                      return InkWell(
                        overlayColor:
                            WidgetStateProperty.all(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          widget.onTap(listData.slug, index);
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              listData.isSelected
                                  ? Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      padding: const EdgeInsets.all(3),
                                      height: 23,
                                      width: 23,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.black,
                                          border: Border.all(
                                              color: Colors.black, width: 2)),
                                      child: Icon(
                                        Icons.check,
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      width: 23,
                                      height: 23,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      )),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                listData.name,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        height: 1,
                        color: Colors.grey.shade300,
                      );
                    },
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3,
                            mainAxisSpacing: 25,
                            crossAxisSpacing: 10,
                            crossAxisCount: 3),
                    itemCount: widget.radioList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < widget.radioList.length) {
                        var listData = widget.radioList[index];
                        return InkWell(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {
                            widget.onTap(listData.slug, index);
                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: listData.isSelected
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              listData.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: listData.isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 11,
                                  ),
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Icon(Icons.add, color: Colors.grey)),
                        );
                      }
                    },
                  );
          }),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class BottomRadio {
  String name;
  bool isSelected;
  String slug;

  BottomRadio(
      {required this.name, this.isSelected = false, required this.slug});
}
