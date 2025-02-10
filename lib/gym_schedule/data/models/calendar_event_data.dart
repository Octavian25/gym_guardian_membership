// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

/// {@macro calendar_event_data_doc}
class CalendarEventData<T extends Object?> {
  /// Specifies date on which all these events are.
  final DateTime date;

  /// Defines the start time of the event.
  /// [endTime] and [startTime] will defines time on same day.
  /// This is required when you are using [CalendarEventData] for [DayView] or [WeekView]
  final DateTime? startTime;

  /// Defines the end time of the event.
  /// [endTime] and [startTime] defines time on same day.
  /// This is required when you are using [CalendarEventData] for [DayView]
  final DateTime? endTime;

  /// Title of the event.
  final String title;

  /// Description of the event.
  final String? description;

  /// Defines color of event.
  /// This color will be used in default widgets provided by plugin.
  final Color color;

  /// Event on [date].
  final T? event;

  final DateTime? _endDate;

  /// Define style of title.
  final TextStyle? titleStyle;

  /// Define style of description.
  final TextStyle? descriptionStyle;

  /// Define reoccurrence settings
  final RecurrenceSettings? recurrenceSettings;

  final int? maxQuota;
  final int? availableQuota;
  final int? reservations;
  final List<String>? reservationMembers;

  /// {@macro calendar_event_data_doc}
  CalendarEventData({
    required this.title,
    required DateTime date,
    this.description,
    this.event,
    this.color = Colors.blue,
    this.startTime,
    this.endTime,
    this.titleStyle,
    this.descriptionStyle,
    this.recurrenceSettings,
    this.availableQuota,
    this.maxQuota,
    this.reservations,
    this.reservationMembers,
    DateTime? endDate,
  })  : _endDate = endDate?.withoutTime,
        date = date.withoutTime;

  DateTime get endDate => _endDate ?? date;

  /// If this flag returns true that means event is occurring on multiple
  /// days and is not a full day event.
  ///
  bool get isRangingEvent {
    final diff = endDate.withoutTime.difference(date.withoutTime).inDays;

    return diff > 0 && !isFullDayEvent;
  }

  /// Returns if the events is full day event or not.
  ///
  /// If it returns true that means the events is full day. but also it can
  /// span across multiple days.
  ///
  bool get isFullDayEvent {
    return (startTime == null || endTime == null || (startTime!.isDayStart && endTime!.isDayStart));
  }

  bool get isRecurringEvent {
    return recurrenceSettings != null &&
        recurrenceSettings!.frequency != RepeatFrequency.doNotRepeat;
  }

  Duration get duration {
    if (isFullDayEvent) return Duration(days: 1);

    final now = DateTime.now();

    final end = now.copyFromMinutes(endTime!.getTotalMinutes);
    final start = now.copyFromMinutes(startTime!.getTotalMinutes);

    if (end.isDayStart) {
      final difference = end.add(Duration(days: 1) - Duration(seconds: 1)).difference(start);

      return difference + Duration(seconds: 1);
    } else {
      return end.difference(start);
    }
  }

  /// Returns a boolean that defines whether current event is occurring on
  /// [currentDate] or not.
  ///
  bool occursOnDate(DateTime currentDate) {
    return currentDate == date ||
        currentDate == endDate ||
        (currentDate.isBefore(endDate.withoutTime) && currentDate.isAfter(date.withoutTime));
  }

  /// Returns event data in [Map<String, dynamic>] format.
  ///
  Map<String, dynamic> toJson() => {
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "event": event,
        "title": title,
        "description": description,
        "endDate": endDate,
        "recurrenceSettings": recurrenceSettings,
      };

  /// Membuat objek `CalendarEventData` dari JSON
  factory CalendarEventData.fromJson(Map<String, dynamic> json) {
    return CalendarEventData(
      title: json["title"] ?? "",
      date: DateTime.parse(json["date"]).toLocal(),
      startTime: json["startTime"] != null ? DateTime.parse(json["startTime"]).toLocal() : null,
      endTime: json["endTime"] != null ? DateTime.parse(json["endTime"]).toLocal() : null,
      color: json["color"] != null
          ? Color(int.parse(json["color"].replaceAll("#", "0xff")))
          : Colors.blue,
      description: json["description"],
      endDate: json["endDate"] != null ? DateTime.parse(json["endDate"]).toLocal() : null,
      event: json["event"], // Perlu casting ke tipe data yang sesuai di penggunaan
      availableQuota: json['availableQuota'] ?? 0,
      maxQuota: json['maxQuota'] ?? 0,
      reservations: json['reservations'] ?? 0,
      reservationMembers: json['reservation_members'] != null
          ? List<String>.from(json['reservation_members'].map((e) => e))
          : [],
      recurrenceSettings: json["recurrenceSettings"] != null
          ? RecurrenceSettings.fromJson(json["recurrenceSettings"])
          : null,
    );
  }

  /// Returns new object of [CalendarEventData] with the updated values defined
  /// as the arguments.
  ///
  CalendarEventData<T> copyWith({
    String? title,
    String? description,
    T? event,
    Color? color,
    DateTime? startTime,
    DateTime? endTime,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    DateTime? endDate,
    DateTime? date,
    RecurrenceSettings? recurrenceSettings,
  }) {
    return CalendarEventData(
      title: title ?? this.title,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      description: description ?? this.description,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      endDate: endDate ?? this.endDate,
      event: event ?? this.event,
      titleStyle: titleStyle ?? this.titleStyle,
      recurrenceSettings: recurrenceSettings ?? this.recurrenceSettings,
    );
  }

  @override
  String toString() => '${toJson()}';

  @override
  bool operator ==(Object other) {
    return other is CalendarEventData<T> &&
        date.compareWithoutTime(other.date) &&
        endDate.compareWithoutTime(other.endDate) &&
        ((event == null && other.event == null) ||
            (event != null && other.event != null && event == other.event)) &&
        ((startTime == null && other.startTime == null) ||
            (startTime != null &&
                other.startTime != null &&
                startTime!.hasSameTimeAs(other.startTime!))) &&
        ((endTime == null && other.endTime == null) ||
            (endTime != null && other.endTime != null && endTime!.hasSameTimeAs(other.endTime!))) &&
        title == other.title &&
        color == other.color &&
        titleStyle == other.titleStyle &&
        descriptionStyle == other.descriptionStyle &&
        description == other.description;
  }

  @override
  int get hashCode =>
      description.hashCode ^
      descriptionStyle.hashCode ^
      titleStyle.hashCode ^
      color.hashCode ^
      title.hashCode ^
      date.hashCode;
}

class RecurrenceSettings {
  RecurrenceSettings({
    required this.startDate,
    this.endDate,
    this.occurrences,
    this.frequency = RepeatFrequency.doNotRepeat,
    this.recurrenceEndOn = RecurrenceEnd.never,
    this.excludeDates,
    List<int>? weekdays,
  }) : weekdays = weekdays ?? [startDate.weekday];

  /// If recurrence event does not have an end date it will calculate end date
  /// from the start date.
  ///
  /// Specify `endDate` to end an event on specific date.
  ///
  /// End date for Repeat Frequency - daily.
  /// Ex. If event start date is 11-11-24 and interval is 5 then new end date
  /// will be 15-11-24.
  ///
  /// End date for Repeat Frequency - weekly
  /// Ex. If event start date is 1-11-24 and interval is 5 then new end date
  /// will be 29-11-24.
  RecurrenceSettings.withCalculatedEndDate({
    required this.startDate,
    DateTime? endDate,
    this.occurrences,
    this.frequency = RepeatFrequency.doNotRepeat,
    this.recurrenceEndOn = RecurrenceEnd.never,
    this.excludeDates,
    List<int>? weekdays,
  }) : weekdays = weekdays ?? [startDate.weekday] {
    this.endDate = endDate ?? _getEndDate(startDate);
  }

  final DateTime startDate;
  late DateTime? endDate;
  final int? occurrences;
  final RepeatFrequency frequency;
  final RecurrenceEnd recurrenceEndOn;
  final List<int> weekdays;
  final List<DateTime>? excludeDates;

  // For recurrence patterns other than weekly, where the event may not repeat
  // on the start date.
  // Excludes one occurrence since the event is already counted
  // for the start date.
  int get _occurrences => (occurrences ?? 1) - 1;

  /// Calculates the end date for a monthly recurring event
  /// based on the start date and the number of occurrences.
  ///
  /// If the next month does not have the event date and the recurrence
  /// is still set to repeat for the given number of occurrences,
  /// it will keep looking for a valid date in the following month.
  ///
  /// Example: If the start date is 29-01-25 and the recurrence ends
  /// after 2 occurrences,
  /// the end date will be 29-03-25 because February does not have a 29th date.
  /// Similarly for 30/31 date as well.
  DateTime get _endDateMonthly {
    var repetition = _occurrences;
    var nextDate = startDate;

    while (repetition > 0) {
      nextDate = DateTime(
        nextDate.year,
        nextDate.month + 1,
        nextDate.day,
      );

      // Adjust the date if the resulting month does not have the same day
      // as the start date
      // Example: DateTime(2024, 10 + 1, 31) gives 2024-12-01
      if (nextDate.day != startDate.day) {
        nextDate = DateTime(
          nextDate.year,
          nextDate.month,
          startDate.day,
        );
      }
      repetition--;
    }
    return nextDate;
  }

  /// Returns the calculated end date for the selected weekdays and occurrences,
  /// or null if the conditions are not met.
  ///
  /// If the weekday of event start date is not in list of selected weekdays
  /// then it will find for the next valid weekdays to repeat on.
  ///
  /// Example: If the start date is 12-11-24 (Tuesday), and the selected
  /// weekdays are [Tuesday, Wednesday] for 3 occurrences,
  /// the event will repeat on 12-11-24, 13-11-24, and 19-11-24.
  ///
  /// Example:  If the start date is 26-11-24 (Tuesday),
  /// if all weeks are selected but the number of occurrences is 1,
  /// the event will only be shown on the start date.
  DateTime? get _endDateWeekly {
    if (weekdays.isEmpty) {
      return null;
    }

    // Contains the recurring weekdays in sorted order
    final sortedWeekdays = weekdays..sort();
    var remainingOccurrences = occurrences ?? 1;
    var currentDate = startDate;

    // Check if the start date is one of the recurring weekdays
    if (sortedWeekdays.contains(startDate.weekday - 1)) {
      remainingOccurrences--;
    }

    while (remainingOccurrences > 0) {
      // Find the next valid weekday
      final nextWeekday = sortedWeekdays.firstWhere(
        (day) => day > currentDate.weekday - 1,
        orElse: () => sortedWeekdays.first,
      );

      // Calculate the days to the next occurrence
      final daysToAdd = (nextWeekday - (currentDate.weekday - 1) + 7) % 7;

      // Move the current date to the next occurrence
      currentDate = currentDate.add(Duration(days: daysToAdd));

      if (daysToAdd == 0 && nextWeekday == sortedWeekdays.first) {
        currentDate = currentDate.add(const Duration(days: 7));
      }
      remainingOccurrences--;
    }
    return currentDate;
  }

  /// Calculate end date for yearly recurring event
  DateTime get _endDateYearly {
    var repetition = _occurrences;
    var nextDate = startDate;

    // If the start date is not 29th Feb, we can directly calculate last year.
    if (startDate.day != 29 && startDate.month != DateTime.february) {
      return DateTime(
        nextDate.year + repetition,
        startDate.month,
        startDate.day,
      );
    }
    while (repetition > 0) {
      final newDate = DateTime(
        nextDate.year + 1,
        startDate.month,
        startDate.day,
      );

      // If month changes that means that date does not exist in given year
      if (newDate.month != startDate.month) {
        nextDate = DateTime(
          newDate.year,
        );
        continue;
      }
      nextDate = newDate;
      repetition--;
    }
    return nextDate;
  }

  /// Determines the end date for a recurring event based on the
  /// `RepeatFrequency` & `RecurrenceEnd`.
  ///
  /// Returns null if the end date is not applicable.
  /// For example: An event that "does not repeat" and event that "never ends".
  DateTime? _getEndDate(DateTime endDate) {
    if (frequency == RepeatFrequency.doNotRepeat || recurrenceEndOn == RecurrenceEnd.never) {
      return null;
    } else if (recurrenceEndOn == RecurrenceEnd.onDate) {
      return endDate;
    } else if (recurrenceEndOn == RecurrenceEnd.after) {
      return _handleOccurrence(endDate);
    } else {
      return null;
    }
  }

  /// Returns the end date for a recurring event based on the specified
  /// number of occurrences.
  ///
  /// This method requires at least one occurrence to process the recurrence.
  /// The recurrence starts from the event's start date.
  DateTime? _handleOccurrence(DateTime endDate) {
    if ((occurrences ?? 0) < 1) {
      return endDate;
    }
    switch (frequency) {
      case RepeatFrequency.doNotRepeat:
        return null;
      case RepeatFrequency.daily:
        return endDate.add(Duration(days: _occurrences));
      case RepeatFrequency.weekly:
        return _endDateWeekly ?? endDate;
      case RepeatFrequency.monthly:
        return _endDateMonthly;
      case RepeatFrequency.yearly:
        return _endDateYearly;
    }
  }

  @override
  String toString() {
    return 'start date: $startDate, '
        'end date: $endDate, '
        'interval: $occurrences, '
        'frequency: $frequency '
        'weekdays: $weekdays'
        'recurrence Ends on: $recurrenceEndOn'
        'exclude dates: $excludeDates';
  }

  /// **Convert JSON to `RecurrenceSettings` Object**
  factory RecurrenceSettings.fromJson(Map<String, dynamic> json) {
    return RecurrenceSettings(
      startDate: DateTime.parse(json["startDate"]).toLocal(),
      endDate: json["endDate"] != null ? DateTime.parse(json["endDate"]).toLocal() : null,
      occurrences: json["occurrences"],
      frequency: RepeatFrequency.values.firstWhere(
        (e) => e.toString() == "RepeatFrequency.${json["frequency"]}",
        orElse: () => RepeatFrequency.doNotRepeat,
      ),
      recurrenceEndOn: RecurrenceEnd.values.firstWhere(
        (e) => e.toString() == "RecurrenceEnd.${json["recurrenceEndOn"]}",
        orElse: () => RecurrenceEnd.never,
      ),
      weekdays: json["weekdays"] != null ? List<int>.from(json["weekdays"]) : [],
      excludeDates: json["excludeDates"] != null
          ? (json["excludeDates"] as List).map((date) => DateTime.parse(date).toLocal()).toList()
          : null,
    );
  }

  RecurrenceSettings copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? occurrences,
    RepeatFrequency? frequency,
    RecurrenceEnd? recurrenceEndOn,
    List<int>? weekdays,
    List<DateTime>? excludeDates,
  }) {
    return RecurrenceSettings(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      occurrences: occurrences ?? this.occurrences,
      frequency: frequency ?? this.frequency,
      recurrenceEndOn: recurrenceEndOn ?? this.recurrenceEndOn,
      weekdays: weekdays ?? this.weekdays,
      excludeDates: excludeDates ?? this.excludeDates,
    );
  }
}
