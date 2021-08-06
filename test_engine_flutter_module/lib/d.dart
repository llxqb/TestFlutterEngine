import 'package:flutter/material.dart';
import 'package:test_engine_flutter_module/splash_page.dart';

import 'a.dart';
import 'b.dart';
import 'jump_router.dart';

class DPage extends StatelessWidget{
  static final String routerName = '/DPage';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
            onTap: () {
              //移除 除A 其它的页面
              // JumpPage.removeAllOutTargetPage(context, APage());

              ///重点：跳转到APage ，并移除除SplashPage外其它页面
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => APage()),
                  ModalRoute.withName(SplashPage.routerName));
            },
            child: Text('DPage'),
          )),
    );
  }
}