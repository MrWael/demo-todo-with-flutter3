import 'package:flutter/material.dart';
import 'package:demotodoflutter_sdk3/data/model/user_model.dart';

// ignore: must_be_immutable
class ProfileView extends StatelessWidget {
  User user;
  ProfileView({
    required this.user,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            if (user != null) ...[
              Text(user.email),
              Text(user.name),
              if (user.prefs['photo'] != null) ...[],
            ],
          ],
        ),
      ),
    );
  }
}
