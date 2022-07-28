import 'package:auto_route/auto_route.dart';
import 'package:demotodoflutter_sdk3/main.dart';
import 'package:demotodoflutter_sdk3/pages/auth_page/loginPage.dart';
import 'package:demotodoflutter_sdk3/pages/auth_page/signupPage.dart';
import 'package:demotodoflutter_sdk3/pages/pages_view/homePage.dart';
import 'package:demotodoflutter_sdk3/pages/pages_view/profileView.dart';
import 'package:demotodoflutter_sdk3/pages/pages_view/showDetailPage.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: MainPage, initial: true),
    AutoRoute(page: HomePage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: SignUpPage),
    AutoRoute(page: ShowDetailPage),
  ],
)
class $AppRouter {}
