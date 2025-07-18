import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/component/menu.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_cash_limit_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_online_status_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_rides_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_scheduled_rides_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_todays_earning_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_total_earning_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/model/cash_limit_model.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/model/driver_todays_earning_model.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/cubit/driver_profile_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/model/driver_settings_model.dart';
import '../../../../service/cubit/data_state.dart';
import '../../../../service/local_storage/secure_storage.dart';
import '../../../../utils/custom_toast.dart';
import '../../../auth_page/model/profile_model.dart';
import 'model/driver_rides_model.dart';

class DriHomeScreen extends StatefulWidget {
  const DriHomeScreen({super.key});

  @override
  State<DriHomeScreen> createState() => _DriHomeScreenState();
}

class _DriHomeScreenState extends State<DriHomeScreen> {
  final RxBool _switchValue = false.obs;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxString selectedType = "Live".obs;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    await context.read<DriverHomeTodaysEarningCubit>().fetchTodaysEarning();
    await context.read<DriverHomeCashLimitCubit>().fetchCashLimit();
    await context.read<DriverRidesCubit>().fetchRides();
    await context.read<DriverScheduledRidesCubit>().fetchScheduledRides();
    await context.read<DriverProfileCubit>().fetchDriverProfile();
    await context.read<DriverTotalEarningCubit>().fetchTotalEarning();
  }

  void updateOnlineStatus(bool value) async {
    final cubit = context.read<DriverOnlineStatusCubit>();
    await cubit.driverOnlineStatusUpdate();
    CustomToast.success(message: "Status Changed Successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.appBgColor,
        key: _scaffoldKey,
        drawer: const MenuDrawer(),
        body: Column(
          children: [
            // _buildAppBar(),
            _buildAppBarTWo(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshData,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      _buildOnlineSwitch(),
                      _buildEarningsCard(),
                      _buildCashLimitCard(),
                      _buildRideRequestsHeader(),
                      Obx(
                        () =>
                            selectedType.value == "Live"
                                ? _buildRideRequestsList()
                                : _buildScheduledRideRequestsList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return FutureBuilder<ProfileModel?>(
      future: SecureStorage().getUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          debugPrint("Profile from SecureStorage: ${snapshot.data}");
          debugPrint("Username: ${snapshot.data?.user.username}");
          return Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.appWhiteColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.appBlackColor.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
              border: Border(
                bottom: BorderSide(
                  color: AppColors.appBlackColor.withOpacity(0.05),
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Center(
              child: CircularProgressIndicator(), // Placeholder for loading
            ),
          );
        }

        final name = snapshot.data?.user.username ?? 'Guest';

        return Container(
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.appWhiteColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.appBlackColor.withOpacity(0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
            border: Border(
              bottom: BorderSide(
                color: AppColors.appBlackColor.withOpacity(0.05),
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: SvgPicture.asset(SvgImage.profile.value),
                  ),
                  const SizedBox(width: 22),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, $name",
                        style: AppTextStyle.small14SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                      Text(
                        "Welcome back",
                        style: AppTextStyle.small12SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                          color: AppColors.appDarkGrayColor73,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.notificationPage.value);
                },
                child: SvgPicture.asset(SvgImage.notificationFill.value),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppBarTWo() {
    return BlocBuilder<DriverProfileCubit, CommonState>(
      builder: (context, state) {
        String name = 'Guest';
        String? profileImage;

        if (state is CommonStateSuccess<DriverSettingsModel>) {
          name = state.data.data?.username ?? 'Guest';
          profileImage = state.data.data?.profileImage;
        }

        return Container(
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.appWhiteColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.appBlackColor.withOpacity(0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
            border: Border(
              bottom: BorderSide(
                color: AppColors.appBlackColor.withOpacity(0.05),
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: ClipOval(
                      child:
                          (profileImage != null &&
                                  profileImage.startsWith("http"))
                              ? Image.network(
                                profileImage,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        Icon(Icons.person),
                                width: 36,
                                height: 36,
                                fit: BoxFit.cover,
                              )
                              : SvgPicture.asset(
                                SvgImage.profile.value,
                                width: 36,
                                height: 36,
                              ),
                    ),
                  ),
                  const SizedBox(width: 22),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, $name",
                        style: AppTextStyle.small14SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                        ),
                      ),
                      Text(
                        "Welcome back",
                        style: AppTextStyle.small12SizeText.copyWith(
                          fontFamily: FontFamily.interRegular,
                          color: AppColors.appDarkGrayColor73,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.notificationPage.value),
                child: SvgPicture.asset(SvgImage.notificationFill.value),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOnlineSwitch() {
    return Container(
      height: 68,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.appWhiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Go Online",
            style: AppTextStyle.small14SizeText.copyWith(
              fontFamily: FontFamily.interRegular,
            ),
          ),
          CupertinoSwitch(
            value: _switchValue.value,
            onChanged: (bool value) {
              setState(() {
                _switchValue.value = value;
              });
              // context.read<OnlineStatusSwitchCubit>().toggle();
              updateOnlineStatus(value);
            },
          ),
          // BlocBuilder<OnlineStatusSwitchCubit, bool>(
          //   builder: (context, state) {
          //     return CupertinoSwitch(
          //       value: state,
          //       onChanged: (bool value) {
          //         // _switchValue.value = value;
          //         // context.read<OnlineStatusSwitchCubit>().toggle();
          //         updateOnlineStatus(value);
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildEarningsCard() {
    return BlocBuilder<DriverHomeTodaysEarningCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonLoading) {
          return _cardWrapper(
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        } else if (state is CommonStateSuccess) {
          final model = state.data as TodaysEarningModel?;
          final todaysEarnings = model?.todayEarnings ?? 0.0;
          final rideCount = model?.todayRideCount ?? 0;
          final averageRating = model?.averageRating ?? 0.0;

          return Container(
            height: 112,
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
            color: AppColors.appWhiteColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Earnings",
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem("\$$todaysEarnings", "Total"),
                    _buildStatItem("$rideCount", "Trips"),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.ratingPages.value);
                      },
                      child: _buildStatItem("$averageRating", "Rating"),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is CommonError) {
          return _cardWrapper(
            Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.red),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Error: ${state.message}",
                    style: AppTextStyle.small12SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyle.medium18SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
          ),
        ),
        Text(
          label,
          style: AppTextStyle.small12SizeText.copyWith(
            fontFamily: FontFamily.interRegular,
            color: AppColors.appDarkGrayColor73,
          ),
        ),
      ],
    );
  }

  Widget _buildCashLimitCard() {
    return BlocBuilder<DriverHomeCashLimitCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonLoading) {
          return _cardWrapper(
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        } else if (state is CommonStateSuccess) {
          final model = state.data as CashLimitModel?;
          // if (_switchValue.value == false && model?.isOnline == true) {
          //   _switchValue.value = true;
          // }
          final cashLimit = model?.limit ?? 0.0;

          return _cardWrapper(
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cash Limit",
                  style: AppTextStyle.small16SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
                SvgPicture.asset(SvgImage.slider.value, fit: BoxFit.cover),
                Text(
                  "₹${cashLimit.toStringAsFixed(2)} collected - Submit by today",
                  style: AppTextStyle.small12SizeText.copyWith(
                    fontFamily: FontFamily.interRegular,
                    color: AppColors.appDarkGrayColor73,
                  ),
                ),
              ],
            ),
          );
        } else if (state is CommonError) {
          return _cardWrapper(
            Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.red),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Error: ${state.message}",
                    style: AppTextStyle.small12SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _cardWrapper(Widget child) {
    return Container(
      height: 96,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      color: AppColors.appWhiteColor,
      child: child,
    );
  }

  Widget _buildRideRequestsHeader() {
    return Obx(
      () => Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        color: AppColors.appWhiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Ride Requests",
              style: AppTextStyle.small16SizeText.copyWith(
                fontFamily: FontFamily.interRegular,
              ),
            ),
            Row(
              children: [
                _buildRequestTypeButton(
                  "Live",
                  isActive: selectedType.value == "Live",
                ),
                const SizedBox(width: 8),
                _buildRequestTypeButton(
                  "Scheduled",
                  isActive: selectedType.value == "Scheduled",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestTypeButton(String text, {required bool isActive}) {
    return GestureDetector(
      onTap: () {
        selectedType.value = text;
        // Optional: Call an API or update list based on selectedType.value
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.appGrayColorE5 : Colors.transparent,
          border: Border.all(color: AppColors.appGrayColorE5),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          text,
          style: AppTextStyle.small12SizeText.copyWith(
            color: AppColors.appBlackColor,
            fontFamily: FontFamily.interRegular,
          ),
        ),
      ),
    );
  }

  Widget _buildRideRequestsList() {
    return BlocBuilder<DriverRidesCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonLoading) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        } else if (state is CommonDataFetchSuccess<DriverRideModel>) {
          final rides = state.data;

          if (rides.isEmpty) {
            return const Center(child: Text("No rides available"));
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: rides.length,
            itemBuilder: (context, index) {
              final ride = rides[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.rideDetailsPage.value, arguments: ride.id);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 16,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ride.toLocation),
                          Text("₹${ride.price.toStringAsFixed(2)}"),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${ride.toLatitude}, ${ride.toLongitude}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is CommonError) {
          return Center(
            child: Text(
              "Error: ${state.message}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildScheduledRideRequestsList() {
    return BlocBuilder<DriverScheduledRidesCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonLoading) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        } else if (state is CommonDataFetchSuccess<DriverRideModel>) {
          final rides = state.data;

          if (rides.isEmpty) {
            return const Center(child: Text("No scheduled rides available."));
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: rides.length,
            itemBuilder: (context, index) {
              final ride = rides[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.rideDetailsPage.value, arguments: ride.id);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 16,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ride.toLocation),
                          Text("₹${ride.price.toStringAsFixed(2)}"),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${ride.toLatitude}, ${ride.toLongitude}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is CommonError) {
          return Center(
            child: Text(
              "Error: ${state.message}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
