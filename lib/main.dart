import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project/models/Provider_Offset.dart';
import 'package:project/view/on_boarding_screen.dart';
import 'package:project/view/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controllers/authentication/provider_auth.dart';
import 'constants_languages.dart';
import 'locale_language/localization_delegate.dart';
import 'models/prograss_model_hud.dart';
import 'models/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    SharedPreferences.getInstance().then((prefs) {
      var darkModeOn = prefs.getBool('lightMode') ?? true;
      runApp(
        MultiProvider(
          providers:[
            ChangeNotifierProvider<AuthProvider>(
              create: (context) => AuthProvider(),
            ),
            ChangeNotifierProvider<ProviderOffset>(
              create: (context) => ProviderOffset(),
            ),
            ChangeNotifierProvider<prograssHud>(
              create: (context) => prograssHud(),
            ),
            ChangeNotifierProvider<ThemeProvider>(
              create: (_) => ThemeProvider(darkModeOn ? light : dark),
            ),

          ],
          child: MyApp(),
        ),
      );
    });

}

class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context,Locale locale){
    _MyAppState state=context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Locale _locale;
  void setLocale(Locale locale){
    setState(() {
      _locale=locale;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLocale().then((locale) {
      setState(() {
        this._locale=locale;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeProvider>(context);

    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
        theme: themeNotifier.getTheme(),
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          OnBoardingScreen.id: (context) => OnBoardingScreen(),
        },
      locale: _locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalization.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ar', 'EG'),
        const Locale('fr', 'FR'),
      ],
      localeResolutionCallback: (currentLocale,supportedLocales){
        if(currentLocale != null){
          for(Locale locale in supportedLocales){
            if(currentLocale.languageCode==locale.languageCode ){
              return currentLocale;
            }
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
