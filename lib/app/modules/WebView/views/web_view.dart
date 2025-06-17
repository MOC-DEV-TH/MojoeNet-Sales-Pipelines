import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../res/colors.dart';

class WebViewView extends StatelessWidget {
  WebViewView({Key? key}) : super(key: key);

  final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
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
        onHttpError: (HttpResponseError error) {
          debugPrint('HTTP error: ${error.response} - ${error.request?.uri}');
        },
        onWebResourceError: (WebResourceError error) {
          debugPrint('Web resource error: ${error.errorType} - ${error.description}');
        },
        onNavigationRequest: (NavigationRequest request) {
          debugPrint('Navigation request: ${request.url}');
          if (request.url.startsWith('https://mojoenet.myanmaronlinecreations.com/webapp/save_sign')) {
            Get.back();
            return NavigationDecision.navigate;
          }
          return NavigationDecision.navigate;
        },
      ),
    );

  @override
  Widget build(BuildContext context) {
    final String initialUrl = Get.arguments.toString();
    controller.loadRequest(Uri.parse(initialUrl));

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: WebViewWidget(controller: controller),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildSaveButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      onPressed: () => Get.back(),
      color: Color(int.parse(AppColors.buttonColor)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Text(
        "Save",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
