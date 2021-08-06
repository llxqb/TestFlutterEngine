import 'package:flutter/material.dart';

import 'b.dart';
import 'jump_router.dart';

class APage extends StatelessWidget {
  static final String routerName = '/APage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
          onTap: () {
            // JumpPage.pushPage(context, BPage());
            JumpPage.pushRouter(context, BPage.routerName);
          },
          child: Text('APage'),
      )),
    );
  }
}
