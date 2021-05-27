import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:smart_porta/features/user_photo/presentation/widgets/user_photo_avatar.dart';

enum Options { profile, menu, sair, entrar }

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  HomeAppBar({Key? key}) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(55);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _onSelected(Options option) {
    if (option == Options.sair) {
      _signOut();
    }
  }

  void _signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }

  void _signIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) return;
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await _auth.signInWithCredential(credential);
    } on PlatformException catch (err) {
      print(err);
    } catch (err) {
      print(err);
    }
  }

  TextButton entrarSair(Options option) {
    switch (option) {
      case Options.entrar:
        return TextButton(
          child: Text(
            'Entrar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: _signIn,
        );
      case Options.sair:
        return TextButton(
          child: Text(
            'Sair',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: _signOut,
        );
      default:
        return TextButton(
          child: Text(''),
          onPressed: () {},
        );
    }
  }

  StreamBuilder userInfo(Options option) {
    if (option == Options.profile) {
      return StreamBuilder(
        stream: _auth.authStateChanges(),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final User user = snapshot.data;
              final photoUrl = user.photoURL;

              if (photoUrl == null) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                    backgroundColor: Colors.transparent,
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(photoUrl),
                  backgroundColor: Colors.transparent,
                ),
              );
            }
          }
          return Container();
        },
      );
    }
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return PopupMenuButton<Options>(
              onSelected: _onSelected,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
                PopupMenuItem<Options>(
                  value: Options.sair,
                  child: Text(
                    'Sair',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black54,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return entrarSair(Options.entrar);
          }
        }
        return entrarSair(Options.entrar);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: UserPhotoAvatar(),
      title: Text('Início'),
      actions: [
        userInfo(Options.menu),
      ],
    );
  }
}
