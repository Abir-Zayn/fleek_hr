// import 'package:fleekhr/data/models/expense/expense_card_modet.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';

// class ExpenseCardReq extends StatelessWidget {
//   final ExpenseCardData expenseCardData;
//   final bool isAdmin;
//   final VoidCallback? onTap;
//   final Function(bool)? onStatusChange;

//   const ExpenseCardReq(
//       {super.key,
//       required this.expenseCardData,
//       this.isAdmin = false,
//       this.onTap,
//       this.onStatusChange});

//   String _formatDate(DateTime date) {
//     return DateFormat('MMM dd, yyyy').format(date);
//   }

//   Color _getStatusColor() {
//     switch (expenseCardData.status.toLowerCase()) {
//       case 'pending':
//         return Colors.orange;
//       case 'approved':
//         return Colors.green;
//       case 'rejected':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap ??
//           () {
//             // Navigate to details screen with the expense ID
//             context.push(
//               '/expense-details/${expenseCardData.id}',
//               extra: {'isAdmin': isAdmin},
//             );
//           },
//       child: Card(
//         elevation: 4,
//         color: Theme.of(context).primaryColor.withOpacity(0.15),
//         shadowColor: Colors.black12,
//         margin: EdgeInsets.symmetric(vertical: 6.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 expenseCardData.employeeName,
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 'Amount: \$${expenseCardData.amount.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 14.0),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 'Date: ${_formatDate(expenseCardData.date)}',
//                 style: TextStyle(fontSize: 14.0),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 'Status: ${expenseCardData.status}',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   color: _getStatusColor(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
