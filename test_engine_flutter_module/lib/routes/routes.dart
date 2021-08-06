import 'package:flutter/material.dart';

import '../a.dart';
import '../b.dart';
import '../c.dart';
import '../d.dart';
import '../splash_page.dart';

class RouterDn {
  static final String initRouter = SplashPage.routerName;

  static final Map<String, WidgetBuilder> routes = {
    SplashPage.routerName: (context) => SplashPage(), //首页(入口)
    APage.routerName: (context) => APage(), //APage
    BPage.routerName: (context) => BPage(), //BPage
    CPage.routerName: (context) => CPage(), //CPage
    DPage.routerName: (context) => DPage(), //DPage

  };

  static final RouteFactory generateRoute = (settings) {
    return null;
  };

  static final RouteFactory unknownRoute = (settings) {
    return null;
  };
}
