import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/data/models/leave_request/leave_type.dart';
import 'package:flutter/material.dart';

class LeaveTypeSelector extends StatefulWidget {
  final List<LeaveTypeModel> leaveTypes;
  final Function(LeaveTypeModel) onLeaveTypeSelected;
  final LeaveTypeModel? selectedType;

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
  LeaveTypeModel? selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = widget.selectedType;
    // Call callback immediately if there's a default selection
    if (selectedType != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onLeaveTypeSelected(selectedType!);
      });
    }
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
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextstyle(
                text: 'Leave Types',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textTheme.bodyMedium?.color ??
                      Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
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
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: AppTextstyle(
                        text: leaveType.name,
                        style: appStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            size: 14,
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
