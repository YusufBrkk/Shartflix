// login_page.dart: Kullanıcı giriş ekranı.
// E-posta ve şifre ile giriş yapılır. Kayıtlı kullanıcılar UserStore'da tutulur.

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'auth_service.dart';
import 'signup_page.dart' as signup;

// LoginPage: Kullanıcı giriş widget'ı.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscure = true;

  // _login: Giriş işlemini başlatır, doğrulama ve hata mesajları gösterir.
  void _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    // Kayıtlı kullanıcılar UserStore'da tutuluyor
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    await Future.delayed(const Duration(seconds: 1));

    if (!signup.UserStore.users.containsKey(email)) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              const Text(
                'Bu kullanıcı kayıtlı değil!',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tamam', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
      return;
    }

    if (signup.UserStore.users[email] != password) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              const Text(
                'Şifre yanlış!',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tamam', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
      return;
    }

    await AuthService().saveToken('dummy_token');
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 120),
                      const Text(
                        'Merhabalar',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Tempus varius a vitae interdum id\ntortor elementum tristique eleifend at.',
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 36),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.white54),
                            hintText: 'E-Posta',
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                          ),
                          validator: (v) => v != null && v.contains('@') ? null : 'Geçerli email girin',
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          style: const TextStyle(color: Colors.white),
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock, color: Colors.white54),
                            hintText: 'Şifre',
                            hintStyle: const TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 20),
                            suffixIcon: IconButton(
                              icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: Colors.white54),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                          validator: (v) => v != null && v.length >= 6 ? null : 'En az 6 karakter',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.grey[900],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                contentPadding: const EdgeInsets.all(24),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.info_outline, color: Colors.red, size: 48),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Bu özellik henüz aktif değil.',
                                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: const Text('Tamam', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size(0, 0)),
                          child: const Text('Şifremi unuttum', style: TextStyle(color: Colors.white70, fontSize: 13, decoration: TextDecoration.underline)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.red)
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                ),
                                onPressed: _login,
                                child: const Text('Giriş Yap', style: TextStyle(fontSize: 18)),
                              ),
                            ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _SocialButton(
                            icon: Icons.g_mobiledata,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.grey[900],
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                  contentPadding: const EdgeInsets.all(24),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.info_outline, color: Colors.red, size: 48),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Bu özellik henüz aktif değil.',
                                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('Tamam', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 24),
                          _SocialButton(
                            icon: Icons.apple,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.grey[900],
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                  contentPadding: const EdgeInsets.all(24),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.info_outline, color: Colors.red, size: 48),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Bu özellik henüz aktif değil.',
                                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('Tamam', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 24),
                          _SocialButton(
                            icon: Icons.facebook,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.grey[900],
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                  contentPadding: const EdgeInsets.all(24),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.info_outline, color: Colors.red, size: 48),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Bu özellik henüz aktif değil.',
                                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('Tamam', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Bir hesabın yok mu?', style: TextStyle(color: Colors.white70)),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const signup.RegisterPage()),
                              );
                            },
                            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size(0, 0)),
                            child: const Text('Kayıt Ol!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  const _SocialButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Material(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Center(
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}