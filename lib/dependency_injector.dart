import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  registerFirebaseAuth();
  registerCloudFirestore();
}


void registerFirebaseAuth() {
  sl.registerSingleton(FirebaseAuth.instance);
}

void registerCloudFirestore() {
  sl.registerSingleton(FirebaseFirestore.instance);
}
