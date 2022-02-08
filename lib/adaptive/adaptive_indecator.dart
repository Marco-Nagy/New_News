import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_api/cubit/app_cubit.dart';

class AdaptiveIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => buildAdaptive(context);

  buildAdaptive(context) {
    if (defaultTargetPlatform == Platform.isAndroid ||
        defaultTargetPlatform == Platform.isWindows)
      return CircularProgressIndicator(
        color: Theme
            .of(context)
            .canvasColor,
      );
    return Theme(data: ThemeData(cupertinoOverrideTheme: CupertinoThemeData(
        brightness:AppCubit.get(context).isDark? Brightness.dark:Brightness.light)),
        child: CupertinoActivityIndicator());

  }
}
