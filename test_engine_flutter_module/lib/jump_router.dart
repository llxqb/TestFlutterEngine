import 'package:flutter/material.dart';

class JumpPage {
  /// 以下方法为类的静态方法,不需要类的实例化;
  /// -------------------------------------
  /// [context]渲染组件的为上下文,
  /// [routeName]是组件的路由名称,这里是路由名称的字符,不是一个组件对象,
  /// [param]是页面所传递的参数,是可选命名参数.
  static void pushRouter(BuildContext context, String routeName,{Object param}){ //普通路由的跳转推送;
    if(param != null){
      Navigator.of(context).pushNamed(routeName,arguments: param);
    }else{
      Navigator.of(context).pushNamed(routeName);
    }
  }
  /// 参数使用与pushRouter方法一致;
  static void pushReplaceRouter(BuildContext context, String routeName,{Object param}){ //替换路由的跳转推送;
    if(param != null){
      Navigator.of(context).pushReplacementNamed(routeName,arguments: param);
    }else{
      Navigator.of(context).pushReplacementNamed(routeName);
    }
  }
  ///[context]渲染组件的为上下文,
  ///[target]为组件对象,
  ///[callBack]为页面返回之后当前页面的刷新处理.
  static void refreshPage(BuildContext context,Widget target,Function callBack,[bool returnValue = false]) { //刷新当前页面的路由跳转;
    Navigator.push(context, MaterialPageRoute(builder: (context) => target)).then((rs){
      if(returnValue){
        callBack(rs);
      }else{
        callBack();
      }
    });
  }

  ///关闭
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  ///跳转
  static void pushPage(BuildContext context , Widget target) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => target));
  }

  ///跳转 替换之前页面
  static void pushReplacePage(BuildContext context , Widget target) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => target));
  }

  ///移除掉除目标target外其它的页面
  static void removeAllOutTargetPage(BuildContext context,Widget target){
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => target),
            (route) => route == null);
  }

  ///移除掉除目标target外其它的页面
  static void removeAllOutTargetPageRouter(BuildContext context, String routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => true);
  }

}
