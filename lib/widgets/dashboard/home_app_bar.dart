import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_porta/dependency_injector.dart';
import 'package:smart_porta/screens/home.dart';
import 'package:vrouter/vrouter.dart';

import '../../features/user_photo/presentation/widgets/user_photo_avatar.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  HomeAppBar({Key? key}) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(55);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final GoogleSignIn googleSignIn = sl.get<GoogleSignIn>();
  final FirebaseAuth _auth = sl.get<FirebaseAuth>();

  void _signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
    context.vRouter.push(WelcomeScreen.id);
  }

  void onSelected(int index) {
    switch (index) {
      case 0:
        _signOut();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: UserPhotoAvatar(),
      title: Text('Início'),
      actions: [
        PopupMenuButton(
          initialValue: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.more_vert),
          ),
          onSelected: onSelected,
          itemBuilder: (context) {
            return List.generate(
              1,
              (index) {
                return PopupMenuItem(
                  value: index,
                  child: Text("Sair"),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
