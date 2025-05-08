import 'package:flutter/material.dart';

class Statuscard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String status;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final List<Color>? gradientColors;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  const Statuscard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.date,
      required this.status,
      this.leadingIcon,
      this.trailingIcon,
      this.gradientColors = const [
        Color.fromARGB(255, 91, 165, 225),
        Color.fromARGB(255, 80, 51, 210),
      ],
      this.height,
      this.width,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 110,
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(15),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors!),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (leadingIcon != null)
                          Icon(
                            leadingIcon,
                            color: Colors.white,
                            size: 24,
                          ),
                        if (leadingIcon != null) const SizedBox(width: 12),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    if (trailingIcon != null)
                      Icon(
                        trailingIcon,
                        color: Colors.white,
                        size: 20,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
