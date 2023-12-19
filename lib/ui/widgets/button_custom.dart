import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class FilledButtonCustom extends StatelessWidget {
  final double width;
  final double height;
  final String label;
  final Function onTap;
  
  const FilledButtonCustom({
    super.key, 
    required this.width, 
    required this.height, 
    required this.label, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: greenColor.withOpacity(0.5), // Adjust the opacity as needed
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3)
            ),
          ],
        ),

        child: TextButton(
          onPressed: () => onTap(),
          style: TextButton.styleFrom(
            backgroundColor: greenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            label,
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
      ),
    );
  }
}

class TextButtonCustom extends StatelessWidget {
  final String label;
  final Function onTap;

  const TextButtonCustom({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTap(),

      child: Text(
        label,
        style: greyTextStyle.copyWith(
          fontSize: 16,
          fontWeight: medium,
        ),
      ),
    );
  }
}

class SmallButtonCustom extends StatelessWidget {
  final double paddingX;
  final double paddingY;
  final String label;
  final Function onTap;

  const SmallButtonCustom({
    super.key,
    required this.paddingX,
    required this.paddingY,
    required this.label,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingX, vertical: paddingY),
      decoration: BoxDecoration(
        color: greyColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Text(
        label,
        style: blackTextStyle.copyWith(
            fontSize: 14,
            fontWeight: semiBold
        ),
      ),
    );
  }
}