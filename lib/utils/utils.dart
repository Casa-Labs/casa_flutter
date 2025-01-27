import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

Logger logg = Logger(); // use this instead print
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
