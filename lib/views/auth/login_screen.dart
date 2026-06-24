import 'package:flutter/material.dart';
import '../admin/admin_dashboard_screen.dart';
import 'package:teefi/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 48),

              Image.asset(
                'assets/images/icon.png',
                height: 150,
                color: const Color(0xFFF2F7FF),
                colorBlendMode: BlendMode.modulate,
              ),

              const SizedBox(height: 12),

              const Text(
                'Teefi',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D5F9E),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Together for a better tomorrow',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFA0B4D0),
                ),
              ),

              const SizedBox(height: 40),

              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D5F9E),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter your phone number',
                  hintStyle: const TextStyle(color: Color(0xFFA0B4D0)),
                  prefixIcon: const Icon(Icons.phone_android, color: Color(0xFF5B9EF5)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFD8E8FA))),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFD8E8FA))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF5B9EF5))),
                ),
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D5F9E),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: const TextStyle(color: Color(0xFFA0B4D0)),
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF5B9EF5)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: const Color(0xFFA0B4D0),
                    ),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFD8E8FA))),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFD8E8FA))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF5B9EF5))),
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () async {
                    // التحقق من الحقول الفارغة قبل البدء بعملية تسجيل الدخول
                    if (_phoneController.text.isEmpty || _passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter phone and password'),
                        ),
                      );
                      return;
                    }

                    setState(() => _isLoading = true);

                    final authService = AuthService();
                    final result = await authService.login(
                      _phoneController.text,
                      _passwordController.text,
                    );

                    setState(() => _isLoading = false);

                    if (result['success']) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result['message'] ?? 'Login failed')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B9EF5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                '© 2024 Teefi Support. All rights reserved.',
                style: TextStyle(fontSize: 12, color: Color(0xFFA0B4D0)),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}