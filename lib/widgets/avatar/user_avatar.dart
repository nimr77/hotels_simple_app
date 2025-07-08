import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserAvatarWidget extends StatelessWidget {
  final double size;
  const UserAvatarWidget({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,

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
