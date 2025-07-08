Fleek HR – CRM/HR Specialist Application
Fleek HR is a modern and responsive CRM/HR specialist application built using Flutter, featuring a clean UI, robust Bloc State Management, and Clean Architecture principles for scalability and maintainability.

Functionalities
Profile Screen
       1/ On the profile screen an employee can view his profile image(is on update)
       he can view his profile picture , his necessary informations like 
       Email,  Phone, Department , Role in his company. Additionally there is another 
       route "Edit/Update profile" where he can update his informations like Full Name,
       email, skills, change password etc. 
       As its an ERP System therefore delete by an employee is not authorized . As only an superadmin
       will have this ability. 




Clean Architecture 


🧑‍💼 Role-Based Dashboard
Tailored dashboards based on employee roles.

Key Feature includes:
1/Daily Activities
2/Attendance
3/WFH Requests
4/Leave Requests

Daily Work Details section (view/add activity history).

🗓️ Leave Page
Manage and view leave requests easily with a calendar view using table_calendar.

🏡 Work From Home (WFH) Request
Submit and track WFH requests seamlessly.

📊 Attendance Summary
Year-wise attendance statistics displayed using fl_chart for beautiful data visualization.

💸 Expense Management
Overview of past expenses.

Add new expense entries easily.


EntryPoint /Bottom Navigation Routing Page Description >>
Bottom Navigation bar is the main container screen that handles navigation between key sections [Home, Request, Profile] pages of FleekHR application.
This screen maintains the state of which tab is currently selected and renders. 
The appropriate screen using an IndexStack to preserve the state across the tab switches. 
Please Check Screen Overview Code 




📦 Packages Used
Package	Version	Purpose
flutter_bloc	Latest	State management
cupertino_icons	^1.0.8	iOS-styled icons
fl_chart	^0.71.0	Graph plotting for attendance summary
flutter_screenutil	^5.9.3	Responsive UI design
font_awesome_flutter	^10.8.0	Iconography
go_router	^15.1.1	Declarative routing
google_fonts	^6.2.1	Custom font styles
http	^1.3.0	Network requests
intl	^0.20.2	Internationalization and formatting
lottie	^3.3.1	Animations
table_calendar	^3.2.0	Interactive calendar for leave requests

🧱 Architecture
The app follows Clean Architecture, separating logic into:

Presentation Layer – UI widgets, Bloc listeners

Domain Layer – Business logic and use cases

Data Layer – API and repository management

🧑‍💻 Contributors
Maintained by a passionate developer aiming to simplify HR operations with elegant UI and well-structured code.
- Application UI : Md.Abir Hasan
- State Management : Md. Abir Hasan
- Tester : Md. Abir Hasan
         : Mahfuzul Alam
         : Nahidul Islam

  ![image](https://github.com/user-attachments/assets/a036926d-da14-4a50-a318-d388622b9b72)
