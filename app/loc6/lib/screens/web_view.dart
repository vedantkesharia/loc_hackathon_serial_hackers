import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final _controller = WebViewController(
  onPermissionRequest: (WebViewPermissionRequest request) {
    // Handle permission requests (camera, microphone, etc.)
    // You can grant or deny permissions here
    // For example:
      request.grant();
  },
)
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setNavigationDelegate(NavigationDelegate(
    onProgress: (int progress) {
      // Print the loading progress to the console
      // You can use this value to show a progress bar if you want
      debugPrint("Loading: $progress%");
    },
    onPageStarted: (String url) {},
    onPageFinished: (String url) {},
    onWebResourceError: (WebResourceError error) {},
    onNavigationRequest: (NavigationRequest request) {
      return NavigationDecision.navigate;
    },
  ))
  ..loadRequest(Uri.parse("https://www.signlanguageai.com/"));


class SignWebView extends StatefulWidget {
  const SignWebView({Key? key}) : super(key: key);

  @override
  State<SignWebView> createState() => _SignWebViewState();
}

class _SignWebViewState extends State<SignWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign language translation', style: TextStyle(color: Colors.black),),
        ),
        body: WebViewWidget(
          controller: _controller,
        ),
    );
  }
}