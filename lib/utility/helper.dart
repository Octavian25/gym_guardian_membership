import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_all_gym_equipment_bloc/fetch_all_gym_equipment_bloc.dart';
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

String getCurrentDay({String? locale}) {
  locale ??= Intl.getCurrentLocale(); // Gunakan locale default sistem jika tidak diberikan
  return DateFormat('EEEE', locale).format(DateTime.now());
}

String getGymEquipment(BuildContext context) {
  String gymEquipment = "";
  var gymEquipmentState = context.read<FetchAllGymEquipmentBloc>().state;
  if (gymEquipmentState is FetchAllGymEquipmentSuccess) {
    gymEquipment = gymEquipmentState.datas.map((e) => e.toJsonGemini()).toList().join(",");
  } else {
    throw Exception('gyn Equipment not on success state');
  }
  return gymEquipment;
}
