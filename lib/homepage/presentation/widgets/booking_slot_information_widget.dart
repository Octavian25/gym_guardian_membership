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
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(
                      context.l10n.booking_info,
                      style: TextStyle(fontSize: 12.spMin, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "$availableSlots",
                      style: bebasNeue.copyWith(fontSize: 30.spMin),
                    ),
                    Spacer(),
                    BlocBuilder<DetailMemberBloc, DetailMemberState>(
                      builder: (context, state) {
                        if (state is DetailMemberSuccess) {
                          return SizedBox(
                            height: 25.h,
                            child: FilledButton.icon(
                              style: FilledButton.styleFrom(
                                backgroundColor: "#F5F5F5".toColor(),
                              ),
                              onPressed: () {
                                if (state.datas.onSite) {
                                  showBottomDialogueAlert(
                                      imagePath: "assets/sad.png",
                                      title: context.l10n.booking_failed_title,
                                      subtitle: context.l10n.booking_failed_subtitle,
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
                              label: Text(
                                context.l10n.reservation_now,
                                style: TextStyle(
                                    fontSize: 11.spMin,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Image.asset("assets/gym_building.png"),
              ),
            ],
          ),
        ),
      ).animate(delay: 200.milliseconds).slideY(begin: -0.1, end: 0).fadeIn(),
    );
  }
}
