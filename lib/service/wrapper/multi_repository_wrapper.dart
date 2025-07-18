import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocy_user_app/service/api/api_provider.dart';

import 'package:velocy_user_app/service/api/config_api.dart';
import 'package:velocy_user_app/view/auth_page/resources/auth_repository.dart';
import 'package:velocy_user_app/view/driver_auth_page/resources/driver_auth_repository.dart';
import 'package:velocy_user_app/view/module/driver/profile_page/resouces/ride_history_repository.dart';
import 'package:velocy_user_app/view/module/rental/resources/rental_repository.dart';
import 'package:velocy_user_app/view/module/user/book_ride/resources/ride_request_repository.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/resources/live_offer_api_provider.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/resources/live_offer_repository.dart';
import 'package:velocy_user_app/view/module/user/user_book_ride_page/resources/rider_profile_repository.dart';

class MultiRepositoryWrapper extends StatelessWidget {
  final Widget child;
  final Env env;
  const MultiRepositoryWrapper({
    super.key,
    required this.child,
    required this.env,
  });
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Env>(create: (context) => env, lazy: true),
        // RepositoryProvider<InternetCheck>(create: (context) => InternetCheck()),
        RepositoryProvider<ApiProvider>(
          create:
              (context) => ApiProvider(
                baseUrl: RepositoryProvider.of<Env>(context).baseUrl,
              ),
          lazy: true,
        ),
        RepositoryProvider<AuthRepository>(
          create:
              ((context) => AuthRepository(
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                env: RepositoryProvider.of<Env>(context),
              )..initial()),
          lazy: true,
        ),
        RepositoryProvider<DriverAuthRepository>(
          create:
              (context) => DriverAuthRepository(
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                env: env,
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              ),
        ),
        RepositoryProvider<LiveOfferApiProvider>(
          create:
              (context) => LiveOfferApiProvider(
                baseUrl: RepositoryProvider.of<Env>(context).baseUrl,
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              ),
          lazy: true,
        ),

        RepositoryProvider<LiveOfferRepository>(
          create:
              (context) => LiveOfferRepository(
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                env: env,
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              ),
        ),
        RepositoryProvider<RiderProfileRepository>(
          create:
              (context) => RiderProfileRepository(
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                env: env,
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              ),
        ),
        RepositoryProvider<RideHistoryRepository>(
          create:
              (context) => RideHistoryRepository(
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                env: env,
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              ),
        ),
        RepositoryProvider<RideRequestRepository>(
          create:
              (context) => RideRequestRepository(
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                env: env,
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              ),
        ),
        RepositoryProvider<RentalRepository>(
          create:
              (context) => RentalRepository(
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                env: env,
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              ),
        ),
      ],
      child: child,
    );
  }
}
