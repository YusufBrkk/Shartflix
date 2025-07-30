// register_page.dart: Kullanıcı kayıt ekranı.
// Yeni kullanıcı oluşturmak için form içerir.

import 'package:flutter/material.dart';
import 'login_page.dart';

// RegisterPage: Kullanıcı kayıt widget'ı.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController = TextEditingController();
  bool _isLoading = false;
  bool _obscure = true;
  bool _obscureAgain = true;
  bool _accepted = false;

  // _register: Kayıt işlemini başlatır, doğrulama ve hata mesajları gösterir.
  void _register() async {
    if (!_formKey.currentState!.validate() || !_accepted) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  const Text(
                    'Hoşgeldiniz',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tempus varius a vitae interdum id tortor elementum tristique eleifend at.',
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.white54),
                        hintText: 'Ad Soyad',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                      ),
                      validator: (v) => v != null && v.length > 2 ? null : 'Adınızı girin',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.white54),
                        hintText: 'E-Posta',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                      ),
                      validator: (v) => v != null && v.contains('@') ? null : 'Geçerli email girin',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(16),
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
                        contentPadding: const EdgeInsets.symmetric(vertical: 18),
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: Colors.white54),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (v) => v != null && v.length >= 6 ? null : 'En az 6 karakter',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextFormField(
                      controller: _passwordAgainController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: _obscureAgain,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: Colors.white54),
                        hintText: 'Şifre Tekrar',
                        hintStyle: const TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 18),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureAgain ? Icons.visibility_off : Icons.visibility, color: Colors.white54),
                          onPressed: () => setState(() => _obscureAgain = !_obscureAgain),
                        ),
                      ),
                      validator: (v) => v != null && v == _passwordController.text ? null : 'Şifreler eşleşmiyor',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _accepted,
                        onChanged: (v) => setState(() => _accepted = v ?? false),
                        activeColor: Colors.red,
                      ),
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                            children: [
                              TextSpan(text: 'Kullanıcı sözleşmesini '),
                              TextSpan(text: 'okudum ve kabul ediyorum.', style: TextStyle(decoration: TextDecoration.underline)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.red)
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                            ),
                            onPressed: _register,
                            child: const Text('Şimdi Kaydol', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SocialButton(icon: Icons.g_mobiledata),
                      const SizedBox(width: 16),
                      _SocialButton(icon: Icons.apple),
                      const SizedBox(width: 16),
                      _SocialButton(icon: Icons.facebook),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Zaten bir hesabın var mı?', style: TextStyle(color: Colors.white70)),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text('Giriş Yap!', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      ),
                    ],
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

class _SocialButton extends StatelessWidget {
  final IconData icon;
  const _SocialButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}
