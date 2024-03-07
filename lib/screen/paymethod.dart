// import 'package:flutter/material.dart';
// import 'package:webview_flutter_plus/webview_flutter_plus.dart';
//
// class PaymentWebView extends StatefulWidget {
//   final String apiUrl;
//
//   PaymentWebView({required this.apiUrl});
//
//   @override
//   _PaymentWebViewState createState() => _PaymentWebViewState();
// }
//
// class _PaymentWebViewState extends State<PaymentWebView> {
//   late WebViewControllerPlus _webViewController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment WebView'),
//       ),
//       body: WebView(
//         initialUrl: widget.apiUrl,
//         onWebViewCreated: (WebViewControllerPlus webViewController) {
//           _webViewController = webViewController;
//         },
//         javascriptMode: JavaScriptMode.unrestricted,
//         navigationDelegate: (NavigationRequest request) {
//           // Handle URL changes here (success/failure)
//           if (request.url.contains('success')) {
//             Navigator.pop(context, 'Payment process success');
//             return NavigationDecision.prevent;
//           } else if (request.url.contains('failure')) {
//             Navigator.pop(context, 'Payment process failure');
//             return NavigationDecision.prevent;
//           }
//           return NavigationDecision.navigate;
//         },
//       ),
//     );
//   }
// }
