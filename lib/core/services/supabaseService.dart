import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService._();

  static final SupabaseService instance = SupabaseService._();

  SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      if (kDebugMode) {
        print('Note: Could not load .env file: $e');
      }
    }

    final supabaseUrl = dotenv.env['SUPABASE_URL'];
    final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

    if (supabaseUrl == null || supabaseAnonKey == null) {
      throw Exception('Missing SUPABASE_URL or SUPABASE_ANON_KEY in .env file.');
    }

    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  // Sign Up with Email and save profile to Database table 'profiles'
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
    String? role,
    String? location,
  }) async {
    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName,
        'role': role,
        'location': location,
      },
    );

    final user = response.user;
    if (user != null) {
      try {
        await client.from('profiles').upsert({
          'id': user.id,
          'email': email,
          'full_name': fullName,
          'role': role,
          'location': location,
          'updated_at': DateTime.now().toIso8601String(),
        });
      } catch (e) {
        if (kDebugMode) {
          print('Database profile upsert warning: $e');
        }
      }
    }

    return response;
  }

  // Sign In with Email & Password
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Query User Profile from Supabase 'profiles' table
  Future<Map<String, dynamic>?> fetchUserProfile(String userId) async {
    try {
      final data = await client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();
      return data;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user profile: $e');
      }
      return null;
    }
  }

  // Query Commodity Market Prices from 'crop_market_prices'
  Future<List<Map<String, dynamic>>> fetchMarketPrices() async {
    try {
      final List<dynamic> response = await client
          .from('crop_market_prices')
          .select()
          .order('crop_name', ascending: true);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching market prices: $e');
      }
      return [];
    }
  }

  // Query Sensor Telemetry from 'sensor_readings'
  Future<Map<String, dynamic>?> fetchLatestSensorReading(String userId) async {
    try {
      final data = await client
          .from('sensor_readings')
          .select()
          .eq('user_id', userId)
          .order('recorded_at', ascending: false)
          .limit(1)
          .maybeSingle();
      return data;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching sensor reading: $e');
      }
      return null;
    }
  }

  // Query Recent Crop Scan History from 'ai_scan_history'
  Future<List<Map<String, dynamic>>> fetchScanHistory(String userId) async {
    try {
      final List<dynamic> response = await client
          .from('ai_scan_history')
          .select()
          .eq('user_id', userId)
          .order('scanned_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching scan history: $e');
      }
      return [];
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await client.auth.signOut();
  }

  User? get currentUser => client.auth.currentUser;
}
