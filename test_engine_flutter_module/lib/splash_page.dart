import 'package:flutter/material.dart';

import 'a.dart';
import 'jump_router.dart';
import 'method_channel.dart';

///启动页面
class SplashPage extends StatefulWidget {
  static final String routerName = '/SplashPage';

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  final mc = ChannelMethod();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          // child: showLoadingBox(lottie: true, center: true),
          child: InkWell(
        onTap: () {
          mc.call('update', {'update': "callHandler"});

          mc.callHandler("updateImage", (result) {
            String words = result['words'];
            String imgPath = result['imgPath'];
            print("=========imgPath=" + imgPath + " words=" + words);
          });
        },
        child: Container(
          width: 200,
          height: 100,
          color: Colors.red,
          child: Text(
            '主动发起回调',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    getChannelMethodData();

    ///不能在build到时候跳转页面，让他延迟一会会就行！
    // Future.delayed(Duration.zero, () {JumpPage.pushPage(context, APage()); });
    Future.delayed(Duration.zero, () {JumpPage.pushRouter(context, APage.routerName); });
  }

  getChannelMethodData() {
    //获取原生传递数据
    mc.callBack('sendDeviceId', '', (val) {
      //获取原生传递的唯一设备号;
      print('--->>>原生APP返回的设备号：$val <<<---');
    }).catchError((error) {});

    //主动发送数据给原生
    mc.call('getToken', {'token': "我是一个token"});
  }
}
