import "package:flutter/material.dart";
import 'package:flutter/services.dart';

PreferredSizeWidget appBar(Widget title, List<Widget> listOfWidgets) {
  return AppBar(
    title: title,
    centerTitle: true,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
    actions: listOfWidgets,
  );
}
