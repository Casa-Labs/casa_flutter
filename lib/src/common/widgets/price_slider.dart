import 'package:flutter/material.dart';

class PriceRangeSlider extends StatefulWidget {
  final double min;
  final double max;
  final Function(double, double) onChanged;

  const PriceRangeSlider({
    super.key,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = RangeValues(widget.min, widget.max);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(height: 20),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 1,
          ),
          child: RangeSlider(
            values: _currentRangeValues,
            min: widget.min,
            max: widget.max,
            // divisions: 100,
            activeColor: Colors.black,
            inactiveColor: Colors.grey[300],
            labels: RangeLabels(
              _currentRangeValues.start.toString(),
              _currentRangeValues.end.toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
                widget.onChanged(values.start, values.end);
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '₹ ${_currentRangeValues.start.toStringAsFixed(0)}',
              style: textTheme.bodyMedium,
            ),
            Text(
              '₹ ${_currentRangeValues.end.toStringAsFixed(0)}',
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}