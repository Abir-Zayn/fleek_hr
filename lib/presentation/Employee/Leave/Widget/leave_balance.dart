import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/data/models/leave_request/leave_type.dart';
import 'package:fleekhr/domain/entities/leave/employee_leave_balance.dart';
import 'package:fleekhr/presentation/Employee/Leave/cubit/leave_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaveBalanceDisplay extends StatefulWidget {
  final LeaveTypeModel? selectedLeaveType;

  const LeaveBalanceDisplay({
    super.key,
    this.selectedLeaveType,
  });

  @override
  State<LeaveBalanceDisplay> createState() => _LeaveBalanceDisplayState();
}

class _LeaveBalanceDisplayState extends State<LeaveBalanceDisplay> {
  @override
  void initState() {
    super.initState();
    _fetchLeaveBalance();
  }

  @override
  void didUpdateWidget(LeaveBalanceDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Refetch when selected leave type changes
    if (widget.selectedLeaveType != oldWidget.selectedLeaveType) {
      _fetchLeaveBalance();
    }
  }

  void _fetchLeaveBalance() {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId != null && userId.isNotEmpty) {
      print('Fetching leave balance for user: $userId');
      context.read<LeaveCubit>().getEmployeeLeaveBalance(userId);
    } else {
      print('No user ID found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveCubit, LeaveState>(
      builder: (context, state) {
        print('Current state: ${state.runtimeType}');

        if (state is LeaveLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LeaveBalanceLoaded) {
          print(
              'Leave balance loaded with ${state.leaveBalances.length} items');

          // Filter balance based on selected leave type
          List<EmployeeLeaveBalanceEntity> filteredBalances = [];

          if (widget.selectedLeaveType != null) {
            filteredBalances = state.leaveBalances.where((balance) {
              return balance.leaveType.value.toLowerCase() ==
                  widget.selectedLeaveType!.name.toLowerCase();
            }).toList();
          } else {
            filteredBalances = state.leaveBalances;
          }

          if (filteredBalances.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  widget.selectedLeaveType != null
                      ? 'No ${widget.selectedLeaveType!.name} leave balance available'
                      : 'No leave balance data available',
                  style: appStyle(
                    color: Colors.grey,
                    size: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextstyle(
                text: widget.selectedLeaveType != null
                    ? '${widget.selectedLeaveType!.name} Leave Balance'
                    : 'Leave Balance',
                style: appStyle(
                  color: Colors.black,
                  size: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ...filteredBalances
                  .map((balance) => _buildLeaveBalanceCard(context, balance)),
            ],
          );
        }

        if (state is LeaveError) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  'Error: ${state.message}',
                  style: appStyle(
                    color: Colors.red,
                    size: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _fetchLeaveBalance,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLeaveBalanceCard(
      BuildContext context, EmployeeLeaveBalanceEntity balance) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextstyle(
            text: '${balance.leaveType.value} left:',
            style: appStyle(
                color: Colors.black, size: 14, fontWeight: FontWeight.w500),
          ),
          AppTextstyle(
            text: '${balance.remainingDays}/${balance.totalAllocated} days',
            style: appStyle(
                color: Theme.of(context).primaryColor,
                size: 14,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
