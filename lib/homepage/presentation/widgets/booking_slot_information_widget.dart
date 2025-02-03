part of 'widgets.dart';

class BookingSlotInformationWidget extends StatefulWidget {
  const BookingSlotInformationWidget({
    super.key,
  });

  @override
  State<BookingSlotInformationWidget> createState() => _BookingSlotInformationWidgetState();
}

class _BookingSlotInformationWidgetState extends State<BookingSlotInformationWidget> {
  late socket_io.Socket socket;
  int availableSlots = 0; // Variabel untuk menyimpan slot yang tersedia

  @override
  void initState() {
    super.initState();
    _initializeSocket();
    context.read<CheckBookingSlotLeftBloc>().add(DoCheckBookingSlotLeft());
  }

  void _initializeSocket() {
    socket = socket_io.io(
      baseURL,
      socket_io.OptionBuilder()
          .setTransports(['websocket']) // Gunakan WebSocket
          .disableAutoConnect() // Koneksi manual
          .build(),
    );

    socket.onConnect((_) {
      log('Connected to WebSocket', name: "SOCKET");
      socket.emit('subscribe', 'booking-slots'); // Emit jika ada event subscribe
    });

    // Mendengarkan event `booking-slots-remaining`
    socket.on('booking-slots-remaining', (data) {
      if (data != null && mounted) {
        setState(() {
          availableSlots = data['slotsRemaining'] ?? 0;
        });
      }
    });

    socket.onDisconnect((_) {
      log('Disconnected from WebSocket', name: "SOCKET");
    });

    // Connect ke server
    socket.connect();
  }

  @override
  void dispose() {
    socket.dispose(); // Pastikan socket ditutup saat widget dihapus
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AspectRatio(
        aspectRatio: 16 / 6,
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Slot Booking Tersisa Untuk Hari Ini",
                      style: TextStyle(fontSize: 12.spMin),
                    ),
                    Text(
                      "$availableSlots",
                      style: bebasNeue.copyWith(fontSize: 30.spMin),
                    ),
                    BlocBuilder<DetailMemberBloc, DetailMemberState>(
                      builder: (context, state) {
                        if (state is DetailMemberSuccess) {
                          return SizedBox(
                            height: 20.h,
                            child: FilledButton.icon(
                              style: FilledButton.styleFrom(
                                backgroundColor: "#F5F5F5".toColor(),
                              ),
                              onPressed: () {
                                if (state.datas.onSite) {
                                  showBottomDialogueAlert(
                                      imagePath: "assets/sad.png",
                                      title: "Tidak Bisa Booking",
                                      subtitle:
                                          "Anda sedang berada di lokasi. Check out dulu ya untuk Booking slot.",
                                      duration: 3);
                                  return;
                                }

                                showBlurredBottomSheet(
                                  context: parentKey.currentContext!,
                                  builder: (context) {
                                    return BlurContainerWrapper(child: AddBookingWidget());
                                  },
                                );
                              },
                              icon: Icon(Icons.chevron_right_rounded, color: Colors.black),
                              iconAlignment: IconAlignment.end,
                              label: Text(
                                "Booking Now",
                                style: TextStyle(fontSize: 13.spMin, color: Colors.black),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: Image.asset("assets/gym_building.png"),
              ),
            ],
          ),
        ),
      ).animate(delay: 200.milliseconds).slideY(begin: -0.1, end: 0).fadeIn(),
    );
  }
}
