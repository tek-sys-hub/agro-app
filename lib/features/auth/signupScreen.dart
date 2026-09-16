import 'package:flutter/material.dart';
import '../../core/theme/appColors.dart';
import '../../core/widgets/mainNavigationScaffold.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainNavigationScaffold()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Bar with back button and language
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.language_rounded, size: 16, color: AppColors.primary),
                        SizedBox(width: 4),
                        Text(
                          'English',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.primary),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // AgroSmart Logo
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15), width: 2),
                      ),
                      child: const Icon(
                        Icons.eco_rounded,
                        color: AppColors.primary,
                        size: 34,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'AgroSmart',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Join thousands of farmers growing\nsmarter every day.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Heading
              const Row(
                children: [
                  Text(
                    'Create Your Account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text('🌱', style: TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Let\'s get you started on your smart farming journey.',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 20),

              // Full Name
              const Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your full name',
                  prefixIcon: Icon(Icons.person_outline_rounded, color: AppColors.textMuted, size: 20),
                ),
              ),

              const SizedBox(height: 16),

              // Email Address
              const Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your email address',
                  prefixIcon: Icon(Icons.mail_outline_rounded, color: AppColors.textMuted, size: 20),
                ),
              ),

              const SizedBox(height: 16),

              // Password
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Create a password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textMuted, size: 20),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Min. 8 characters with letters and numbers',
                style: TextStyle(fontSize: 11, color: AppColors.textMuted),
              ),

              const SizedBox(height: 14),

              // Confirm Password
              const Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  hintText: 'Confirm your password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textMuted, size: 20),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Terms and Conditions checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _agreeToTerms,
                      activeColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      onChanged: (val) {
                        setState(() {
                          _agreeToTerms = val ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'I agree to the ',
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        children: [
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Sign Up Button
              ElevatedButton(
                onPressed: _onSignUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),

              const SizedBox(height: 18),

              // Divider
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.border)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'or continue with',
                      style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.border)),
                ],
              ),

              const SizedBox(height: 18),

              // Google Button
              OutlinedButton(
                onPressed: _onSignUp,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.g_mobiledata_rounded, color: Colors.red, size: 22),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Continue with Google',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Already have an account? Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
