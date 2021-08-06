import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_engine_flutter_module/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter与原生交互',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("zh", "CH"),
        const Locale("en", "US"),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: RouterDn.routes,
      initialRoute: RouterDn.initRouter,
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

