import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const ProfilePicture({
    super.key,
    required this.imageUrl,
    this.radius = 55,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 4.0,
        ),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,
        child: ClipOval(
          child: Image.network(
            imageUrl,
            width: radius * 2,
            height: radius * 2,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}