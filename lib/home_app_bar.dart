import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Option { profile, menu, sair, entrar }

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  HomeAppBar({Key key}) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(55);
}

class _HomeAppBarState extends State<HomeAppBar> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Option _selection;

  void _onSelected(Option option) {
    _selection = option;
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
          onPressed: () {},
        );
        break;
      case Option.sair:
        return FlatButton(
          child: Text(
            'sair',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {},
        );
      default:
    }
  }

  StreamBuilder userInfo(Option option) {
    if (option == Option.profile) {
      return StreamBuilder(
        stream: auth.authStateChanges(),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
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
      stream: auth.authStateChanges(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return PopupMenuButton<Option>(
              onSelected: _onSelected,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Option>>[
                const PopupMenuItem<Option>(
                  value: Option.sair,
                  child: Text('sair'),
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
