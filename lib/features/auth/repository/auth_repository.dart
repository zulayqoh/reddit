import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit/core/constants/firebase_constants.dart';
import 'package:reddit/core/constants/image_path.dart';
import 'package:reddit/core/utils/failure.dart';
import 'package:reddit/core/models/user_model.dart';
import 'package:reddit/core/providers/firebase_providers.dart';
import 'package:reddit/core/utils/type_defs.dart';


final authRepositoryProvider = Provider<AuthRepository>(
      (ref) =>
      AuthRepository(
        firebaseAuth: ref.read(firebaseAuthProvider),
        googleSignIn: ref.read(googleSignInProvider),
        firestore: ref.read(firebaseFirestoreProvider),
      ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  })
      : _firestore = firestore,
        _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.users);

  // gets auth state changes
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  /// to return user's data
  FutureEither<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      final UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(credential);

      UserModel userModel;
      // setting up a new user with it's data in the database
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
            name: userCredential.user?.displayName ?? "",
            profilePic: userCredential.user?.photoURL ?? ImagePath.avatarDefault,
            banner: ImagePath.bannerDefault,
            uid: userCredential.user?.uid ?? "",
            isAuthenticated: true,
            karma: 0,
            awards: []);

        await _users.doc(userCredential.user?.uid).set(userModel.toJson());
      } else {
        // get existing user data as future from database
        userModel = await getUserData(userCredential.user!.uid).first;

    }
    return right(userModel); // case success
    } on FirebaseException catch (e) {
    throw e.message!;
    } catch (e) {
    return left(Failure(e.toString())); // returns Failure object
    }
  }

  /// get the existing user's data as stream
  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map((event) =>
        UserModel.fromJson(event.data() as Map<String, dynamic>),);
  }
}
