import 'package:flutter/cupertino.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

class NotificationIntervalWidget extends StatefulWidget {
  const NotificationIntervalWidget({
    super.key,
  });

  @override
  State<NotificationIntervalWidget> createState() => _NotificationIntervalWidgetState();
}

class _NotificationIntervalWidgetState extends State<NotificationIntervalWidget> {
  int selectedDays = 3;
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
                "Silahkan Pilih Interval Notifikasi",
                style: bebasNeue.copyWith(fontSize: 30.spMin),
              ),
              Text(
                "Misalkan ingin setiap 3 hari , Maka Pilih 3",
                style: TextStyle(fontSize: 12.spMin),
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
                              selectedDays = index + 1; // Values from 1 to 7
                            });
                          },
                          magnification: 1.2,
                          scrollController: FixedExtentScrollController(initialItem: 2),
                          children: List.generate(
                              7,
                              (index) => Center(
                                      child: Text(
                                    'Setiap ${index + 1} Hari',
                                  ))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "**Kami Membatasi Maksimal Pengukuran 7 hari, agar data lebih lengkap dan maksimal",
                style: TextStyle(fontSize: 10.spMin),
              ),
              5.verticalSpacingRadius,
              PrimaryButton(
                title: "Pilih",
                onPressed: () {
                  context.pop(selectedDays);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
