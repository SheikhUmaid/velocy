import 'package:get/get.dart';
import 'package:velocy_user_app/view/auth_page/auth_screen.dart';
import 'package:velocy_user_app/view/auth_page/otp_screen.dart';
import 'package:velocy_user_app/view/auth_page/profile_screen.dart';
import 'package:velocy_user_app/view/coprate/dashboard/coprate_dashboard.dart';
import 'package:velocy_user_app/view/coprate/dashboard/unauthorized_acess/ui/page/unauthorized_acess_page.dart';
import 'package:velocy_user_app/view/driver_auth_page/document_screen.dart';
import 'package:velocy_user_app/view/driver_auth_page/driver_registration_screen.dart';
import 'package:velocy_user_app/view/language_page/language_screen.dart';
import 'package:velocy_user_app/view/module/car_handover_page/car_handover_page.dart';
import 'package:velocy_user_app/view/module/driver/driver_cab_tracking/ui/widget/driver_cab_tracking_widget.dart';
import 'package:velocy_user_app/view/module/driver/driver_home_page/driver_home_screen.dart';
import 'package:velocy_user_app/view/module/driver/driver_ride_complete/ui/widget/driver_ride_complete_widget.dart';
import 'package:velocy_user_app/view/module/driver/driver_route/driver_route_page.dart';
import 'package:velocy_user_app/view/module/driver/driver_settings/driver_setting_page.dart';
import 'package:velocy_user_app/view/module/driver/drop_locations/ui/page/drop_location_page.dart';
import 'package:velocy_user_app/view/module/driver/help_support/ui/widget/page/help_support_page.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/earning_screen.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/profile_screen.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/ride_history_screen.dart';
import 'package:velocy_user_app/view/module/driver/ratings/ui/pages/rating_pages.dart';
import 'package:velocy_user_app/view/module/driver/recent_rides_page/ride_details_screen.dart';
import 'package:velocy_user_app/view/module/driver/reports_page/report_submit_page.dart';
import 'package:velocy_user_app/view/module/driver/reports_page/reports_screen.dart';
import 'package:velocy_user_app/view/module/driver/ride_sechedule/ui/page/ride_sechedule_page.dart';
import 'package:velocy_user_app/view/module/driver/rider_chat/rider_chat_page.dart';
import 'package:velocy_user_app/view/module/driver/rider_complete/ride_complete_page.dart';
import 'package:velocy_user_app/view/module/driver/rider_reward/rider_reward_page.dart';
import 'package:velocy_user_app/view/module/driver/tripe_complete/ui/pages/tripe_complete_page.dart';
import 'package:velocy_user_app/view/module/payment_screen/payment_screen.dart';
import 'package:velocy_user_app/view/module/rent_request/rent_request_page.dart';
import 'package:velocy_user_app/view/module/rental/my_garage/ui/page/my_garage_page.dart';
import 'package:velocy_user_app/view/module/rental/pickup_details/ui/pages/pickup_pages.dart';
import 'package:velocy_user_app/view/module/rental/rental_owner_profile/ui/page/rental_owner_profile.dart';
import 'package:velocy_user_app/view/module/rental/rental_rider_profile/ui/pages/rental_rider_profile.dart';
import 'package:velocy_user_app/view/module/rental/ui/page/rental_dashboard_page.dart';
import 'package:velocy_user_app/view/module/rental/vechile_add/ui/pages/vechile_add_page.dart';
import 'package:velocy_user_app/view/module/rental/vehicle_details/ui/pages/vechile_details_page.dart';
import 'package:velocy_user_app/view/module/rental_vechile_profile/rental_vechile_profile.dart';
import 'package:velocy_user_app/view/module/user/book_ride/ui/page/book_ride_page.dart';
import 'package:velocy_user_app/view/module/user/conform_ride/ui/pages/confirm_ride_page.dart';
import 'package:velocy_user_app/view/module/user/driver_arriver_screen/ui/pages/driver_arrivel_screen.dart';
import 'package:velocy_user_app/view/module/user/driver_wating/ui/pages/driver_wating_page.dart';
import 'package:velocy_user_app/view/module/user/live_tracking/live_tracking_page.dart';
import 'package:velocy_user_app/view/module/user/select_location/select_location_page.dart';
import 'package:velocy_user_app/view/notification/notification_page.dart';
import 'package:velocy_user_app/view/pool/available_rider/ui/page/available_rider_page.dart';
import 'package:velocy_user_app/view/pool/dashboard/ui/page/pool_dashboard.dart';
import 'package:velocy_user_app/view/pool/pool_payment/ui/pages/pool_payment.dart';
import 'package:velocy_user_app/view/pool/pool_request/ui/ui/pool_request_page.dart';
import 'package:velocy_user_app/view/pool/ride_details/ui/pages/ride_details.dart';
import 'package:velocy_user_app/view/splash_page/permission_screen.dart';
import 'package:velocy_user_app/view/splash_page/splash_screen.dart';
import 'package:velocy_user_app/widgets/onBoarding_screen.dart';

class Routes {
  static RxString splashPage = "/splashPage".obs;
  static RxString permissionPage = "/permissionPage".obs;
  static RxString languagePage = "/languagePage".obs;
  static RxString authPage = "/authPage".obs;
  static RxString userProfilePage = "/userProfilePage".obs;
  static RxString onBoardingPage = "/onBoardingPage".obs;
  static RxString otpPage = "/otpPage".obs;
  static RxString driverRegistrationPage = "/driverRegistrationPage".obs;
  static RxString documentPage = "/documentPage".obs;
  static RxString rideHistoryPage = "/rideHistoryPage".obs;
  static RxString rideDetailsPage = "/rideDetailsPage".obs;
  static RxString earningPage = "/earningPage".obs;
  static RxString driverProfilePage = "/driverProfilePage".obs;
  static RxString riderChatPage = "/riderChatPage".obs;

  static RxString rideSchedulePage = "/riderSchedulePage".obs;
  static RxString riderRewardPage = "/riderRewardPage".obs;

  static RxString notificationPage = "/notificationPage".obs;
  static RxString rentRequest = "/rentRequest".obs;
  static RxString paymentScreen = "/paymentScreen".obs;
  static RxString carHandOverScreen = "/carHandOver".obs;
  static RxString rentalVehicleProfile = "/rentalVehicleProfile".obs;
  static RxString driverSettingsPage = "/driverSettingsPage".obs;
  static RxString driverHomePage = "/driverHomePage".obs;
  static RxString selectLocationPage = "/selectLocationPage".obs;
  static RxString liveTrackingsPage = "/liveTrackingsPage".obs;
  static RxString rideComplete = "/rideComplete".obs;
  static RxString driverRoutePage = "/driverRoutePage".obs;
  static RxString bookRideScreen = "/bookRideScreen".obs;
  static RxString helpSupport = "/helpSupport".obs;
  static RxString driverCabTracking = "/driverCabTracking".obs;
  static RxString dropLocation = "/dropLocation".obs;
  static RxString driverRideComplete = "/driverRideComplete".obs;
  static RxString tripeCompletePage = "/tripeCompletePage".obs;
  static RxString rentalDashboard = "/rentalDashboard".obs;

  static RxString myGarage = "/myGarage".obs;
  static RxString vechileAddPage = "/vechileAddPage".obs;

  static RxString pickUpDetails = "/pickUpDetails".obs;
  static RxString vechileDetailsPages = "/vechileDetails".obs;
  static RxString rentalOwnerDetails = "/rentalOwnerDetails".obs;
  static RxString rentalOwnerProfile = "/rentalOwnerProfile".obs;
  static RxString poolDashboard = "/poolDashboard".obs;
  static RxString availableRider = "/availableRider".obs;
  static RxString rideDetails = "/rideDetails".obs;
  static RxString poolRequest = "/poolRequest".obs;
  static RxString poolPayment = "/poolPayment".obs;
  static RxString coopratedDashboard = "/coopratedDashboard".obs;
  static RxString unAuthorizedAcessPage = "/unAuthorizedAcessPage".obs;
  static RxString confirmBookRide = "/conformBookRide".obs;
  static RxString driverWatingPage = "/driverWatingPage".obs;
  static RxString driverArrivalScreen = "/driverArrivalScreen".obs;
  static RxString reportScreen = "/reportScreen".obs;
  static RxString reportSubmitPage = "/reportSubmitPage".obs;
  static RxString ratingPages = "/ratingPages".obs;
}

final getPages = [
  GetPage(name: Routes.splashPage.value, page: () => const SplashScreen()),

  GetPage(
    name: Routes.permissionPage.value,
    page: () => const PermissionScreen(),
  ),

  GetPage(name: Routes.languagePage.value, page: () => const LanguageScreen()),

  GetPage(name: Routes.authPage.value, page: () => AuthScreen()),

  GetPage(name: Routes.userProfilePage.value, page: () => UserProfileScreen()),

  GetPage(name: Routes.onBoardingPage.value, page: () => OnBoardingScreen()),

  GetPage(name: Routes.otpPage.value, page: () => OtpScreen()),
  GetPage(
    name: Routes.driverRegistrationPage.value,
    page: () => DriverRegistrationScreen(),
  ),

  GetPage(name: Routes.documentPage.value, page: () => DocumentScreen()),

  GetPage(name: Routes.rideHistoryPage.value, page: () => RideHistoryScreen()),

  GetPage(name: Routes.rideDetailsPage.value, page: () => RideDetailsScreen()),

  GetPage(name: Routes.earningPage.value, page: () => EarningScreen()),
  GetPage(name: Routes.riderChatPage.value, page: () => RiderChatPage()),

  GetPage(name: Routes.rideSchedulePage.value, page: () => RideSechedulePage()),

  GetPage(name: Routes.riderRewardPage.value, page: () => RiderRewardPage()),
  GetPage(name: Routes.notificationPage.value, page: () => NotificationPage()),
  GetPage(name: Routes.rentRequest.value, page: () => RentRequestPage()),
  GetPage(name: Routes.paymentScreen.value, page: () => PaymentPage()),
  GetPage(
    name: Routes.carHandOverScreen.value,
    page: () => CarHandoverScreen(),
  ),
  GetPage(name: Routes.driverHomePage.value, page: () => DriHomeScreen()),
  GetPage(
    name: Routes.driverProfilePage.value,
    page: () => DriverProfileScreen(),
  ),

  /// wed
  GetPage(
    name: Routes.rentalVehicleProfile.value,
    page: () => RentalVechileProfile(),
  ),
  GetPage(
    name: Routes.driverSettingsPage.value,
    page: () => DriverSettingPage(),
  ),
  GetPage(
    name: Routes.selectLocationPage.value,
    page: () => SelectLocationPage(),
  ),
  GetPage(name: Routes.liveTrackingsPage.value, page: () => LiveTrackingPage()),
  GetPage(name: Routes.rideComplete.value, page: () => RideCompleteScreen()),
  GetPage(name: Routes.driverRoutePage.value, page: () => DriverRoutePage()),

  GetPage(name: Routes.bookRideScreen.value, page: () => BookRidePage()),
  GetPage(name: Routes.helpSupport.value, page: () => HelpSupportPage()),
  GetPage(
    name: Routes.driverCabTracking.value,
    page: () => DriverCabTrackingWidget(),
  ),
  GetPage(name: Routes.dropLocation.value, page: () => DropLocationPage()),
  GetPage(
    name: Routes.driverRideComplete.value,
    page: () => DriverRideCompleteWidget(),
  ),
  GetPage(
    name: Routes.tripeCompletePage.value,
    page: () => TripeCompletePage(),
  ),

  GetPage(name: Routes.rentalDashboard.value, page: () => RentalPage()),
  GetPage(name: Routes.myGarage.value, page: () => MyGaragePage()),
  GetPage(name: Routes.vechileAddPage.value, page: () => VechileAddPage()),
  GetPage(name: Routes.pickUpDetails.value, page: () => PickupPages()),

  GetPage(
    name: Routes.vechileDetailsPages.value,
    page: () => VechileDetailsPage(),
  ),
  GetPage(
    name: Routes.rentalOwnerDetails.value,
    page: () => RentalOwnerProfile(),
  ),
  GetPage(
    name: Routes.rentalOwnerProfile.value,
    page: () => RentalRiderProfile(),
  ),

  //sat
  GetPage(name: Routes.poolDashboard.value, page: () => PoolDashboard()),

  GetPage(name: Routes.availableRider.value, page: () => AvailableRiderPage()),
  GetPage(name: Routes.rideDetails.value, page: () => RideDetailsPages()),
  GetPage(name: Routes.poolRequest.value, page: () => PoolRequestPage()),
  GetPage(name: Routes.poolPayment.value, page: () => PoolPayment()),
  GetPage(
    name: Routes.coopratedDashboard.value,
    page: () => CoprateDashboard(),
  ),
  GetPage(
    name: Routes.unAuthorizedAcessPage.value,
    page: () => UnauthorizedAcessPage(),
  ),
  GetPage(name: Routes.confirmBookRide.value, page: () => ConfirmRidePage()),

  GetPage(name: Routes.driverWatingPage.value, page: () => DriverWatingPage()),

  GetPage(
    name: Routes.driverArrivalScreen.value,
    page: () => DriverArrivelScreen(),
  ),
  GetPage(name: Routes.reportScreen.value, page: () => ReportScreen()),
  GetPage(name: Routes.reportSubmitPage.value, page: () => ReportSubmitPage()),
  GetPage(name: Routes.ratingPages.value, page: () => RatingPage()),
];
