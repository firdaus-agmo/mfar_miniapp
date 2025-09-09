import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// A simple WebView-based miniapp widget.
///
/// This widget takes an [initialUrl] and displays it within a WebView.
/// It includes a basic AppBar with a close button.
class MfarWebViewMiniApp extends StatefulWidget {
  // Renamed for clarity
  /// The URL to load when the miniapp is opened.
  final String initialUrl;

  /// Creates a [MfarWebViewMiniApp].
  ///
  /// The [initialUrl] argument must not be null.
  const MfarWebViewMiniApp({super.key, required this.initialUrl});

  @override
  State<MfarWebViewMiniApp> createState() => _MfarWebViewMiniAppState();
}

class _MfarWebViewMiniAppState extends State<MfarWebViewMiniApp> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController with the URL passed from the SuperApp
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Enable JavaScript if needed by the web content
      ..setBackgroundColor(const Color(0x00000000)) // Transparent background
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Optional: Handle loading progress, e.g., show a progress bar
            // print('WebView loading: $progress%');
          },
          onPageStarted: (String url) {
            // Optional: Handle actions when a page starts loading
            // print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            // Optional: Handle actions when a page finishes loading
            // print('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            // Handle errors that occur within the WebView
            debugPrint('WebView resource error: ${error.description}');
            // Consider showing an error message to the user
          },
          // Optional: Control navigation requests (e.g., block certain URLs)
          // onNavigationRequest: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.unwanted-site.com/')) {
          //     return NavigationDecision.prevent; // Block navigation
          //   }
          //   return NavigationDecision.navigate; // Allow navigation
          // },
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl)); // Load the initial URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MFAR WebView MiniApp'), // Title for the miniapp screen
        // Add a close button to allow navigating back from the miniapp
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // Pop the current route (close the miniapp screen)
            Navigator.of(context).pop();
          },
        ),
      ),
      body: WebViewWidget(controller: _controller), // Display the WebView
    );
  }
}
