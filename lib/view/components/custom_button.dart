import 'package:flutter/material.dart';
import 'package:smart_mosque/constants/themes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
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
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius))),
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor:
            MaterialStateProperty.all(color)),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}