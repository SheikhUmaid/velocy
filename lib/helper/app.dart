import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/api/config_api.dart';
import 'package:velocy_user_app/service/wrapper/multi_bloc_wrapper.dart';
import 'package:velocy_user_app/service/wrapper/multi_repository_wrapper.dart';
import 'package:velocy_user_app/utils/app_colors.dart';

class MyApp extends StatelessWidget {
  final Env env;
  const MyApp({super.key, required this.env});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
    );
    return MultiRepositoryWrapper(
      env: env,
      child: MultiBlocWrapper(
        env: env,
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: colorCustom,
                useMaterial3: false,
                fontFamily: "inter",
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.linear(1.0)),
                  child: Container(child: child),
                );
              },
              initialRoute: Routes.splashPage.value,
              // initialRoute: Routes.splashPage.value,
              getPages: getPages,
            );
          },
        ),
      ),
    );
  }
}
// Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUzMTY1NjMzLCJpYXQiOjE3NTMwNzkyMzMsImp0aSI6IjkyNDllZWM5ZTQ4MjRkODc5MmM5OGViY2JhZWUzMDQxIiwidXNlcl9pZCI6MTF9.WM7Gkm9A4NJV_TAedXaj05DfcYOjcLccCoWX7wwPSUM