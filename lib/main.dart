import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocy_user_app/helper/app.dart';
import 'package:velocy_user_app/service/api/config_api.dart';
import 'package:flutter/material.dart';
import '../helper/get_di.dart' as di;

late SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  await di.init();
  runApp(MyApp(env: EnvValue.development));
}
