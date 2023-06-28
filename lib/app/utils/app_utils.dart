import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_pipeline/res/colors.dart';

import '../routes/app_pages.dart';
import 'app_constants.dart';

class AppUtils {
  static var dataStorage =  GetStorage();
  static void showErrorSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: const Icon(Icons.error, color: Colors.black),
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }
  static Future<void>  removeLeadDataFromGetStorage()  async {

    dataStorage.remove(SOURCE);
    dataStorage.remove(BUSINESS_TYPE);
    dataStorage.remove(BUSINESS_NAME);
    dataStorage.remove(DIVISION);
    dataStorage.remove(TOWNSHIP);
    dataStorage.remove(ADDRESS);
    dataStorage.remove(DESIGNATION);
    dataStorage.remove(CONTACT_NUMBER);
    dataStorage.remove(CONTACT_PERSON);
    dataStorage.remove(EMAIL);
    dataStorage.remove(SOURCE_INDEX);
    dataStorage.remove(BUSINESS_TYPE_INDEX);
    dataStorage.remove(DESIGNATION_INDEX);
    dataStorage.remove(SME);
    dataStorage.remove(BUSINESS_TYPE_OTHER);
    dataStorage.remove(DESIGNATION_OTHER);
    dataStorage.remove(SECONDARY_CONTACT_NUMBER);
  }

  static Future<void> removeDataFromGetStorage() async {
    dataStorage.remove(TOKEN);
    dataStorage.remove(UID);
  }

  static void showSessionExpireDialog(
      String title, String message, BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => Center(
                child: SafeArea(
                  child: Container(
                    height: 270,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(4),
                    color: Color(int.parse(AppColors.bgColor)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 60,
                          color: Colors.black,
                        ),
                        Center(
                          child: Text(
                            title,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                fontSize: 20.0),
                          ),
                        ),
                        Center(
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5555,
                            height: MediaQuery.of(context).size.height * 0.0625,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white)),
                                child: const Text(
                                  'OK',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onPressed: () {
                                  Get.back();
                                  AppUtils.removeDataFromGetStorage().then(
                                      (value) =>
                                          {Get.offAllNamed(Routes.LOGIN)});
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
    });
  }
}
