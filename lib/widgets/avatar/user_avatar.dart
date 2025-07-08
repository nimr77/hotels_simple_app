import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,

      child: Hero(
        tag: "user_avatar",
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset("assets/images/member1.jpg"),
        ),
      ),
    );
  }
}
