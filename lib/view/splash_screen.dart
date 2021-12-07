import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/blocs/auth/authentication_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/view/jamaah/home_jamaah.dart';
import 'package:smart_mosque/view/login.dart';
import 'package:smart_mosque/view/masjid/home_masjid.dart';
import 'package:smart_mosque/view/welcome_screen/WelcomeScreen.dart';

class SplashScreen extends StatelessWidget {
 const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocProvider(
    create: (_)=>locator<AuthenticationCubit>()..appStarted(),
    child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
     builder: (context, state){
      print(state);
      if (state is AuthenticationUnauthenticated){
       return WelcomeScreen();
      }else if (state is AuthenticationAuthenticated){
       if (state.role == "Masjid")
        return HomeMasjid();
       else if(state.role == "Jamaah")
        return HomeJamaah();
       else {
        EasyLoading.showError('Kredential anda tidak valid', duration: Duration(seconds: 2));
        return Login();
       }
      }else if (state is AuthenticationInitial||state is AuthenticationLoading){
       return Scaffold(
        body: Center(child: CircularProgressIndicator(),),
       );
      }else{
       return Scaffold(
        body: Center(child: CircularProgressIndicator(),),
       );
      }
     },
    ),
   );
  }
}