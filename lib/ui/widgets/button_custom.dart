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
  final double? customFontSize;

  const SmallButtonCustom({
    super.key,
    required this.paddingX,
    required this.paddingY,
    required this.label,
    this.customFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingX, vertical: paddingY),
      decoration: BoxDecoration(
        color: greenColor.withOpacity(0.95),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Text(
        label,
        style: blackTextStyle.copyWith(
            fontSize: customFontSize ?? 14,
            fontWeight: semiBold
        ),
      ),
    );
  }
}

class CategoryButtonCustom extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryButtonCustom({super.key, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,

      decoration: BoxDecoration(
          color: isSelected ? greenColor : whiteColor,
          borderRadius: BorderRadius.circular(20)
      ),

      child: Center(
        child: Text(
          label,
          style: blackTextStyle.copyWith(
              fontSize: 14,
              fontWeight: isSelected ? semiBold : medium
          ),
        ),
      ),
    );
  }
}

class MenuButtonCutom extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onTap;


  const MenuButtonCutom({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 70,
            height: 70,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),

            child: Center(
              child: Icon(
                icon,
                size: 30,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Text
          Text(
            label,
            style: blackTextStyle.copyWith(
                fontSize: 13,
                fontWeight: medium
            ),
          )
        ],
      ),
    );
  }
}
