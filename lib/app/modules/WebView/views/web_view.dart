import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../res/colors.dart';

class WebViewView extends GetView<WebViewController> {
  @override
  Widget build(BuildContext context) {
    debugPrint(Get.arguments.toString());
    return  SafeArea(
      child: Scaffold(
        body:
            Padding(
              padding: const EdgeInsets.only(top: 0,bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: WebView(
                      initialUrl: Get.arguments.toString(),
                      javascriptMode: JavascriptMode.unrestricted,
                      navigationDelegate: (NavigationRequest request) {
                        if (request.url.startsWith('https://mojoenet.myanmaronlinecreations.com/webapp/save_sign')) {
                          debugPrint('blocking navigation to $request}');
                          debugPrint('ActionUrl ${request.url}');
                          Get.back();
                          return NavigationDecision.navigate;
                        }
                        debugPrint('allowing navigation to $request');
                        return NavigationDecision.navigate;
                      },
                      onPageStarted: (String url) {
                        debugPrint('Page started loading: $url');
                      },
                      onPageFinished: (String url) {
                        debugPrint('Page finished loading: $url');
                        if (url.startsWith('https://mojoenet.myanmaronlinecreations.com/webapp/save_sign')) {
                          Get.back();
                        }
                      },
                      gestureNavigationEnabled: true,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: makeButton(),
                  )
                ],
              ),
            ),
      ),
    );
  }

  Widget makeButton() {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      onPressed: (){Get.back();},
      color: Color(int.parse(AppColors.buttonColor)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Text(
        "Back",
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
      ),
    );
  }

}
