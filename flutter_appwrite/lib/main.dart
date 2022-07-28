//wael.kokaz@gmail.com
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demotodoflutter_sdk3/data/model/user_model.dart';
import 'package:demotodoflutter_sdk3/data/services/api_service.dart';
import 'package:demotodoflutter_sdk3/pages/auth_page/loginPage.dart';
import 'package:demotodoflutter_sdk3/pages/pages_view/homePage.dart';
import 'res/routes.gr.dart';

final _appRouter = AppRouter();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      title: 'Easyone',
      debugShowCheckedModeBanner: false,
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: ApiService.instance.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SplashPage();
          if (snapshot.hasData && snapshot.data!.id != '133') {
            return HomePage(
              user: snapshot.data!,
            );
          }
          return LoginPage();
        });
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Text(
          "Loading...",
          style: TextStyle(
            color: Colors.white,
            fontSize: Theme.of(context).textTheme.headline6!.fontSize,
          ),
        ),
      ),
    );
  }
}
