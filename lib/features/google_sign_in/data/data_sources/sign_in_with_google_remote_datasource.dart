import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_porta/features/core/exceptions/exceptions.dart';
import 'package:smart_porta/features/google_sign_in/data/models/sign_in_with_google_model.dart';

abstract class SignInWithGoogleRemoteDataSource {
  Future<SignInWithGoogleModel> signIn();
}

class SignInWithGoogleRemoteDataSourceImpl
    implements SignInWithGoogleRemoteDataSource {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth auth;

  SignInWithGoogleRemoteDataSourceImpl({
    required this.googleSignIn,
    required this.auth,
  });

  @override
  Future<SignInWithGoogleModel> signIn() async {
    final GoogleSignInAccount? user = googleSignIn.currentUser;

    if (user != null) {
      await googleSignIn.signOut();
      await auth.signOut();
    }

    final GoogleSignInAccount? account = await googleSignIn.signIn();

    if (account == null) throw SignInCanceledException();

    final GoogleSignInAuthentication authentication =
        await account.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );

    await auth.signInWithCredential(credential);

    return SignInWithGoogleModel();
  }
}
