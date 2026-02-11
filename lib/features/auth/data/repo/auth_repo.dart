import 'dart:io';

import 'package:im_legends/core/models/user_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  Future<AuthResponse> signUp({
    required final UserData userData,
    required final String password,
    final File? profileImage,
  });

  Future<AuthResponse> login({
    required final String email,
    required final String password,
  });

  Future<void> logout();

  Future<UserData?> getUserDataById(final String uid);
}
