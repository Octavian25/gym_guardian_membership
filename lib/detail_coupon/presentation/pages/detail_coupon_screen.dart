import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/base_sliver_padding.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

class DetailCouponScreen extends StatefulWidget {
  const DetailCouponScreen({super.key});

  @override
  State<DetailCouponScreen> createState() => _DetailCouponScreenState();
}

class _DetailCouponScreenState extends State<DetailCouponScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              "assets/background_home.png",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                forceMaterialTransparency: true,
              ),
              SliverToBoxAdapter(
                child: Hero(
                    tag: "coupon_icon",
                    child: Image.asset(
                      "assets/voucher.png",
                      height: 120,
                    )),
              ),
              SliverToBoxAdapter(child: 10.verticalSpacingRadius),
              SliverToBoxAdapter(
                  child: Center(
                child: Text("Total Kupon:"),
              )),
              SliverToBoxAdapter(
                  child: Center(
                child: Text(
                  "5",
                  style: bebasNeue.copyWith(fontSize: 35.spMin),
                ),
              )),
              SliverToBoxAdapter(child: 10.verticalSpacingRadius),
              baseSliverPadding(
                  sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Kupon Anda",
                          style: bebasNeue.copyWith(fontSize: 20.spMin),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
              SliverList.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {},
                    leading: Container(
                      height: 35.h,
                      width: 35.h,
                      padding: EdgeInsets.all(6.h),
                      decoration: BoxDecoration(
                          color: "#F5F5F5".toColor(), borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "assets/voucher.png",
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right_outlined),
                    title: Text(
                      "Potongan 10% Makanan",
                      style: TextStyle(fontSize: 14.spMin),
                    ),
                    subtitle: Text(
                      "Berlaku Sampai 30 January 2025",
                      style: TextStyle(fontSize: 11.spMin),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
