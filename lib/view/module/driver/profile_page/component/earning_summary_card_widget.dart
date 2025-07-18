import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/cubit/data_state.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_total_earning_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/model/driver_total_earning_model.dart';

class EarningSummaryCard extends StatelessWidget {
  const EarningSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverTotalEarningCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CommonStateSuccess) {
          final data = state.data as TotalEarningResponseModel;
          final monthearnings = data.thisMonthEarnings;
          final weeklyEarning = data.thisWeekEarnings;
          final yesterdayEarning = data.yesterdayEarnings;
          final todayEarning = data.todayEarnings;

          return Container(
            height: 180,
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            color: AppColors.appWhiteColor,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: const Color(0xFFF5F5F5),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₹$weeklyEarning",
                          style: AppTextStyle.medium20SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                        Text(
                          "This Week",
                          style: AppTextStyle.small14SizeText.copyWith(
                            fontFamily: FontFamily.interRegular,
                            color: AppColors.appGrayColor52,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildEarningTile(
                          title: "Today",
                          amount: "₹$todayEarning",
                        ),
                        const SizedBox(width: 12),
                        _buildEarningTile(
                          title: "Yesterday",
                          amount: "₹$yesterdayEarning",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is CommonError) {
          return const Text("Failed to load earnings");
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildEarningTile({required String title, required String amount}) {
    return Expanded(
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: AppColors.appWhiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTextStyle.small14SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                  color: AppColors.appGrayColor52,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                amount,
                style: AppTextStyle.small16SizeText.copyWith(
                  fontFamily: FontFamily.interRegular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
