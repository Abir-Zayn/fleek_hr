import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/data/models/leave_request/leave_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveTypeSelector extends StatefulWidget {
  final List<LeaveType> leaveTypes;
  final Function(LeaveType) onLeaveTypeSelected;
  final LeaveType? selectedType;

  const LeaveTypeSelector({
    super.key,
    required this.leaveTypes,
    required this.onLeaveTypeSelected,
    this.selectedType,
  });

  @override
  State<LeaveTypeSelector> createState() => _LeaveTypeSelectorState();
}

class _LeaveTypeSelectorState extends State<LeaveTypeSelector> {
  late LeaveType selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = widget.selectedType ?? widget.leaveTypes.first;
  }

  @override
  void didUpdateWidget(LeaveTypeSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedType != null && widget.selectedType != selectedType) {
      selectedType = widget.selectedType!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextstyle(
                text: 'Leave Types',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Theme.of(context).textTheme.bodyMedium?.color ??
                      Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: widget.leaveTypes.map((leaveType) {
                  final isSelected = selectedType == leaveType;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedType = leaveType;
                      });
                      widget.onLeaveTypeSelected(leaveType);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: AppTextstyle(
                        text: leaveType.name,
                        style: appStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            size: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
