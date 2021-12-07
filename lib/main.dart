import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/service/api_interceptor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  locator<ApiInterceptors>();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: 'Smart Mosque',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          inputDecorationTheme: inputDecorationTheme,
          appBarTheme: AppBarTheme(
              backgroundColor: kPrimaryColor
          )
      ),
      builder: EasyLoading.init(),
    );
  }
}
