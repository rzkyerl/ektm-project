import 'package:ektm/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SnapWebViewPage extends StatefulWidget {
  final String snapToken;

  const SnapWebViewPage({Key? key, required this.snapToken}) : super(key: key);

  @override
  State<SnapWebViewPage> createState() => _SnapWebViewPageState();
}

class _SnapWebViewPageState extends State<SnapWebViewPage> {
  late final WebViewController _controller;

  @override
  @override
  void initState() {
    super.initState();
    final String url =
        '${ApiService.baseUrl}/payments/snap-view?token=${widget.snapToken}';

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                print('Started: $url');
              },
              onPageFinished: (url) {
                print('Finished: $url');
              },
              onWebResourceError: (error) {
                print('WebView Error: ${error.description}');
              },
            ),
          )
          ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
