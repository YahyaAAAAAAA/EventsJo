import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/features/auth/domain/repos/auth_repo.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // check if auth
  void checkAuth() async {
    //loading...
    emit(AuthLoading(message: "Welcome Back"));

    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  //get current user
  AppUser? get currentUser => _currentUser;

  //login with email+pass
  Future<void> login(String email, String pw) async {
    try {
      //show loading state
      emit(AuthLoading(message: "Welcome Back"));

      //get user
      final user = await authRepo.loginWithEmailPassword(email, pw);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  //register with email+pass
  Future<void> regitser(
    String name,
    String email,
    String pw,
    double latitude,
    double longitude,
    UserType type,
    bool isOnline,
  ) async {
    try {
      //show loading state
      emit(AuthLoading(message: "Welcome to EventsJo"));

      //get user
      final user = await authRepo.registerWithEmailPassword(
          name, email, pw, latitude, longitude, type, isOnline);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  //logout
  Future<void> logout(String id, UserType userType) async {
    emit(AuthLoading(message: "Logging Out"));

    await authRepo.logout(id, userType);

    emit(Unauthenticated());
  }
}
