import 'package:flutter/material.dart';
dynamic bottomSheet(BuildContext context,Widget children,{Color? color})=>showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: color??Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
  ),
  builder: (context)=>Container(
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        children,
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
      ],
    ),
  )
);