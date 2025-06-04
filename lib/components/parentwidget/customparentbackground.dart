import 'package:flutter/material.dart';

class CustomParentScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget body;
  final PreferredSizeWidget? appbar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Drawer? drawer;
  final bool isExtendedBody;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;
  final Future<bool> Function()? onWillPop;

  const CustomParentScaffold({
    super.key,
    this.scaffoldKey,
    required this.body,
    this.appbar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.isExtendedBody = false,
    this.resizeToAvoidBottomInset = true,
    this.onWillPop,
    this.extendBodyBehindAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on tap
      child: PopScope(
        canPop: onWillPop == null,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop || onWillPop == null) return;
          final shouldPop = await onWillPop!();
          if (shouldPop && context.mounted) {
            Navigator.of(context).pop();
          }
        },
        child:
            isExtendedBody
                ? Scaffold(
                  key: scaffoldKey,
                  drawer: drawer,
                  floatingActionButton: floatingActionButton,
                  bottomNavigationBar: bottomNavigationBar,
                  resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                  body: body,
                  appBar: appbar,
                  extendBodyBehindAppBar: extendBodyBehindAppBar,
                )
                : SafeArea(
                  child: Scaffold(
                    key: scaffoldKey,
                    drawer: drawer,
                    floatingActionButton: floatingActionButton,
                    bottomNavigationBar: bottomNavigationBar,
                    resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                    body: body,
                    appBar: appbar,
                    extendBodyBehindAppBar: extendBodyBehindAppBar,
                  ),
                ),
      ),
    );
  }
}
