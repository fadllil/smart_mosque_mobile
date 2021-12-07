
import 'package:flutter/material.dart';
import 'package:smart_mosque/constants/themes.dart';

class HeadingTitle extends StatelessWidget {
  final String? title;
  final GestureTapCallback? onTap;
  const HeadingTitle({Key? key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title??'',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
          onTap==null?SizedBox():InkWell(
            onTap: onTap,
            child: Text('Selengkapnya',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: kPrimaryColor),),
          )
        ],
      ),
    );
  }
}
