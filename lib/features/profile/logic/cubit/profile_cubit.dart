import 'dart:io';

import 'package:bloc/bloc.dart';
import '../../../../core/error/models/app_error.dart';
import '../../../../core/error/types/error_type.dart';
import '../../data/model/profile_model.dart';
import 'package:meta/meta.dart';

import '../../data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  /// Fetch user profile with calculated stats
  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await profileRepo.getProfileWithStats();

      if (profile != null) {
        emit(ProfileSuccess(profile: profile));
      } else {
        emit(
          ProfileFailure(
            error: const AppError(
              messageKey: "Profile not found",
              type: ErrorType.unknown,
            ),
          ),
        );
      }
    } catch (error) {
      emit(
        ProfileFailure(error: error is AppError ? error : AppError.unknown()),
      );
    }
  }

  /// Uploads a profile image and updates the user's record in one step
  Future<void> uploadProfileImage(final File imageFile) async {
    try {
      emit(ProfileLoading());

      final newImageUrl = await profileRepo.uploadAndSetProfileImage(imageFile);

      if (newImageUrl != null) {
        await fetchProfile();
      } else {
        emit(
          ProfileFailure(
            error: const AppError(
              messageKey: "Failed to upload profile image",
              type: ErrorType.unknown,
            ),
          ),
        );
      }
    } catch (error) {
      emit(
        ProfileFailure(error: error is AppError ? error : AppError.unknown()),
      );
    }
  }
}
