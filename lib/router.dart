import 'package:flutter/material.dart';
import 'package:joga_junto/features/auth/screens/login_screen.dart';
import 'package:joga_junto/features/home/screen/home_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen())
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen())
});