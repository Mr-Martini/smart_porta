import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_porta/dependency_injector.dart' show sl;
import 'package:smart_porta/features/core/failures/failure.dart';
import 'package:smart_porta/features/user_photo/presentation/bloc/user_photo_bloc.dart';

class UserPhotoAvatar extends StatelessWidget {
  const UserPhotoAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<UserPhotoBloc>()..add(UserPhotoGetPhoto()),
      child: Builder(
        builder: (context) {
          return BlocBuilder<UserPhotoBloc, UserPhotoState>(
            builder: (context, state) {
              if (state is UserPhotoLoaded) {
                return Tooltip(
                  message: "Profile photo",
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(state.url),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                );
              } else if (state is UserPhotoError) {
                final Failure failure = state.failure;

                if (failure is NoUserFailure) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Deslogado"),
                  );
                } else if (failure is NoPhotoUrlFailure) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: Icon(Icons.error),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Icon(Icons.person),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
