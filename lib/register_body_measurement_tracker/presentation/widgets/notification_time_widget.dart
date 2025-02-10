import 'package:flutter/cupertino.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

class NotificationTimeWidget extends StatefulWidget {
  const NotificationTimeWidget({
    super.key,
  });

  @override
  State<NotificationTimeWidget> createState() => _NotificationTimeWidgetState();
}

class _NotificationTimeWidgetState extends State<NotificationTimeWidget> {
  int selectedHour = 9;
  int selectedMinute = 30;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 1.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacingRadius,
              Text(
                "Silahkan Pilih Waktu Notifikasi Muncul",
                style: bebasNeue.copyWith(fontSize: 30.spMin),
              ),
              Text(
                "Misalkan ingin jam 9 lebih 30, berarti pilih 9 di bagian kiri, dan 30 di bagian kanan",
                style: TextStyle(fontSize: 11.spMin),
              ),
              5.verticalSpacingRadius,
              SizedBox(
                height: 150.h, // Adjust height as needed
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 150.h, // Adjust height as needed
                        child: CupertinoPicker(
                          itemExtent: 40.h, // Adjust item height as needed
                          onSelectedItemChanged: (int index) {
                            setState(() {
                              selectedHour = index; // Values from 1 to 7
                            });
                          },
                          magnification: 1.2,
                          scrollController: FixedExtentScrollController(initialItem: 9),
                          children: List.generate(
                              24,
                              (index) => Center(
                                      child: Text(
                                    'Jam $index ',
                                  ))),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 150.h, // Adjust height as needed
                        child: CupertinoPicker(
                          itemExtent: 40.h, // Adjust item height as needed
                          onSelectedItemChanged: (int index) {
                            setState(() {
                              selectedMinute = index; // Values from 1 to 7
                            });
                          },
                          magnification: 1.2,
                          scrollController: FixedExtentScrollController(initialItem: 30),
                          children: List.generate(
                              60,
                              (index) => Center(
                                      child: Text(
                                    '$index  Menit',
                                  ))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              5.verticalSpacingRadius,
              PrimaryButton(
                title: "Pilih",
                onPressed: () {
                  context.pop({
                    "hour": selectedHour,
                    "minute": selectedMinute,
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
