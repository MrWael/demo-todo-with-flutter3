// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../data/model/addData_model.dart' as _i9;
import '../data/model/user_model.dart' as _i8;
import '../main.dart' as _i1;
import '../pages/auth_page/loginPage.dart' as _i3;
import '../pages/auth_page/signupPage.dart' as _i4;
import '../pages/pages_view/homePage.dart' as _i2;
import '../pages/pages_view/showDetailPage.dart' as _i5;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainPage());
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.HomePage(key: args.key, user: args.user));
    },
    LoginRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.LoginPage());
    },
    SignUpRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.SignUpPage());
    },
    ShowDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ShowDetailRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.ShowDetailPage(addData: args.addData, user: args.user));
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(MainRoute.name, path: '/'),
        _i6.RouteConfig(HomeRoute.name, path: '/home-page'),
        _i6.RouteConfig(LoginRoute.name, path: '/login-page'),
        _i6.RouteConfig(SignUpRoute.name, path: '/sign-up-page'),
        _i6.RouteConfig(ShowDetailRoute.name, path: '/show-detail-page')
      ];
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i6.PageRouteInfo<void> {
  const MainRoute() : super(MainRoute.name, path: '/');

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i6.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({_i7.Key? key, required _i8.User user})
      : super(HomeRoute.name,
            path: '/home-page', args: HomeRouteArgs(key: key, user: user));

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key, required this.user});

  final _i7.Key? key;

  final _i8.User user;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login-page');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.SignUpPage]
class SignUpRoute extends _i6.PageRouteInfo<void> {
  const SignUpRoute() : super(SignUpRoute.name, path: '/sign-up-page');

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i5.ShowDetailPage]
class ShowDetailRoute extends _i6.PageRouteInfo<ShowDetailRouteArgs> {
  ShowDetailRoute({required _i9.AddData addData, required _i8.User user})
      : super(ShowDetailRoute.name,
            path: '/show-detail-page',
            args: ShowDetailRouteArgs(addData: addData, user: user));

  static const String name = 'ShowDetailRoute';
}

class ShowDetailRouteArgs {
  const ShowDetailRouteArgs({required this.addData, required this.user});

  final _i9.AddData addData;

  final _i8.User user;

  @override
  String toString() {
    return 'ShowDetailRouteArgs{addData: $addData, user: $user}';
  }
}
