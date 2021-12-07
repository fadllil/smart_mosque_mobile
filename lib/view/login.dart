import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/blocs/auth/authentication_cubit.dart';
import 'package:smart_mosque/blocs/login/login_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/assets.dart';
import 'package:smart_mosque/constants/strings.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/view/components/custom_form.dart';

import 'components/custom_button.dart';

class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<AuthenticationCubit>()..appStarted(),
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, stete){
          return LoginForm();
        },
      ),
    );
  }
}

class LoginForm extends StatefulWidget{
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  TextEditingController? username;
  TextEditingController? password;
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
    _obscure = true;
  }

  @override
  void dispose() {
    super.dispose();
    username?.dispose();
    password?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<LoginCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<LoginCubit,LoginState>(
          listener: (context,state){
            if(state is LoginLoading){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if(state is LoginFailure){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message!);
            }else if(state is LoginSuccess){
              EasyLoading.dismiss();
              AutoRouter.of(context).pushAndPopUntil(SplashScreenRoute(), predicate: (route)=>false);
            }
          },
          builder:(context,state)=> SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.appName,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                  Text(
                    Strings.tagLine,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.asset(Assets.loginAsset),
                  ),
                  CustomForm(
                    label: Strings.username,
                    child: TextFormField(
                      controller: username,
                      decoration: InputDecoration(hintText: Strings.username),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomForm(
                    label: Strings.password,
                    child: TextFormField(
                      controller: password,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        hintText: Strings.password,
                        suffixIcon: _obscure
                            ? InkWell(
                          onTap: () {
                            _obscure = !_obscure;
                            setState(() {});
                          },
                          child: Icon(Icons.visibility_off),
                        )
                            : InkWell(
                          onTap: () {
                            _obscure = !_obscure;
                            setState(() {});
                          },
                          child: Icon(Icons.visibility),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    label: Strings.login,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      context.read<LoginCubit>().login(
                          username!.text,  password!.text);
                    },
                    color: kSecondaryColor!,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
