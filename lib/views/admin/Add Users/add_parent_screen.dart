import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class AddParentScreen extends StatefulWidget {
  final Map<String, dynamic>? parentData;

  const AddParentScreen({
    super.key,
    this.parentData,
  });

  @override
  State<AddParentScreen> createState() => _AddParentScreenState();
}

class _AddParentScreenState extends State<AddParentScreen> {
  final TextEditingController _childNameController =
  TextEditingController();

  final TextEditingController _childAgeController =
  TextEditingController();

  final TextEditingController _emailController =
  TextEditingController();

  final TextEditingController _passwordController =
  TextEditingController();

  String selectedAutismLevel = 'Mild';
  String selectedSpecialist = 'Dr. Ahmad'; // تم تعديل القيمة الافتراضية لتطابق الـ initState والـ list لتجنب الـ Crash

  bool obscurePassword = true;

  final List<String> autismLevels = [
    'Mild',
    'Moderate',
    'Severe',
  ];

  final List<String> specialists = [
    'Dr. Ahmad',
    'Dr. Sarah',
    'Dr. Mohammad',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.parentData != null) {
      _childNameController.text =
          widget.parentData!['childName'] ?? '';

      _childAgeController.text =
          widget.parentData!['childAge'] ?? '';

      _emailController.text =
          widget.parentData!['email'] ?? '';

      _passwordController.text =
          widget.parentData!['password'] ?? '';

      selectedAutismLevel =
          widget.parentData!['autismLevel'] ?? 'Mild';

      selectedSpecialist =
          widget.parentData!['specialist'] ?? 'Dr. Ahmad';
    }
  }

  @override
  void dispose() {
    _childNameController.dispose();
    _childAgeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2D5F9E),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.parentData == null
              ? 'Add Parent'
              : 'Edit Parent',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Container(
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(20),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Child Information
              sectionTitle('Child Information'),

              const SizedBox(height: 20),

              const Text('Child Name'),

              const SizedBox(height: 8),

              TextField(
                controller: _childNameController,
                decoration: InputDecoration(
                  hintText: 'Enter child name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        const Text('Child Age'),

                        const SizedBox(height: 8),

                        TextField(
                          controller: _childAgeController,
                          keyboardType:
                          TextInputType.number,

                          decoration: InputDecoration(
                            hintText: 'Enter age',
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        const Text('Autism Level'),

                        const SizedBox(height: 8),

                        DropdownButtonFormField<String>(
                          value: selectedAutismLevel,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),

                          items: autismLevels
                              .map(
                                (level) => DropdownMenuItem(
                              value: level,
                              child: Text(level),
                            ),
                          )
                              .toList(),

                          onChanged: (value) {
                            setState(() {
                              selectedAutismLevel =
                              value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Divider(),

              const SizedBox(height: 20),

              /// Account Information
              sectionTitle('Account Information'),

              const SizedBox(height: 20),

              const Text('Email'),

              const SizedBox(height: 8),

              TextField(
                controller: _emailController,

                decoration: InputDecoration(
                  hintText: 'example@teefi.app',

                  prefixIcon: const Icon(
                    Icons.email_outlined,
                  ),

                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text('Password'),

              const SizedBox(height: 8),

              TextField(
                controller: _passwordController,
                obscureText: obscurePassword,

                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),

                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword =
                        !obscurePassword;
                      });
                    },
                  ),

                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text('Assign Specialist'),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: selectedSpecialist,

                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.medical_services_outlined,
                  ),

                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                ),

                items: specialists
                    .map(
                      (specialist) =>
                      DropdownMenuItem(
                        value: specialist,
                        child: Text(specialist),
                      ),
                )
                    .toList(),

                onChanged: (value) {
                  setState(() {
                    selectedSpecialist = value!;
                  });
                },
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    // Save or Update Parent
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    AppColors.primary,

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(30),
                    ),
                  ),

                  child: Text(
                    widget.parentData == null
                        ? 'Save'
                        : 'Update',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}