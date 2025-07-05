import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class StateHandler extends StatelessWidget {
  const StateHandler({
    super.key,
    this.isLoading,
    required this.child,
    this.isError,
    this.loadingView,
    this.errorView,
    this.isEmpty,
    this.emptyView,
    this.onRefresh,
  });

  final bool? isLoading;
  final bool? isError;
  final bool? isEmpty;
  final Widget? loadingView;
  final Widget? errorView;
  final Widget? emptyView;
  final Widget child;
  final Callback? onRefresh;

  @override
  Widget build(BuildContext context) {
    if (isLoading ?? false) {
      return loadingView ?? const Center(child: CircularProgressIndicator());
    }

    if (isError ?? false) {
      return errorView ?? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Error"),
          IconButton(onPressed: onRefresh, icon: Icon(Icons.refresh))
        ],
      );
    }

    if (isEmpty ?? false) {
      return emptyView ?? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("No Data"),
          IconButton(onPressed: onRefresh, icon: Icon(Icons.refresh))
        ],
      );
    }

    return child;
  }
}
