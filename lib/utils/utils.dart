import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

Logger logg = Logger(); // use this instead of print
/*
impl->(globally)

logg.e(message);
 */

void prettyPrintJson(String input) {
  const JsonDecoder decoder = JsonDecoder();
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final dynamic object = decoder.convert(input);
  final dynamic prettyString = encoder.convert(object);
  prettyString.split('\n').forEach((dynamic element) => debugPrint(element));
}

void prettyPrintMap(Map<dynamic, dynamic>? inputMap) {
  var encodedJson = jsonEncode(inputMap);
  const JsonDecoder decoder = JsonDecoder();
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final dynamic object = decoder.convert(encodedJson);
  final dynamic prettyString = encoder.convert(object);
  prettyString.split('\n').forEach((dynamic element) => debugPrint(element));
}

String formatListDate(List<int> listDate) {
  if (listDate.length != 3) {
    return "Invalid date";
  }
  try {
    int day = listDate[0];
    int month = listDate[1];
    int year = listDate[2];

    // Assuming year is a two-digit year, convert it to four digits
    year += (year < 100) ? 2000 : 0;

    // Create a DateTime object
    DateTime date = DateTime(year, month, day);

    // Format the date as "dd MMM yy"
    return DateFormat('dd MMM yy').format(date);
  } catch (e) {
    return "Invalid date";
  }
}

String formatDateToMonth(String dateString) {
  try {
    // Parse the date string into a DateTime object
    final date = DateFormat('dd-MM-yyyy').parse(dateString);

    // Format the date as "30 Jan 00"
    final formattedDate = DateFormat('dd MMM yy').format(date);

    return formattedDate;
  } catch (e) {
    // Handle parsing errors
    debugPrint('Error parsing date: $e');
    return 'Invalid date';
  }
}

String formatDateToYYYY(String dateString) {
  try {
    // Parse the date string into a DateTime object
    final date = DateFormat('dd-MM-yyyy').parse(dateString);

    // Format the date as "30 Jan 00"
    final formattedDate = DateFormat('dd MMM yyyy').format(date);

    return formattedDate;
  } catch (e) {
    // Handle parsing errors
    debugPrint('Error parsing date: $e');
    return 'Invalid date';
  }
}

String formatDateTimeForQueryParams(String dateTimeString) {
  try {
    // Decode any URL encoding in the string
    String decodedDateTime = Uri.decodeComponent(dateTimeString);

    // Parse the string into a DateTime object
    DateTime dateTime = DateTime.parse(decodedDateTime);

    // Format the DateTime into the desired format
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  } catch (e) {
    // Handle parsing errors
    throw FormatException("Invalid DateTime format: $dateTimeString");
  }
}

void showClosetBottomSheet(BuildContext context, Widget widget) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => widget,
  );
}

String multiplyAndFormatPrice(String price, int multiplier) {
  // Remove commas from the price string
  String cleanedPrice = price.replaceAll(',', '');
  String integerPart = cleanedPrice.split('.')[0];

  // Convert the cleaned price string to an integer
  int priceValue = int.parse(integerPart);

  // Multiply the price by the given multiplier
  int result = priceValue * multiplier;

  // Format the result with commas
  final formatter = NumberFormat.decimalPattern(
      'en_IN'); // 'en_IN' for Indian numbering system
  String formattedResult = formatter.format(result);

  return formattedResult;
  // return '';
}
