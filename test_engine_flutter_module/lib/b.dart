import 'package:flutter/material.dart';

import 'c.dart';
import 'jump_router.dart';

class BPage extends StatelessWidget{
  static final String routerName = '/BPage';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
            onTap: () {
              // JumpPage.pushPage(context, CPage());
              JumpPage.pushRouter(context, CPage.routerName);
            },
            child: Text('BPage'),
          )),
    );
  }
}