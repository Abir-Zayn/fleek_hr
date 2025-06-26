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

  void _saveData() {
    if (_formKey.currentState!.validate()) {
      // Handle save data logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Daily activity saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      // You can add your save logic here
      print('Saving daily activity data...');
    }
  }

  Future<void> _selectTime(TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.text = picked.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTextstyle(
          text: 'Add Daily Activity',
          style: appStyle(
            size: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Field
              Apptextfield(
                labelText: 'Company',
                hintText: 'Enter company name',
                controller: _companyController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter company name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Department Field
              Apptextfield(
                labelText: 'Department',
                hintText: 'Enter department name',
                controller: _departmentController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter department name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Quantity Field
              Apptextfield(
                labelText: 'Quantity',
                hintText: 'Enter quantity',
                controller: _quantityController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Start Time Field
              Apptextfield(
                labelText: 'Start Time',
                hintText: 'Select start time',
                controller: _startTimeController,
                onTap: () => _selectTime(_startTimeController),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select start time';
                  }
                  return null;
                },
                leadingIcon: const Icon(Icons.access_time),
              ),
              const SizedBox(height: 16),

              // End Time Field
              Apptextfield(
                labelText: 'End Time',
                hintText: 'Select end time',
                controller: _endTimeController,
                onTap: () => _selectTime(_endTimeController),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select end time';
                  }
                  return null;
                },
                leadingIcon: const Icon(Icons.access_time),
              ),
              const SizedBox(height: 16),

              // Delivery Time Field
              Apptextfield(
                labelText: 'Delivery Time',
                hintText: 'Select delivery time',
                controller: _deliveryTimeController,
                onTap: () => _selectTime(_deliveryTimeController),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select delivery time';
                  }
                  return null;
                },
              
              ),
              const SizedBox(height: 16),

              // Work Status Field
              Apptextfield(
                labelText: 'Work Status',
                hintText: 'Enter work status (e.g., Completed, In Progress)',
                controller: _workStatusController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter work status';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Work Type Field
              Apptextfield(
                labelText: 'Work Type',
                hintText: 'Enter type of work',
                controller: _workTypeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter work type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Assisted By Field
              Apptextfield(
                labelText: 'Assisted By',
                hintText: 'Enter who assisted you',
                controller: _assistedByController,
              ),
              const SizedBox(height: 16),

              // Work Details Field
              Apptextfield(
                labelText: 'Work Details',
                hintText: 'Enter detailed description of work',
                controller: _workDetailsController,
                maxLines: 4,
                height: 120,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter work details';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Your Satisfaction Field
              Apptextfield(
                labelText: 'Your Satisfaction',
                hintText: 'Rate your satisfaction (1-10) or describe',
                controller: _satisfactionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your satisfaction level';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Checked Your Work Field
              Apptextfield(
                labelText: 'Checked Your Work',
                hintText: 'Who checked/reviewed your work',
                controller: _checkedWorkController,
              ),
              const SizedBox(height: 16),

              // Remarks by Management Field
              Apptextfield(
                labelText: 'Remarks by Management',
                hintText: 'Enter management remarks (if any)',
                controller: _remarksController,
                maxLines: 3,
                height: 100,
              ),
              const SizedBox(height: 32),

              // Save Data Button
              Appbtn(
                text: 'Save Data',
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                height: 56,
                fontSize: 18,
                icon: Icons.save,
                iconColor: Colors.white,
                onPressed: _saveData,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}