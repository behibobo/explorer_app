import 'package:explorer/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:explorer/providers/auth.dart';
import 'package:explorer/splash.dart';

void main() {
  final navigatorKey = GlobalKey<NavigatorState>();
  runApp(
    ChangeNotifierProvider(
      builder: (context) => AuthProvider(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Router(),
          '/splash': (context) => Splash(),
        },
      ),
    ),
  );
}

class Router extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);
  
    return Consumer<AuthProvider>(
      builder: (context, user, child) {
        switch (user.status) {
          case Status.Uninitialized:
            return Splash();
          case Status.Unauthenticated:
            return Splash();
          case Status.Authenticated:
            return MainPage();
          default:
            return Splash();
        }
      },
    );
  }
}