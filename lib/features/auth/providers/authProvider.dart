import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/supabaseService.dart';

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String role;
  final String location;
  final String language;
  final bool isPro;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.location,
    required this.language,
    required this.isPro,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? location,
    String? language,
    bool? isPro,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      location: location ?? this.location,
      language: language ?? this.language,
      isPro: isPro ?? this.isPro,
    );
  }
}

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? errorMessage;
  final UserProfile user;

  const AuthState({
    required this.isAuthenticated,
    required this.isLoading,
    this.errorMessage,
    required this.user,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? errorMessage,
    UserProfile? user,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      user: user ?? this.user,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final SupabaseService _supabaseService = SupabaseService.instance;

  AuthNotifier()
      : super(
          const AuthState(
            isAuthenticated: false,
            isLoading: false,
            errorMessage: null,
            user: UserProfile(
              id: '',
              name: '',
              email: '',
              role: '',
              location: '',
              language: 'Nepali',
              isPro: false,
            ),
          ),
        ) {
    _checkInitialSession();
  }

  void _checkInitialSession() {
    final currentUser = _supabaseService.currentUser;
    if (currentUser != null) {
      final userMetadata = currentUser.userMetadata ?? {};
      state = state.copyWith(
        isAuthenticated: true,
        user: state.user.copyWith(
          id: currentUser.id,
          email: currentUser.email ?? '',
          name: userMetadata['full_name'] as String? ?? '',
          role: userMetadata['role'] as String? ?? 'Farmer',
          location: userMetadata['location'] as String? ?? 'Kathmandu, Nepal',
        ),
      );
      _loadProfileFromDatabase(currentUser.id);
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await _supabaseService.signIn(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user != null) {
        final userMetadata = user.userMetadata ?? {};
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
          user: state.user.copyWith(
            id: user.id,
            email: user.email ?? email,
            name: userMetadata['full_name'] as String? ?? '',
            role: userMetadata['role'] as String? ?? 'Farmer',
            location: userMetadata['location'] as String? ?? 'Kathmandu, Nepal',
          ),
        );
        await _loadProfileFromDatabase(user.id);
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Login failed. Please check credentials.',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
    String? role,
    String? location,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await _supabaseService.signUp(
        email: email,
        password: password,
        fullName: fullName,
        role: role,
        location: location,
      );

      final user = response.user;
      if (user != null) {
        // Automatically establish session if needed
        if (response.session == null) {
          try {
            await _supabaseService.signIn(email: email, password: password);
          } catch (_) {
            // Handled if session is created directly
          }
        }

        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
          user: state.user.copyWith(
            id: user.id,
            name: fullName,
            email: email,
            role: role ?? 'Farmer',
            location: location ?? 'Kathmandu, Nepal',
          ),
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Signup failed. Please try again.',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    }
  }

  Future<void> _loadProfileFromDatabase(String userId) async {
    final profileData = await _supabaseService.fetchUserProfile(userId);
    if (profileData != null) {
      state = state.copyWith(
        user: state.user.copyWith(
          name: profileData['full_name'] as String? ?? state.user.name,
          role: profileData['role'] as String? ?? state.user.role,
          location: profileData['location'] as String? ?? state.user.location,
          language: profileData['language'] as String? ?? state.user.language,
          isPro: profileData['is_pro'] as bool? ?? state.user.isPro,
        ),
      );
    }
  }

  Future<void> logout() async {
    await _supabaseService.signOut();
    state = state.copyWith(
      isAuthenticated: false,
      user: const UserProfile(
        id: '',
        name: '',
        email: '',
        role: '',
        location: '',
        language: 'Nepali',
        isPro: false,
      ),
    );
  }

  void setLanguage(String lang) {
    state = state.copyWith(
      user: state.user.copyWith(language: lang),
    );
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
