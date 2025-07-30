// signup_page.dart: Kullanıcı kayıt işlemleri ve UserStore (geçici kullanıcı veritabanı) burada tutulur.
// UserStore: Kayıtlı kullanıcıları ve isimlerini saklar.

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'auth_service.dart';
import 'login_page.dart';

// UserStore: Kayıtlı kullanıcıları ve isimlerini saklar.
class UserStore {
  static final Map<String, String> users = {};
  static String? userName;
}
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
  bool _obscure = true;
  bool _obscureAgain = true;
  bool _isLoading = false;
  bool _agreement = false;

  void _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreement) {
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
                'Kullanıcı sözleşmesini kabul etmelisiniz!',
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
    setState(() => _isLoading = true);
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final name = _nameController.text.trim();
    UserStore.userName = name;

    await Future.delayed(const Duration(seconds: 1));

    // E-posta zaten kayıtlı mı kontrol et
    if (UserStore.users.containsKey(email)) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hata'),
          content: const Text('Bu e-posta ile zaten bir hesap var!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
      return;
    }

    // Kullanıcıyı kaydet
    UserStore.users[email] = password;
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
                      const SizedBox(height: 80),
                      const Text(
                        'Hoşgeldiniz',
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
                          controller: _nameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline, color: Colors.white54),
                            hintText: 'Ad Soyad',
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                          ),
                          validator: (v) => v != null && v.length > 2 ? null : 'Adınızı girin',
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined, color: Colors.white54),
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
                            prefixIcon: const Icon(Icons.lock_outline, color: Colors.white54),
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
                      const SizedBox(height: 18),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: TextFormField(
                          controller: _passwordAgainController,
                          style: const TextStyle(color: Colors.white),
                          obscureText: _obscureAgain,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline, color: Colors.white54),
                            hintText: 'Şifre Tekrar',
                            hintStyle: const TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 20),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureAgain ? Icons.visibility_off : Icons.visibility, color: Colors.white54),
                              onPressed: () => setState(() => _obscureAgain = !_obscureAgain),
                            ),
                          ),
                          validator: (v) => v == _passwordController.text ? null : 'Şifreler eşleşmiyor',
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Checkbox(
                            value: _agreement,
                            onChanged: (v) => setState(() => _agreement = v ?? false),
                            activeColor: Colors.red,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.white70, fontSize: 14),
                                children: [
                                  const TextSpan(text: 'Kullanıcı sözleşmesini '),
                                  TextSpan(
                                    text: 'okudum ve kabul ediyorum.',
                                    style: const TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                                  ),
                                  const TextSpan(text: ' Bu sözleşmeyi okuyarak devam ediniz lütfen.'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
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
                                onPressed: _register,
                                child: const Text('Şimdi Kaydol', style: TextStyle(fontSize: 18)),
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
                          const Text('Zaten bir hesabın var mı?', style: TextStyle(color: Colors.white70)),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size(0, 0)),
                            child: const Text('Giriş Yap!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
      width: 56,
      height: 56,
      child: Material(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: Center(
            child: Icon(icon, color: Colors.white, size: 32),
          ),
        ),
      ),
    );
  }
}