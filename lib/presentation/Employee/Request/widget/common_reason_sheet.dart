import 'package:fleekhr/data/service/wfh_req/wfh_api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


/// Bottom sheet displaying common WFH reasons
class CommonReasonsSheet {
  static void show({
    required BuildContext context,
    required Function(String) onReasonSelected,
  }) {
    final wfhApiService = WfhApiService();

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.doc_text,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "Common Reasons",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Divider(height: 24.h),
              FutureBuilder<List<String>>(
                future: wfhApiService.fetchWFHReqs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("Failed to load reasons"));
                  }
                  final reasons = snapshot.data ?? [];
                  return Expanded(
                    child: ListView.builder(
                      itemCount: reasons.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(
                            CupertinoIcons.text_quote,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text(reasons[index]),
                          onTap: () {
                            onReasonSelected(reasons[index]);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}