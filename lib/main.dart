import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/app/routes/app_pages.dart';
import 'package:sales_pipeline/app/utils/app_constants.dart';

final readData = GetStorage();

Future main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: readData.read(TOKEN) != null
          ? AppPages.INITIAL_TASK_SELECTION
          : AppPages.INITIAL_LOGIN,
      getPages: AppPages.routes,
    );
  }
}
