import 'package:appwrite/appwrite.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:demotodoflutter_sdk3/data/model/user_model.dart';
import 'package:demotodoflutter_sdk3/res/routes.gr.dart' as route;
import 'package:demotodoflutter_sdk3/data/services/api_service.dart';
import 'package:demotodoflutter_sdk3/widget/textFormField_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final router = AutoRouter.of(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.indigo.withOpacity(0.6),
      body: Form(
        key: _globalKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
          ),
          child: ListView(
            children: [
              SizedBox(
                height: size.height * 0.09,
              ),
              Container(
                height: size.height * 0.3,
                width: size.width,
                child: SvgPicture.asset('assets/four.svg'),
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              textFormField(
                textColor: Colors.white,
                controller: _email,
                validator: (val) {
                  if (val!.isEmpty) return 'Email can\'t be empty';
                  return null;
                },
                hintText: 'enter your full name',
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              textFormField(
                textColor: Colors.white,
                obscureText: true,
                validator: (val) {
                  if (val!.isEmpty) return 'Password can\'t be empty';
                  if (val.length < 8) return 'Password length is not matched';
                  return null;
                },
                controller: _password,
                hintText: 'enter your password',
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: size / 9,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      primary: Colors.red,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  onPressed: () async {
                    var email = _email.text;
                    var password = _password.text;
                    late User user;
                    if (true) {
                      try {
                        await ApiService.instance
                            .login(email: email, password: password)
                            .then((value) async =>
                                user = await ApiService.instance.getUser());

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Welcome"),
                          ),
                        );
                        _password.clear();
                        _email.clear();
                        router.replaceAll([route.HomeRoute(user: user)]);
                      } on AppwriteException catch (e) {
                        print(e);
                        _password.clear();
                        _email.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.message.toString()),
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Login')),
              SizedBox(
                height: size.height * 0.04,
              ),
              TextButton(
                onPressed: () => router.push(const route.SignUpRoute()),
                child: Text(
                  'Don\'t have an account?  SignUp',
                  style: TextStyle(
                    color: Color(Colors.grey.value),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
