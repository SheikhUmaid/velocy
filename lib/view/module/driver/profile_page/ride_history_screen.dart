import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/cubits/ride_history_cubit.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/cubits/ride_history_schedule_cubit.dart';
import 'component/cancelled_widget.dart';
import 'component/history_widget.dart';
import 'component/scheduled_widget.dart';

class RideHistoryScreen extends StatefulWidget {
  RideHistoryScreen({super.key});

  @override
  State<RideHistoryScreen> createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen> {
  final RxInt history = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RideHistoryCubit>().fetchDriverRideHistory();
    context.read<ScheduledRideCubit>().fetchScheduledRides();
    // context.read<RideHistoryCubit>().fetchScheduledDriverRideHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.appBgColor,
        appBar: AppBar(
          backgroundColor: AppColors.appBgColor,
          elevation: 1,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.appBlackColor,
              size: 24,
            ),
          ),
          title: Text(
            "My Rides",
            style: AppTextStyle.medium18SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
        ),
        body: Column(
          children: [
            _buildTabs(),

            Expanded(
              child: Obx(() {
                if (history.value == 0) {
                  return HistoryWidget();
                } else if (history.value == 1) {
                  /// 🟡 Fetch scheduled data only when this tab is active
                  // context.read<ScheduledRideCubit>().fetchScheduledRides();
                  return ScheduledWidget();
                } else {
                  return CancelledWidget();
                }
              }),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTabs() {
    return Container(
      height: 47,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.appWhiteColor,
        border: Border(
          bottom: BorderSide(
            color: AppColors.appGrayColorE5,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _tab("History", 0),
          _tab("Scheduled", 1),
          _tab("Cancelled", 2),
        ],
      ),
    );
  }

  Widget _tab(String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => history.value = index,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    history.value == index
                        ? AppColors.appBlackColor
                        : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: AppTextStyle.small14SizeText.copyWith(
              color:
                  history.value == index
                      ? AppColors.appBlackColor
                      : AppColors.appDarkGrayColor73,
            ),
          ),
        ),
      ),
    );
  }
}
