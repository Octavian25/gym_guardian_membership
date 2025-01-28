import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/splashscreen/data/models/splash_model.dart';
import 'package:gym_guardian_membership/splashscreen/presentation/widgets/splash_content_widget.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        activeIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final splashContents = [
      SplashData(
          background: "assets/splash_01.png",
          illustration: "assets/splash.png",
          title: [
            _buildTitle("SELAMAT DATANG DI", Colors.black),
            _buildTitle(" LOYALTY MEMBERSHIP", primaryColor),
          ],
          description: "Nikmati pengalaman membership tanpa ribet.",
          showButton: true),
      SplashData(
          background: "assets/splash_02.png",
          illustration: "assets/splash.png",
          title: [
            _buildTitle("KEANGGOTAAN SELALU", Colors.black),
            _buildTitle(" TERKENDALI", primaryColor),
          ],
          description: "Cek status membership kapan saja, di mana saja.",
          showButton: false),
      SplashData(
          background: "assets/splash_03.png",
          illustration: "assets/splash.png",
          title: [
            _buildTitle("JADWAL", primaryColor),
            _buildTitle(" DAN ", Colors.black),
            _buildTitle("AKTIVITAS", primaryColor),
            _buildTitle(" ANDA", Colors.black),
          ],
          description: "Tetap produktif dengan melihat riwayat kunjungan.",
          showButton: false),
      SplashData(
          background: "assets/splash_04.png",
          illustration: "assets/splash.png",
          title: [
            _buildTitle("REWARDS", primaryColor),
            _buildTitle(" EKSKLUSIF", Colors.black),
          ],
          description: "Dapatkan penawaran menarik untuk Anda.",
          showButton: false),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/splash_0${_tabController.index + 1}.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: splashContents
                      .map(
                        (data) => SplashContent(
                            data: data, tabController: _tabController, activeIndex: activeIndex),
                      )
                      .toList(),
                ),
              ),
              if (_tabController.index > 0)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            _tabController.animateTo(3);
                          },
                          child: Text(
                            "SKIP",
                            style: TextStyle(color: Colors.black87),
                          )),
                      AnimatedSmoothIndicator(
                        activeIndex: _tabController.index - 1,
                        count: 3,
                        effect: ExpandingDotsEffect(
                            activeDotColor: primaryColor,
                            dotColor: Colors.black,
                            expansionFactor: 2),
                      ),
                      TextButton(
                          onPressed: () async {
                            if (_tabController.index == 3) {
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              await pref.setBool("FINISH_SPLASH", true);
                              context.go("/login");
                              return;
                            }
                            _tabController.animateTo(_tabController.index + 1);
                          },
                          child: Text(
                            _tabController.index == 3 ? "SELESAI" : "LANJUT",
                            style: TextStyle(color: Colors.black87),
                          ))
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  TextSpan _buildTitle(String text, Color color) {
    return TextSpan(
      text: text,
      style: bebasNeue.copyWith(fontSize: 40, color: color),
    );
  }
}
