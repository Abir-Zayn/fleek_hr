import 'package:flutter/material.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';

class LeaveAttachmentField extends StatelessWidget {
  final String? attachmentPath;
  final VoidCallback onTap;

  const LeaveAttachmentField({
    super.key,
    this.attachmentPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextstyle(
          text: 'Attachment (Optional)',
          style: appStyle(
              color: Colors.black, size: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.attach_file),
                SizedBox(width: 8),
                Text(
                  attachmentPath ?? 'Add supporting document (optional)',
                  style: TextStyle(
                    color: attachmentPath == null ? Colors.grey : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
