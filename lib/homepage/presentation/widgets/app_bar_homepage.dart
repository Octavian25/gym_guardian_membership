part of 'widgets.dart';

class AppBarHomepage extends StatelessWidget {
  const AppBarHomepage({
    super.key,
    required this.scrollNotifier,
  });

  final ValueNotifier<bool> scrollNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: scrollNotifier,
      builder: (context, isScrolled, child) => SliverAppBar(
        backgroundColor: Colors.white,
        leadingWidth: 38.w + 16,
        forceMaterialTransparency: isScrolled ? false : true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Hero(
            tag: 'profile_image',
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/profile.png"),
            ),
          ),
        ),
        pinned: true,
        actions: [
          IconButton(
              onPressed: () {
                showBottomDialogueAlert(
                    imagePath: "assets/sad.png",
                    title: "Fitur Baru Segera!",
                    subtitle:
                        "Fitur ini masih dalam pengembangan, tapi akan segera hadir! Tunggu ya!",
                    duration: 3);
              },
              icon: Icon(
                Icons.notifications_none,
                size: 25.spMin,
              )),
          16.horizontalSpaceRadius,
        ],
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat Datang",
              style: TextStyle(fontSize: 12.spMin),
            ),
            BlocBuilder<DetailMemberBloc, DetailMemberState>(
              builder: (context, state) {
                if (state is DetailMemberSuccess) {
                  return Text(
                    state.datas.memberName,
                    style: TextStyle(fontSize: 17.spMin, fontWeight: FontWeight.bold),
                  );
                } else if (state is DetailMemberFailure) {
                  return Text(
                    "Gagal Mengambil Data",
                    style: TextStyle(fontSize: 17.spMin, fontWeight: FontWeight.bold),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
