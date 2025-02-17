import 'package:casa_flutter/src/common/widgets/common_app_bars.dart';
import 'package:casa_flutter/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


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
      backgroundColor: BackgroundColor.white,
      appBar: CommonAppBar(
        title: 'Narrow your search',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _materialWidget(
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _text(
                    'Would you like to shop for?',
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
                  _text('Where would you like to buy from?'),
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
                  _text('Categories'),
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
                  _text('Style preferences'),
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
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _text('Location and payment methods'),
            ),
            const SizedBox(height: 8),
            _materialWidget(
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SetLocationPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _text('Add new location'),
                        const SizedBox(height: 5),
                        const Icon(
                          Icons.arrow_forward,
                          color: IconColor.black54,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // const Row(
                  //   children: [
                  //     Icon(Icons.location_on),
                  //     BodyText(
                  //       text: 'Location',
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w600,
                  //     )
                  //   ],
                  // ),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 5),
                      Expanded(
                        child: _text(
                          'A1-504 akal society jb nagar andheri east 4000049',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: _materialWidget(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _text('Payment Method?'),
                    const Icon(
                      Icons.arrow_forward,
                      color: IconColor.black54,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
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
                  _text(text),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              color: IconColor.black54,
            )
          ],
        ),
      ),
    );
  }

  Widget _text(String text, {double? fontSize}) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 16,
          ),
    );
  }

  Widget _materialWidget(Widget data) {
    return Material(
      elevation: 0,
      color: ButtonColor.white,
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
          color: ButtonColor.white,
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
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        // fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                )
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
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
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                )),
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
          color: BackgroundColor.white, borderRadius: BorderRadius.circular(20)),
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
                    child: Text(widget.titel,
                        style: Theme.of(context).textTheme.bodyLarge)),
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
                                          color: ButtonColor.black,
                                          border: Border.all(
                                              color: ButtonColor.black, width: 2)),
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
                                        color: ButtonColor.white,
                                        border: Border.all(
                                            color: ButtonColor.black, width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      )),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(listData.name,
                                  style: Theme.of(context).textTheme.bodyLarge)
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
                                  border: Border.all(color: ButtonColor.black),
                                  color: listData.isSelected
                                      ? ButtonColor.black
                                      : ButtonColor.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                listData.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: listData.isSelected
                                          ? TextColor.white
                                          : TextColor.black,
                                    ),
                              )),
                        );
                      } else {
                        return Center(
                          child: Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ButtonColor.grey, width: 2),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Icon(Icons.add, color: IconColor.grey)),
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

class SetLocationPage extends StatefulWidget {
  const SetLocationPage({super.key});

  @override
  State<SetLocationPage> createState() => _SetLocationPageState();
}

class _SetLocationPageState extends State<SetLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor.white,
      appBar: AppBar(
          scrolledUnderElevation: 0,
          leading: InkWell(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
            ),
          ),
          backgroundColor: BackgroundColor.white,
          title: Text(
            'Your Location',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          )
          // centerTitle: true,
          ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: ButtonColor.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey.shade600),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 12,
                          color: TextColor.black,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 14),
                          hintText: 'Search a new address',
                          hintStyle: TextStyle(
                              fontSize: 16, color: Colors.grey.shade500),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    InkWell(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      splashFactory: NoSplash.splashFactory,
                      onTap: () async {
                        // Constant.currentPosition =
                        //     await LocationHandler.getCurrentPosition();
                        // Constant.currentAddress =
                        //     await LocationHandler.getAddressFromLatLng(
                        //         Constant.currentPosition!);
                        Get.back();
                        setState(() {});
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.my_location_rounded,
                            color: IconColor.pinkAccent,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Current Location',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: IconColor.pinkAccent,
                                    ),
                              ),
                              Text(
                                'Using GPS',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: IconColor.pinkAccent.withOpacity(0.5),
                                      fontSize: 18,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Saved Location',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 20),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: 3,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: IconColor.deepPurple,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Home',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    'A1-504 akal society jb nagar andheri east 4000049',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: TextColor.grey,
                                          fontSize: 16,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              left: 40, top: 15, bottom: 15),
                          height: 0.5,
                          color: Colors.grey.shade400,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
