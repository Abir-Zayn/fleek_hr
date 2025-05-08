// import 'package:flutter/material.dart';
// import '../../../common/widgets/custom_card.dart';

// class CustomCardShowcase extends StatelessWidget {
//   const CustomCardShowcase({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Custom Cards'),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Basic Card with Gradient',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
            
//             // Basic gradient card
//             CustomCard(
//               gradientColors: [
//                 Colors.blue.shade800,
//                 Colors.blue.shade500,
//               ],
//               child: const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Task Overview',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'You have 5 tasks pending for today',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),
//             const Text(
//               'Card with Header & Footer',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
            
//             // Card with header and footer
//             CustomCard(
//               backgroundColor: Colors.white,
//               header: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.teal.shade700,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     topRight: Radius.circular(12),
//                   ),
//                 ),
//                 child: const Row(
//                   children: [
//                     Icon(Icons.calendar_today, color: Colors.white),
//                     SizedBox(width: 8),
//                     Text(
//                       'Upcoming Event',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               footer: Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: const BoxDecoration(
//                   color: Colors.black12,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(12),
//                     bottomRight: Radius.circular(12),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () {},
//                       child: Text(
//                         'View Details',
//                         style: TextStyle(color: Colors.teal.shade700),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Team Building Workshop',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Icon(Icons.access_time, size: 16, color: Colors.grey),
//                         SizedBox(width: 4),
//                         Text(
//                           '10:00 AM - 12:00 PM',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on, size: 16, color: Colors.grey),
//                         SizedBox(width: 4),
//                         Text(
//                           'Conference Room A',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),
//             const Text(
//               'Interactive Card',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
            
//             // Tappable card with border
//             CustomCard(
//               gradientColors: [
//                 Colors.purple.shade50,
//                 Colors.purple.shade100,
//               ],
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: Colors.purple.shade300, width: 1.5),
//               onTap: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Card tapped!')),
//                 );
//               },
//               child: Row(
//                 children: [
//                   Container(
//                     width: 80,
//                     height: 80,
//                     decoration: BoxDecoration(
//                       color: Colors.purple.shade300,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.security,
//                       color: Colors.white,
//                       size: 40,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   const Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Security Check',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.purple,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           'Tap to verify your account security settings',
//                           style: TextStyle(color: Colors.black87),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Icon(
//                     Icons.chevron_right,
//                     color: Colors.purple,
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),
//             const Text(
//               'Profile Card',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
            
//             // Profile card
//             CustomCard(
//               gradientColors: [
//                 Colors.indigo.shade800,
//                 Colors.indigo.shade600,
//               ],
//               child: Row(
//                 children: [
//                   Container(
//                     width: 70,
//                     height: 70,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.white,
//                         width: 2,
//                       ),
//                       image: const DecorationImage(
//                         image: AssetImage('assets/images/home_profile_card.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'John Doe',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         const Text(
//                           'Senior Developer',
//                           style: TextStyle(
//                             color: Colors.white70,
//                             fontSize: 14,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 4,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Text(
//                             'Available',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }