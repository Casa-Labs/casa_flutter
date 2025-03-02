class ChipListModel {
  final int id;
  final String name;
  final bool isSelected;

  const ChipListModel({
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  ChipListModel copyWith({
    int? id,
    String? name,
    bool? isSelected,
  }) {
    return ChipListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
