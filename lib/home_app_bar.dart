import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';

enum Option { profile, menu, sair, entrar }

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  HomeAppBar({Key key}) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(55);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _onSelected(Option option) {
    if (option == Option.sair) {
      _signOut();
    }
  }

  void _signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }

  void _signIn() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
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

  FlatButton entrarSair(Option option) {
    switch (option) {
      case Option.entrar:
        return FlatButton(
          child: Text(
            'Entrar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: _signIn,
        );
        break;
      case Option.sair:
        return FlatButton(
          child: Text(
            'Sair',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: _signOut,
        );
      default:
        return FlatButton(
          child: Text(''),
          onPressed: () {},
        );
    }
  }

  StreamBuilder userInfo(Option option) {
    if (option == Option.profile) {
      return StreamBuilder(
        stream: _auth.authStateChanges(),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final User user = snapshot.data;
              final photoUrl = user.photoURL;
              return Image.network(photoUrl);
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
            return PopupMenuButton<Option>(
              onSelected: _onSelected,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Option>>[
                PopupMenuItem<Option>(
                  value: Option.sair,
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
            return entrarSair(Option.entrar);
          }
        }
        return entrarSair(Option.entrar);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: userInfo(Option.profile),
      title: Text('Início'),
      actions: [
        userInfo(Option.menu),
      ],
    );
  }
}
