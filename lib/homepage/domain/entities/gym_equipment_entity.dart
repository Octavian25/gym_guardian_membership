import 'package:gym_guardian_membership/homepage/data/models/gym_equipment_model.dart';

class GymEquipmentEntity {
  final String id;
  final String category;
  final String name;
  final String location;
  final String description;
  final String tutorialVideo;
  final String status;
  final String inputBy;
  final DateTime inputDate;

  GymEquipmentEntity({
    required this.id,
    required this.category,
    required this.name,
    required this.location,
    required this.description,
    required this.tutorialVideo,
    required this.status,
    required this.inputBy,
    required this.inputDate,
  });

  GymEquipmentModel toModel() => GymEquipmentModel(
      id: id,
      category: category,
      name: name,
      location: location,
      description: description,
      tutorialVideo: tutorialVideo,
      status: status,
      inputBy: inputBy,
      inputDate: inputDate);

  GymEquipmentEntity copyWith({
    String? id,
    String? category,
    String? name,
    String? location,
    String? description,
    String? tutorialVideo,
    String? status,
    String? inputBy,
    DateTime? inputDate,
  }) =>
      GymEquipmentEntity(
        id: id ?? this.id,
        category: category ?? this.category,
        name: name ?? this.name,
        location: location ?? this.location,
        description: description ?? this.description,
        tutorialVideo: tutorialVideo ?? this.tutorialVideo,
        status: status ?? this.status,
        inputBy: inputBy ?? this.inputBy,
        inputDate: inputDate ?? this.inputDate,
      );

  factory GymEquipmentEntity.fromJson(Map<String, dynamic> json) => GymEquipmentEntity(
        id: json["_id"],
        category: json["category"],
        name: json["name"],
        location: json["location"],
        description: json["description"],
        tutorialVideo: json["tutorial_video"],
        status: json["status"],
        inputBy: json["input_by"],
        inputDate: DateTime.parse(json["input_date"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category": category,
        "name": name,
        "location": location,
        "description": description,
        "tutorial_video": tutorialVideo,
        "status": status,
        "input_by": inputBy,
        "input_date": inputDate.toIso8601String(),
      };

  Map<String, dynamic> toJsonGemini() => {
        "name": name,
        "tutorial_video": tutorialVideo,
      };
}
