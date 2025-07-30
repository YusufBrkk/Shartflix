// main.dart: Uygulamanın giriş noktası ve genel yapılandırma dosyasıdır.
// Firebase, Provider, Bloc, Localization ve tema ayarları burada yapılır.
// Tüm uygulama buradan başlatılır.

import 'package:flutter/material.dart'; // Flutter ana paket
import 'package:flutter_bloc/flutter_bloc.dart'; // Bloc state yönetimi
import 'package:provider/provider.dart'; // Provider state yönetimi
import 'package:flutter_localizations/flutter_localizations.dart'; // Çoklu dil desteği
import 'package:firebase_core/firebase_core.dart'; // Firebase başlatma
import 'package:firebase_crashlytics/firebase_crashlytics.dart'; // Hata raporlama
import 'package:firebase_analytics/firebase_analytics.dart'; // Analytics

import 'features/auth/login_page.dart'; // Giriş ekranı
import 'features/movie/domain/get_movies_usecase.dart'; // Film usecase
import 'features/movie/data/movie_repository_impl.dart'; // Film repository
import 'features/movie/presentation/bloc/movie_bloc.dart'; // Film Bloc
import 'features/auth/auth_service.dart'; // Auth servis
import 'core/theme/app_theme.dart'; // Tema
import 'core/navigation/navigation_service.dart'; // Navigation servis
import 'l10n/app_localizations.dart'; // Localization
import 'features/auth/profile_image_provider.dart'; // Profil fotoğrafı provider

// LocaleProvider: Uygulamanın aktif dilini yönetir. Dil değişikliği için kullanılır.
class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;
  void setLocale(Locale locale) {
    if (!['en', 'tr'].contains(locale.languageCode)) return;
    _locale = locale;
    notifyListeners(); // Dil değişince arayüzü günceller
  }
}

// main(): Uygulamanın başlangıç fonksiyonu. Firebase başlatılır, hata yakalama ve provider/bloc yapılandırılır.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter motorunu başlatır
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDzpOmxw4OtVW8YrwFtvdXQyqsSNWLaT6E",
      authDomain: "shartflix-cc822.firebaseapp.com",
      projectId: "shartflix-cc822",
      storageBucket: "shartflix-cc822.appspot.com",
      messagingSenderId: "491884039896",
      appId: "1:491884039896:web:5f962c4f7f2ac9ce2e11ad",
      measurementId: "G-HKWXBPKS9W",
    ),
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError; // Hataları Crashlytics'e gönderir
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileImageProvider()), // Profil fotoğrafı yönetimi
        ChangeNotifierProvider(create: (_) => LocaleProvider()), // Dil yönetimi
        // Diğer BlocProvider'lar...
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MovieBloc>(create: (_) => MovieBloc(GetMoviesUseCase(MovieRepositoryImpl()))), // Film state yönetimi
          // Diğer BlocProvider'lar...
        ],
        child: const MyApp(), // Ana uygulama widget'ı
      ),
    ),
  );
}

// MyApp: Uygulamanın ana widget'ı. Tema, dil, navigation ve ilk açılış sayfası burada ayarlanır.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance; // Analytics nesnesi

  // _getInitialPage: Uygulama açıldığında gösterilecek ilk sayfa (LoginPage)
  Future<Widget> _getInitialPage() async {
    return const LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return MaterialApp(
          title: 'Shartflix', // Uygulama başlığı
          debugShowCheckedModeBanner: false, // Debug etiketi kapalı
          theme: AppTheme.lightTheme, // Uygulama teması
          navigatorKey: NavigationService().navigatorKey, // Navigation yönetimi
          navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)], // Analytics gözlemcisi
          locale: localeProvider.locale, // Aktif dil
          localizationsDelegates: [
            AppLocalizations.delegate, // Uygulama çevirileri
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('tr'),
          ],
          home: FutureBuilder<Widget>(
            future: _getInitialPage(), // İlk açılışta login sayfası
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Yükleniyor göstergesi
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasError) {
                // Hata mesajı
                return Scaffold(
                  body: Center(
                    child: Text(
                      'Bir hata oluştu: \n${snapshot.error}',
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                // Giriş başarılıysa AuthGate ile yönlendirme
                return AuthGate(child: snapshot.data!);
              }
              // Varsayılan olarak login sayfası
              return const LoginPage();
            },
          ),
        );
      },
    );
  }
}

// AuthGate: Kullanıcı giriş kontrolü sağlar. Eğer kullanıcı giriş yapmamışsa LoginPage'a yönlendirir.
class AuthGate extends StatelessWidget {
  final Widget child;
  const AuthGate({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: AuthService().getToken(), // Token kontrolü
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Yükleniyor göstergesi
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final token = snapshot.data;
        // Eğer token yoksa, sadece LoginPage ve RegisterPage'a izin ver
        if (token == null || token.isEmpty) {
          if (child is LoginPage || child.runtimeType.toString().contains('RegisterPage')) {
            return child;
          } else {
            return const LoginPage();
          }
        }
        // Token varsa, istenen sayfaya izin ver
        return child;
      },
    );
  }
}
