import 'package:gym_guardian_membership/profile/data/models/update_profile_model.dart';

class UpdateProfileEntity {
  String memberName;
  String memberEmail;
  String id;

  UpdateProfileEntity({required this.memberName, required this.memberEmail, required this.id});

  UpdateProfileModel toModel() =>
      UpdateProfileModel(memberName: memberName, memberEmail: memberEmail, id: id);
}
