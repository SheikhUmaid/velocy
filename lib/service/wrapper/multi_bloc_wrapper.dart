import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/config_api.dart';
import 'package:velocy_user_app/view/auth_page/cubit/login_cubit.dart';
import 'package:velocy_user_app/view/auth_page/cubit/register_cubit.dart';
import 'package:velocy_user_app/view/auth_page/cubit/update_profile_cubit.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';
import 'package:velocy_user_app/view/driver_auth_page/cubit/driver_document_cubit.dart';
import 'package:velocy_user_app/view/driver_auth_page/cubit/driver_registration_cubit.dart';
import 'package:velocy_user_app/view/driver_auth_page/resources/driver_auth_repository.dart';
import 'package:velocy_user_app/view/module/driver/driver_cab_tracking/cubit/driver_genrate_otp_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_cab_tracking/cubit/driver_verify_ride_otp_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_cash_limit_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_online_status_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_rides_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_scheduled_rides_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_todays_earning_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/cubit/driver_total_earning_cubit.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/cubit/driver_vehicles_doc_cubit.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/cubits/ride_history_cubit.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/cubits/ride_history_schedule_cubit.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/resouces/ride_history_repository.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/cubit/driver_profile_cubit.dart';
import 'package:velocy_user_app/view/module/driver/recent_rides_page/cubit/ride_details_cubit.dart';
import 'package:velocy_user_app/view/module/rental/cubit/my_garage_cubit.dart';
import 'package:velocy_user_app/view/module/rental/resources/rental_repository.dart';
import 'package:velocy_user_app/view/module/user/book_ride/cubit/add_ride_stops_cubit.dart';
import 'package:velocy_user_app/view/module/user/book_ride/cubit/confirm_location_cubit.dart';
import 'package:velocy_user_app/view/module/user/book_ride/cubit/estimate_price_cubit.dart';
import 'package:velocy_user_app/view/module/user/book_ride/cubit/ride_booking_cubit.dart';
import 'package:velocy_user_app/view/module/user/book_ride/cubit/vehicle_types_cubit.dart';
import 'package:velocy_user_app/view/module/user/book_ride/resources/ride_request_repository.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/cubit/live_offer_cubit.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/cubit/rider_profile_cubit.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/resources/live_offer_repository.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/resources/rider_profile_repository.dart';

import '../../view/module/driver/driver_cab_tracking/cubit/driver_begein_ride_cubit.dart';
import '../../view/module/driver/driver_cab_tracking/cubit/driver_cancel_ride_cubit.dart';
import '../../view/module/driver/driver_cab_tracking/cubit/driver_complete-ride_cubit.dart';
import '../../view/module/driver/recent_rides_page/cubit/driver_accept_ride_cubit.dart';
import '../../view/module/driver/recent_rides_page/cubit/driver_decline_ride_cubit.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  final Env env;

  const MultiBlocWrapper({Key? key, required this.child, required this.env})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create:
        //       ((context) => LogoutCubit(
        //         authRepository: RepositoryProvider.of<AuthRepository>(context),
        //       )),
        // ),
        BlocProvider(
          create:
              (context) => RegisterCubit(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => LoginCubit(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              ),
        ),

        BlocProvider(
          create:
              (context) => ProfileUpdateCubit(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverRegistrationCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverDocumentUploadCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(create: (context) => OnlineStatusSwitchCubit()),
        BlocProvider(
          create:
              (context) => LiveOfferCubit(
                liveOfferRepository: RepositoryProvider.of<LiveOfferRepository>(
                  context,
                ),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverHomeCashLimitCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverHomeTodaysEarningCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverOnlineStatusCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverRidesCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverScheduledRidesCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => RideDetailsCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => RiderProfileCubit(
                riderProfileRepository:
                    RepositoryProvider.of<RiderProfileRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverAcceptRideCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverDeclineRideCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverBeginRideCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverCancelRideCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverCompleteRideCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverGenrateOtpCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverVerifyRideOtpCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),

        BlocProvider(
          create:
              (context) => DriverProfileCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => RideHistoryCubit(
                rideHistoryRepository:
                    RepositoryProvider.of<RideHistoryRepository>(context),
              )..fetchDriverRideHistory(),
        ),
        BlocProvider(
          create:
              (context) => ScheduledRideCubit(
                rideHistoryRepository:
                    RepositoryProvider.of<RideHistoryRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverTotalEarningCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverVehiclesDocsCubit(
                driverAuthRepository:
                    RepositoryProvider.of<DriverAuthRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => ConfirmLocationCubit(
                confirmLocationRepository:
                    RepositoryProvider.of<RideRequestRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => AddRideStopsCubit(
                confirmLocationRepository:
                    RepositoryProvider.of<RideRequestRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => EstimatePriceCubit(
                confirmLocationRepository:
                    RepositoryProvider.of<RideRequestRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => RideBookingCubit(
                confirmLocationRepository:
                    RepositoryProvider.of<RideRequestRepository>(context),
              ),
        ),
        BlocProvider(
          create:
              (context) => VehicleTypesCubit(
                confirmLocationRepository:
                    RepositoryProvider.of<RideRequestRepository>(context),
              )..vehicleTypes(),
        ),
        BlocProvider(
          create:
              (context) => MyGarageCubit(
                rentalRepository: RepositoryProvider.of<RentalRepository>(
                  context,
                ),
              )..myGarage(),
        ),
      ],
      child: child,
    );
  }
}
