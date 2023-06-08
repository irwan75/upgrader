/*
 * Copyright (c) 2021-2022 Larry Aasen. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

/// A widget to display the upgrade dialog.
class UpgradeAlert extends UpgradeBase {
  /// The [child] contained by the widget.
  final Widget? child;
  final Widget Function(BuildContext, Upgrader)? customAlert;

  /// Creates a new [UpgradeAlert].
  UpgradeAlert({
    Key? key,
    Upgrader? upgrader,
    this.child,
    this.customAlert,
    this.navigatorKey,
  }) : super(upgrader ?? Upgrader.sharedInstance, key: key);

  /// For use by the Router architecture as part of the RouterDelegate.
  final GlobalKey<NavigatorState>? navigatorKey;

  /// Describes the part of the user interface represented by this widget.
  @override
  Widget build(BuildContext context, UpgradeBaseState state) {
    if (upgrader.debugLogging) {
      print('upgrader: build UpgradeAlert');
    }

    return FutureBuilder(
        future: state.initialized,
        builder: (BuildContext context, AsyncSnapshot<bool> processed) {
          final checkContext =
              navigatorKey != null && navigatorKey!.currentContext != null
                  ? navigatorKey!.currentContext!
                  : context;
          if (processed.connectionState == ConnectionState.done &&
              processed.data != null &&
              processed.data!) {
            if (customAlert != null) {
              upgrader.checkVersionCustomAlert(
                  context: checkContext, customAlert: customAlert);
            } else {
              upgrader.checkVersion(context: checkContext);
            }
          }
          return child ?? Container();
        });
  }
}
