import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/logout_member_bloc/logout_member_bloc.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/profile/domain/entities/update_profile_entity.dart';
import 'package:gym_guardian_membership/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:gym_guardian_membership/profile/presentation/widgets/delete_confirmation_widget.dart';
import 'package:gym_guardian_membership/register/domain/entities/member_entity.dart';
import 'package:gym_guardian_membership/utility/custom_text_form_field.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/show_bottom_confirmation_dialog.dart';
import 'package:gym_guardian_membership/utility/show_bottom_dialog.dart';
import 'package:os_basecode/os_basecode.dart';

class EditProfileWidget extends StatefulWidget {
  final MemberEntity memberEntity;
  const EditProfileWidget({
    super.key,
    required this.memberEntity,
  });

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        nameController.text = widget.memberEntity.memberName;
        emailController.text = widget.memberEntity.memberEmail;
      },
    );
  }

  void handleEditProfile() {
    UpdateProfileEntity updateProfileEntity = UpdateProfileEntity(
        memberName: nameController.text,
        memberEmail: emailController.text,
        id: widget.memberEntity.memberCode);
    context.read<UpdateProfileBloc>().add(DoUpdateProfile(updateProfileEntity));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutMemberBloc, LogoutMemberState>(
      listener: (context, state) {
        if (state is LogoutMemberSuccess) {
          context.go("/login");
        }
      },
      child: BlocListener<UpdateProfileBloc, UpdateProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileSuccess) {
            showBottomConfirmationDialogueAlert(
              imagePath: "assets/congrats.png",
              title: "Profil Diperbarui",
              subtitle:
                  "Detail profil Anda telah berhasil diperbarui. Tekan OK untuk masuk kembali dan melanjutkan penggunaan aplikasi.",
              handleConfirm: (context) {
                context.read<LogoutMemberBloc>().add(DoLogoutMember());
                context.pop();
              },
            );
          } else if (state is UpdateProfileFailure) {
            showBottomDialogueAlert(
                imagePath: "assets/sad.png",
                title: "Perbarui Profil Gagal",
                subtitle:
                    "Terjadi kesalahan saat memperbarui profil Anda. Silakan coba lagi atau hubungi dukungan jika masalah terus berlanjut.",
                duration: 3);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${context.l10n.updated} ${context.l10n.profile}",
                  style: TextStyle(fontSize: 20.spMin, fontWeight: FontWeight.bold),
                ),
                Text(
                  context.l10n.update_profile_subtitle,
                  style: TextStyle(fontSize: 11.spMin),
                ),
                10.verticalSpacingRadius,
                CustomTextFormField(controller: nameController, title: context.l10n.full_name),
                10.verticalSpacingRadius,
                CustomTextFormField(controller: emailController, title: context.l10n.email),
                20.verticalSpacingRadius,
                PrimaryButton(
                  title: context.l10n.edit_profile,
                  onPressed: handleEditProfile,
                ),
                10.verticalSpacingRadius,
                Center(
                    child: TextButton(
                        style: TextButton.styleFrom(foregroundColor: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) => DeleteConfirmationWidget(),
                          );
                        },
                        child: Text(context.l10n.request_delete_account)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
