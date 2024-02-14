import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/core/models/user_model.dart';
import 'package:reddit/features/auth/repository/auth_repository.dart';

import '../../../core/utils/show_snack_bar.dart';

// saves and provides userModelData gotten from database
final userModelProvider = StateProvider<UserModel?>((ref) => null);
final authStateChangeProvider = StreamProvider((ref) {
  return ref.watch(authControllerProvider.notifier).authStateChange;
});
final userDataProvider = StreamProvider.family(
    (ref, String uid) => ref.watch(authControllerProvider.notifier).getUserData(uid));

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.read(authRepositoryProvider),
    ref: ref,
  ),
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  // Auth state changes from AuthRepository provider/class
  Stream<User?> get authStateChange => _authRepository.authStateChange;

  Stream<UserModel> getUserData(String uid) => _authRepository.getUserData(uid);

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold(
      (failure) => showSnackBar(context, failure.message),
      // updates data in stateProvider
      (userModel) =>
          _ref.read(userModelProvider.notifier).update((state) => userModel),
    );
  }
}
