import 'package:flutter/material.dart';
import 'package:smart_mosque/constants/assets.dart';

class NoData extends StatelessWidget {
  final String? message;
  const NoData({Key? key,required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GlobalKey<RefreshIndicatorState> _refresh = GlobalKey();
    return Center(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        // height: MediaQuery.of(context).size.height*0.9,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.errorAssets,width: MediaQuery.of(context).size.width*0.7,),
            SizedBox(height: 10,),
            Text('$message'),
          ],
        ),
      ),
    );
  }
}
