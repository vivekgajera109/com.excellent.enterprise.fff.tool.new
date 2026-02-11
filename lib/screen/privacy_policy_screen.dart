import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:fff_skin_tools/common/global_wrapper.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/constants/app_colors.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final String url;

  const PrivacyPolicyScreen({
    super.key,
    required this.url,
  });

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) {
              setState(() => _isLoading = true);
            }
          },
          onPageFinished: (_) {
            if (mounted) {
              setState(() => _isLoading = false);
            }
          },
          onWebResourceError: (_) {
            if (mounted) {
              setState(() => _isLoading = false);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: Scaffold(
        backgroundColor: AppColors.background,

        /// -------------------- APP BAR --------------------
        appBar: const CommonAppBar(
          title: "Privacy Policy",
          showBackButton: true,
        ),

        /// -------------------- BODY --------------------
        body: Stack(
          children: [
            /// WEB VIEW
            WebViewWidget(controller: _controller),

            /// LOADER OVERLAY
            if (_isLoading)
              Container(
                color: AppColors.background.withOpacity(0.85),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.accent,
                    strokeWidth: 3,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
