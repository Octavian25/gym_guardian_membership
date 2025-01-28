import 'package:gym_guardian_membership/profile/domain/entities/update_profile_entity.dart';

class UpdateProfileModel {
  String memberName;
  String memberEmail;
  String id;

  UpdateProfileModel({required this.memberName, required this.memberEmail, required this.id});

  UpdateProfileEntity toEntity() =>
      UpdateProfileEntity(memberName: memberName, memberEmail: memberEmail, id: id);
}
