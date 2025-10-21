import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:naila_pusing/models/user.dart';
import 'package:naila_pusing/utils/dummy_data.dart'; // <-- pastikan ada
import 'package:naila_pusing/screens/home_screen.dart';
import 'package:naila_pusing/screens/register_screen.dart';
import 'package:naila_pusing/screens/admin/admin_dashboard.dart'; // <-- pastikan ada

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String? savedEmail;
  String? savedPassword;
  String? savedName;

  User? loggedInUser;
  Widget? nextScreen;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedEmail = prefs.getString('email');
      savedPassword = prefs.getString('password');
      savedName = prefs.getString('name');
    });
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      await Future.delayed(const Duration(seconds: 1));

      // ✅ Login Admin
      if (_emailController.text == dummyAdminUser.email &&
          _passwordController.text == dummyAdminUser.password) {
        loggedInUser = dummyAdminUser;
        nextScreen = AdminDashboard(adminUser: loggedInUser!);
      }
      // ✅ Login User biasa dari SharedPreferences
      else if (savedEmail != null &&
          savedPassword != null &&
          _emailController.text == savedEmail &&
          _passwordController.text == savedPassword) {
        loggedInUser = User(
          savedEmail!,
          savedPassword!,
          savedName ?? '',
          DateTime.now(),
          role: 'user',
        );
        nextScreen = HomeScreen(user: loggedInUser!);
      }
      // ✅ Belum daftar
      else if (savedEmail == null || savedPassword == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Belum ada akun terdaftar! Silakan daftar dulu."),
            backgroundColor: Colors.pink,
          ),
        );
      }
      // ✅ Email / password salah
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email atau password salah!"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }

      // ✅ Jika login sukses
      if (loggedInUser != null && nextScreen != null && mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return nextScreen!;
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeInOut)),
                    ),
                    child: child,
                  );
                },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      }

      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF3F4),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Logo
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.withOpacity(0.3),
                          blurRadius: 25,
                          spreadRadius: 5,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.white, Colors.pink.shade50],
                          ),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.pink.shade100,
                                    Colors.pink.shade200,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(
                                Icons.face_retouching_natural,
                                size: 80,
                                color: Colors.pink,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Welcome Text
                  const Text(
                    "Welcome Back,",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Beautiful Soul!",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.pink.shade400,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.pink,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.pink,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.pink,
                        ),
                        onPressed: () {
                          setState(
                            () => _isPasswordVisible = !_isPasswordVisible,
                          );
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: _isLoading
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text("Logging in..."),
                              ],
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Register Redirect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Belum punya akun? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Daftar Sekarang",
                          style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Forgot Password
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur reset password belum tersedia!'),
                          backgroundColor: Colors.pink,
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.pink.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
