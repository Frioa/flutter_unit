import 'package:flutter/material.dart';

void onPostFrame(VoidCallback callback, {Duration delay = Duration.zero}) {
  WidgetsBinding.instance!.addPostFrameCallback((_) {
    Future.delayed(delay, callback);
  });
}
