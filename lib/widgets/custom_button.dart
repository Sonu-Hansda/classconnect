import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final VoidCallback? ontap;
  const CustomButton(
      {super.key,
      this.backgroundColor,
      this.textColor,
      required this.text,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 18.0),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8.0,
              spreadRadius: 1.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
          color: backgroundColor,
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w200),
        ),
      ),
    );
  }
}
