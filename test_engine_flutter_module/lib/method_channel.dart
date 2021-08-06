import 'dart:async';
import 'package:flutter/services.dart';


class ChannelMethod {
  String _name;
  MethodChannel _channel;

  /// 构造函数(与原生APP对接的渠道名称);
  ChannelMethod([channelName]){
    this._name = channelName??'com.pages.flutter.androidTest.demo';
    this._channel = MethodChannel(this._name);
  }

  /// 调用原生的APP的渠道方法(方法名，参数[invokeListMethod:需要是数组]);
  void call(String methodName,dynamic param){
    this._channel.invokeListMethod(methodName,param);
  }

  /// 调用原生的APP的渠道方法(方法名，参数[invokeListMethod:需要是数组]);
  void callMethod(String methodName,dynamic param){
    try {
      this._channel.invokeMethod(methodName, param);
    }on PlatformException catch (e) {//抛出异常
      // flutter: PlatformException(001, 进入异常处理, 进入flutter的trycatch方法的catch方法);
      print(e);
    }
  }

  /// 支持调函数原生的APP的渠道方法(方法名，参数，回调函数);   主动发起使用
  Future<void> callBack(String methodName,dynamic param,Function func) async {
    try {
      // methodName 为原生方法名,param为flutter调用原生方法传入的参数，await等待方法执行;
      final result = await this._channel.invokeMethod(methodName, param);
      // 如果原生方法执行回调传值给flutter，那下面的代码才会被执行;
      func(result);
    } on PlatformException catch (e) {//抛出异常
      // flutter: PlatformException(001, 进入异常处理, 进入flutter的trycatch方法的catch方法);
      print(e);
    }
  }

  /// 提供给原生APP调用的方法(给原生调用的方法名，回调函数);   等待回调使用
  callHandler(String methodName,Function func){
    this._channel.setMethodCallHandler((call) { // 原生APP调用flutter的方法;
      if (call.method == methodName) {
        var res = func(call.arguments);  // func(String)必须是async方法，返回Future;
        return res;
      } else {
        return null;
      }
    });
  }

}