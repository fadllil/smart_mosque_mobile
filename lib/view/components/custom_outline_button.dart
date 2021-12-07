import 'package:flutter/material.dart';
import 'package:smart_mosque/constants/themes.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    Key? key,
    required this.label,required this.onPressed,required this.color

  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: OutlinedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius))),
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor:
            MaterialStateProperty.all(Colors.white),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: color)
          )
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: color),
        ),
      ),
    );
  }
}