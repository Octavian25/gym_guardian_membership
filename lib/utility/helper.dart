import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/body_measurement_tracker/presentation/bloc/fetch_body_measurement_bloc/fetch_body_measurement_bloc.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/fetch_all_gym_equipment_bloc/fetch_all_gym_equipment_bloc.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

String formatDuration(int minutes) {
  if (minutes < 60) {
    return "$minutes Menit";
  } else {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    if (remainingMinutes == 0) {
      return "$hours Jam";
    } else {
      return "$hours Jam $remainingMinutes Menit";
    }
  }
}

String formatTimeOnly(DateTime inputDate) {
  try {
    // Format the date according to the locale
    String formattedDate = DateFormat('HH:mm').format(inputDate);
    return formattedDate;
  } catch (e) {
    // Handle the exception gracefully if the input is invalid
    debugPrint('Error parsing date: $e');
    return 'Invalid date format'; // Or return a more informative error message.
  }
}

String getMonthAndYearOnly(DateTime inputDate) {
  try {
    // Format the date according to the locale
    String formattedDate = DateFormat('MMMM yyyy').format(inputDate);
    return formattedDate;
  } catch (e) {
    // Handle the exception gracefully if the input is invalid
    debugPrint('Error parsing date: $e');
    return 'Invalid date format'; // Or return a more informative error message.
  }
}

String getDayName(int dayIndex, {String locale = "id"}) {
  if (dayIndex < 0 || dayIndex > 6) {
    throw ArgumentError("dayIndex harus antara 0 sampai 6");
  }

  // Ambil tanggal dari Senin di minggu ini sebagai acuan
  DateTime referenceDate = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
  DateTime targetDate = referenceDate.add(Duration(days: dayIndex));

  // Format nama hari sesuai locale
  return DateFormat.EEEE(locale).format(targetDate);
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

String getlastWeekBodyMeasurementData(BuildContext context) {
  String gymEquipment = "";
  var gymEquipmentState = context.read<FetchBodyMeasurementBloc>().state;
  if (gymEquipmentState is FetchBodyMeasurementSuccess) {
    gymEquipment = gymEquipmentState.datas.map((e) => e.toGeminiPrompt()).toList().join("\n");
  } else {
    throw Exception('gyn Equipment not on success state');
  }
  return gymEquipment;
}

extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
