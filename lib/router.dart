import 'package:flutter/material.dart';
import 'package:joga_junto/features/auth/screens/login_screen.dart';
import 'package:joga_junto/features/auth/screens/signup_screen.dart';
import 'package:joga_junto/features/home/screen/home_screen.dart';
import 'package:joga_junto/features/team/screens/create_team_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
  '/sign-up': (_) => const MaterialPage(child: SignUpScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/create-team': (_) => const MaterialPage(child: CreateTeamScreen()),
});