import 'package:flutter/material.dart';
import 'package:reddit/features/dash_board/home_screen.dart';
import 'package:routemaster/routemaster.dart';

import 'features/auth/screens/signin_screen.dart';

// named routes, routes array, flutter navigation 2.0
const String splashScreen = '/splash';
const String masterScreen = '/';
final loggedOutRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: SignInScreen()),
  },
);


final loggedInRoute = RouteMap(routes: {
  '/' : (_) => const MaterialPage(child: HomeScreen()),
});