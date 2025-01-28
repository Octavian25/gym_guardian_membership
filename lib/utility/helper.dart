import 'dart:math';

import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';

String getDateOnly(DateTime datetime) {
  return datetime.toIso8601String().split("T")[0];
}

String formatDate(DateTime inputDate) {
  try {
    // Format the date according to the locale
    String formattedDate = DateFormat('d MMMM yyyy').format(inputDate);
    return formattedDate;
  } catch (e) {
    // Handle the exception gracefully if the input is invalid
    debugPrint('Error parsing date: $e');
    return 'Invalid date format'; // Or return a more informative error message.
  }
}

String formatDateWithTime(DateTime inputDate) {
  try {
    // Format the date according to the locale
    String formattedDate = DateFormat('d MMMM yyyy , HH:mm').format(inputDate);
    return formattedDate;
  } catch (e) {
    // Handle the exception gracefully if the input is invalid
    debugPrint('Error parsing date: $e');
    return 'Invalid date format'; // Or return a more informative error message.
  }
}

/// Generates a random integer between [minNumber] and [maxNumber] (inclusive).
int randomNumber(int maxNumber, int minNumber) {
  final random = Random();
  return minNumber + random.nextInt(maxNumber - minNumber + 1);
}
