import 'package:flutter/material.dart';

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
  });

  final bool? isLoading;
  final bool? isError;
  final bool? isEmpty;
  final Widget? loadingView;
  final Widget? errorView;
  final Widget? emptyView;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isLoading ?? false) {
      return loadingView ?? const Center(child: CircularProgressIndicator());
    }

    if (isError ?? false) {
      return errorView ?? const Center(child: Text("Error"));
    }

    if (isEmpty ?? false) {
      return emptyView ?? const Center(child: Text("No Data"));
    }

    return child;
  }
}
