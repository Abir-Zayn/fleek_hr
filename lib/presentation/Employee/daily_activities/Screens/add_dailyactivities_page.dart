part of 'add_dailyactivities_page_imports.dart';

class AddDailyactivitiesPage extends StatefulWidget {
  const AddDailyactivitiesPage({super.key});

  @override
  State<AddDailyactivitiesPage> createState() => _AddDailyactivitiesPageState();
}

class _AddDailyactivitiesPageState extends State<AddDailyactivitiesPage> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers for all fields
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _deliveryTimeController = TextEditingController();
  final TextEditingController _workStatusController = TextEditingController();
  final TextEditingController _workTypeController = TextEditingController();
  final TextEditingController _assistedByController = TextEditingController();
  final TextEditingController _workDetailsController = TextEditingController();
  final TextEditingController _satisfactionController = TextEditingController();
  final TextEditingController _checkedWorkController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  @override
  void dispose() {
    // Dispose all controllers
    _companyController.dispose();
    _departmentController.dispose();
    _quantityController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _deliveryTimeController.dispose();
    _workStatusController.dispose();
    _workTypeController.dispose();
    _assistedByController.dispose();
    _workDetailsController.dispose();
    _satisfactionController.dispose();
    _checkedWorkController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteTextColor: Theme.of(context).primaryColor,
              dayPeriodTextColor: Theme.of(context).primaryColor,
              dialHandColor: Theme.of(context).primaryColor,
              dialBackgroundColor:
                  Theme.of(context).primaryColor.withOpacity(0.1),
              hourMinuteColor: Theme.of(context).primaryColor.withOpacity(0.1),
              dayPeriodColor: Theme.of(context).primaryColor.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text = picked.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: 'Add Daily Activity',
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextstyle(
                text: "Start your day Fresh",
                style: appStyle(
                    size: 25,
                    color: Theme.of(context).textTheme.bodyMedium!.color ??
                        Colors.black,
                    fontWeight: FontWeight.w800),
              ),
              AppTextstyle(
                text: "Enter your daily tasks and get ahead of the game",
                style: appStyle(
                    size: 14,
                    color: Theme.of(context).textTheme.bodyMedium!.color ??
                        Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),

              // Basic Information
              Apptextfield(
                labelText: 'Company',
                hintText: 'Enter company name',
                controller: _companyController,
                leadingIcon:
                    Icon(Icons.business, color: Theme.of(context).primaryColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter company name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Apptextfield(
                      labelText: 'Department',
                      hintText: 'Enter department',
                      controller: _departmentController,
                      leadingIcon: Icon(Icons.apartment,
                          color: Theme.of(context).primaryColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter department';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Apptextfield(
                      labelText: 'Quantity',
                      hintText: 'Enter qty',
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      leadingIcon: Icon(Icons.numbers,
                          color: Theme.of(context).primaryColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Time & Schedule
              Row(
                children: [
                  Expanded(
                    child: Apptextfield(
                      labelText: 'Start Time',
                      hintText: 'Select start time',
                      controller: _startTimeController,
                      onTap: () => _selectTime(_startTimeController),
                      leadingIcon: Icon(Icons.play_arrow,
                          color: Theme.of(context).primaryColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Apptextfield(
                      labelText: 'End Time',
                      hintText: 'Select end time',
                      controller: _endTimeController,
                      onTap: () => _selectTime(_endTimeController),
                      leadingIcon: Icon(Icons.stop,
                          color: Theme.of(context).primaryColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Apptextfield(
                labelText: 'Delivery Time',
                hintText: 'Select delivery time',
                controller: _deliveryTimeController,
                onTap: () => _selectTime(_deliveryTimeController),
                leadingIcon: Icon(Icons.schedule_send,
                    color: Theme.of(context).primaryColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Work Details
              Row(
                children: [
                  Expanded(
                    child: Apptextfield(
                      labelText: 'Work Status',
                      hintText: 'e.g., Completed, In Progress',
                      controller: _workStatusController,
                      leadingIcon: Icon(Icons.assignment_turned_in,
                          color: Theme.of(context).primaryColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter work status';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Apptextfield(
                      labelText: 'Work Type',
                      hintText: 'Type of work',
                      controller: _workTypeController,
                      leadingIcon: Icon(Icons.category,
                          color: Theme.of(context).primaryColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Apptextfield(
                labelText: 'Work Details',
                hintText: 'Describe your work in detail...',
                controller: _workDetailsController,
                maxLines: 4,
                height: 120,
                leadingIcon: Icon(Icons.description,
                    color: Theme.of(context).primaryColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter work details';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Collaboration
              Apptextfield(
                labelText: 'Assisted By',
                hintText: 'Who helped you with this task? (Optional)',
                controller: _assistedByController,
                leadingIcon:
                    Icon(Icons.people, color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 16),
              Apptextfield(
                labelText: 'Work Reviewed By',
                hintText: 'Who checked/reviewed your work? (Optional)',
                controller: _checkedWorkController,
                leadingIcon:
                    Icon(Icons.verified, color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 24),

              // Feedback
              Apptextfield(
                labelText: 'Your Satisfaction',
                hintText: 'Rate your satisfaction (1-10) or describe',
                controller: _satisfactionController,
                leadingIcon: Icon(Icons.sentiment_satisfied,
                    color: Theme.of(context).primaryColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your satisfaction level';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Apptextfield(
                labelText: 'Management Remarks',
                hintText: 'Any remarks from management (Optional)',
                controller: _remarksController,
                maxLines: 3,
                height: 100,
                leadingIcon:
                    Icon(Icons.comment, color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 32),

              // Submit Button
              Appbtn(
                  text: 'Save Daily Activity',
                  bgColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  height: 56,
                  fontSize: 18,
                  icon: Icons.save,
                  iconColor: Colors.white,
                  onPressed: () {}),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
