import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scary_teacher2/constant/appAppbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/controller/home_controller.dart';
import 'package:scary_teacher2/models/reward_model.dart';
import 'package:scary_teacher2/screens/spin_details_screen.dart';

class RewardDetails extends StatefulWidget {
  final RewardModel rewardData;

  const RewardDetails({super.key, required this.rewardData});

  @override
  State<RewardDetails> createState() => _RewardDetailsState();
}

class _RewardDetailsState extends State<RewardDetails> {
  final HomeController homeController = Get.put(HomeController());

  List<RewardData> rewardList = [];

  @override
  void initState() {
    super.initState();
    rewardList = widget.rewardData.data ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            ImageConstant.appBackground,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAppbar(text: '${widget.rewardData.name}'),
              Expanded(
                child: rewardList.isEmpty
                    ? Center(
                        child: LoadingAnimationWidget.hexagonDots(
                            color: ColorConstant.appWhite, size: 24))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: rewardList.length,
                        itemBuilder: (context, index) {
                          final rewards = rewardList[index];

                          bool isSelected =
                              homeController.selectedIndex.value == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                homeController.selectedIndex.value = index;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SpinDetailsScreen(
                                      rewardData: rewards,
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: 150,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ColorConstant.appWhite
                                    : ColorConstant.appWhite.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  isSelected
                                      ? BoxShadow(
                                          blurRadius: 15,
                                          color: ColorConstant.appBlack
                                              .withOpacity(0.1),
                                          spreadRadius: 0,
                                          offset: const Offset(0, 7))
                                      : const BoxShadow(
                                          color: Colors.transparent,
                                        ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 5),
                                  Text(
                                    rewards.categoryName!.toUpperCase(),
                                    style: TextStyle(
                                      color: isSelected
                                          ? ColorConstant.appBlack
                                          : ColorConstant.appWhite,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'alexandriaFontBold',
                                    ),
                                  ),
                                  ClipRRect(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: 0.9,
                                      child: Image.asset(
                                        rewards.categoryImage ?? '',
                                        fit: BoxFit.cover,
                                        width: 135,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
