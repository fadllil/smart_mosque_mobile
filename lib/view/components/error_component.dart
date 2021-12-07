import 'package:flutter/material.dart';
import 'package:smart_mosque/constants/assets.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/view/components/custom_button.dart';

class ErrorComponent extends StatelessWidget {
  final String? message;
  final GestureTapCallback onPressed;
  const ErrorComponent({Key? key, this.message,required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GlobalKey<RefreshIndicatorState> _refresh = GlobalKey();
    return RefreshIndicator(
      key: _refresh,
      onRefresh: ()async=>onPressed,
      color: kPrimaryColor,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height*0.9,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.errorAssets,width: MediaQuery.of(context).size.width*0.7,),
              SizedBox(height: 10,),
              Text('$message'),
              SizedBox(height: 20,),
              CustomButton(label: 'Muat Ulang', onPressed: onPressed, color: kPrimaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
