import 'package:flutter/material.dart';

import 'd.dart';
import 'jump_router.dart';

class CPage extends StatelessWidget{
  static final String routerName = '/CPage';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
            onTap: () {
              // JumpPage.pushPage(context, DPage());
              JumpPage.pushRouter(context, DPage.routerName);
            },
            child: Text('CPage'),
          )),
    );
  }
}