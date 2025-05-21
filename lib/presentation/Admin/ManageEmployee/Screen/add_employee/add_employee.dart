part of 'add_employee_imports.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  //Tab 1 controller
  final _roleController = TextEditingController();
  final _workShiftController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _workingHoursController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _passwordController = TextEditingController();

  //Tab 2 controller
  final _genderController = TextEditingController();
  final _maritalStatusController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _branchAddressController = TextEditingController();
  final _tinNumberController = TextEditingController();

  final _formkeyTab1 = GlobalKey<FormState>();
  final _formkeyTab2 = GlobalKey<FormState>();

  //initState
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  //dispose
  @override
  void dispose() {
    _tabController.dispose();
    _roleController.dispose();
    _workShiftController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _workingHoursController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emergencyContactController.dispose();
    _passwordController.dispose();

    //Tab 2
    _genderController.dispose();
    _maritalStatusController.dispose();
    _bloodGroupController.dispose();
    _dateOfBirthController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _branchAddressController.dispose();
    _tinNumberController.dispose();

    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary:
                    Theme.of(context).primaryColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      ///On Add employee page
      ///  Requisite:
      /// Add role floating button
      /// 2 tab bar will be present
      /// On 1st tab bar
      /// Page Textfield
      ///   -- Role, work shift, Full Name, Email, National ID, Working hours, Phone, Mobile, Emergency Contact.
      ///   -- Password, Profile Image, Address and Save Button.
      /// On 2nd tab bar
      ///  -- Gender, Marital Status, Blood Group, Date of Birth, Bank Name, Account Number,Branch Address, Tin number
      ///   -- Save Button]

      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: FleekAppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: "Add Employee",
        ),
        body: Column(
          children: [
            // Tab Bar
            TabBar(
              controller: _tabController,
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "Basic"),
                Tab(text: "Additional"),
              ],
            ),

            // Tab Bar View - This connects the tabs to their content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBasicInfoTab(),
                  _buildAdditionalInfoTab(),
                ],
              ),
            ),
          ],
        ),
        // Optional: Add a floating action button for adding role
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add role functionality
            // For example, show a dialog to add a new role
          },
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: 'Add Role',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildBasicInfoTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15.0),
      child: Form(
        key: _formkeyTab1,
        child: Column(
          children: [
            EmployeeTextfield(
              labelText: 'Role',
              controller: _roleController,
              prefixIcon: Icons.work_outline,
              validator: (value) =>
                  value!.isEmpty ? 'Role cannot be empty' : null,
            ),
            EmployeeTextfield(
              labelText: 'Work Shift',
              controller: _workShiftController,
              prefixIcon: Icons.access_time,
              validator: (value) =>
                  value!.isEmpty ? 'Work Shift cannot be empty' : null,
            ),
            EmployeeTextfield(
              labelText: 'Full Name',
              controller: _fullNameController,
              prefixIcon: Icons.person,
              validator: (value) =>
                  value!.isEmpty ? 'Full Name cannot be empty' : null,
            ),
            EmployeeTextfield(
              labelText: 'Email',
              controller: _emailController,
              prefixIcon: Icons.email,
              validator: (value) =>
                  value!.isEmpty ? 'Email cannot be empty' : null,
            ),
            EmployeeTextfield(
              labelText: 'National ID',
              controller: _nationalIdController,
              prefixIcon: Icons.perm_identity,
              validator: (value) =>
                  value!.isEmpty ? 'National ID cannot be empty' : null,
            ),
            EmployeeTextfield(
              labelText: 'Working Hours',
              controller: _workingHoursController,
              prefixIcon: Icons.access_time,
              validator: (value) =>
                  value!.isEmpty ? 'Working Hours cannot be empty' : null,
            ),
            EmployeeTextfield(
              labelText: 'Phone',
              controller: _phoneController,
              prefixIcon: Icons.phone,
              validator: (value) =>
                  value!.isEmpty ? 'Phone cannot be empty' : null,
            ),
            EmployeeTextfield(
              labelText: 'Address',
              controller: _addressController,
              prefixIcon: Icons.home,
              validator: (value) =>
                  value!.isEmpty ? 'Address cannot be empty' : null,
            ),
            EmployeeTextfield(
              labelText: 'Emergency Contact',
              controller: _emergencyContactController,
              prefixIcon: Icons.phone,
              validator: (value) =>
                  value!.isEmpty ? 'Emergency Contact cannot be empty' : null,
            ),
            EmployeeTextfield(
              labelText: 'Password',
              controller: _passwordController,
              prefixIcon: Icons.lock,
              isObscure: true,
              maxLines: 1, // Explicitly set to 1 for password field
              validator: (value) =>
                  value!.isEmpty ? 'Password cannot be empty' : null,
            ),
            SizedBox(height: 20),
            Appbtn(
              text: "Save",
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              fontSize: 16,
              height: 50,
              radius: 12,
              onPressed: () {
                if (_formkeyTab1.currentState!.validate()) {
                  // Save the data
                  // You can add your save logic here
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfoTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15.0),
      child: Form(
        key: _formkeyTab2,
        child: Column(children: [
          EmployeeTextfield(
            labelText: 'Gender', // Dropdownn will be used
            controller: _genderController,
            prefixIcon: Icons.wc_outlined,
          ),
          EmployeeTextfield(
            labelText: 'Marital Status', // Dropdownn will be used
            controller: _maritalStatusController,
            prefixIcon: Icons.wc_outlined,
          ),
          EmployeeTextfield(
            labelText: 'Blood Group', // Dropdownn will be used
            controller: _bloodGroupController,
            prefixIcon: Icons.bloodtype,
          ),
          EmployeeTextfield(
            labelText: 'Date of Birth',
            controller: _dateOfBirthController,
            prefixIcon: Icons.calendar_today,
            onTap: () => _selectDate(context),
            validator: (value) =>
                value!.isEmpty ? 'Date of Birth cannot be empty' : null,
          ),
          EmployeeTextfield(
            labelText: 'Bank Name',
            controller: _bankNameController,
            prefixIcon: Icons.account_balance,
            validator: (value) =>
                value!.isEmpty ? 'Bank Name cannot be empty' : null,
          ),
          EmployeeTextfield(
            labelText: 'Account Number',
            controller: _accountNumberController,
            prefixIcon: Icons.account_balance,
            validator: (value) =>
                value!.isEmpty ? 'Account Number cannot be empty' : null,
          ),
          EmployeeTextfield(
            labelText: 'Branch Address',
            controller: _branchAddressController,
            prefixIcon: Icons.home,
            validator: (value) =>
                value!.isEmpty ? 'Branch Address cannot be empty' : null,
          ),
          EmployeeTextfield(
            labelText: 'TIN Number',
            controller: _tinNumberController,
            prefixIcon: Icons.perm_identity,
            validator: (value) =>
                value!.isEmpty ? 'TIN Number cannot be empty' : null,
          ),
          SizedBox(height: 20),
          Appbtn(
            text: "Save",
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            fontSize: 16,
            height: 50,
            radius: 12,
            onPressed: () {
              if (_formkeyTab2.currentState!.validate()) {
                // Save the data
                // You can add your save logic here
              }
            },
          ),
        ]),
      ),
    );
  }
}
