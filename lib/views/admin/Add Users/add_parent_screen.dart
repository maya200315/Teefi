import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../services/parent_details_service.dart';
import '../../../services/parents_service.dart'; // 1. إضافة السيرفس الجديد هنا

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
  final TextEditingController _childNameController = TextEditingController();
  final TextEditingController _childAgeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ParentDetailsService _detailsService = ParentDetailsService();

  // 2. تعريف السيرفس المسؤول عن الإضافة داخل الكلاس
  final ParentsService _service = ParentsService();

  String selectedAutismLevel = 'Mild';
  String selectedSpecialist = 'Dr. Ahmad';
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

    if (widget.parentData != null && widget.parentData!['id'] != null) {
      _loadParent(widget.parentData!['id']);
    }
  }

  void _loadParent(int id) async {
    try {
      final data = await _detailsService.getParentById(id);

      setState(() {
        _childNameController.text = data['name'] ?? '';
        _phoneController.text = data['mobile_number'] ?? '';
      });
    } catch (e) {
      print("Error loading parent details: $e");
    }
  }

  @override
  void dispose() {
    _childNameController.dispose();
    _childAgeController.dispose();
    _phoneController.dispose();
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text('Child Age'),

                        const SizedBox(height: 8),

                        TextField(
                          controller: _childAgeController,
                          keyboardType: TextInputType.number,

                          decoration: InputDecoration(
                            hintText: 'Enter age',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text('Autism Level'),

                        const SizedBox(height: 8),

                        DropdownButtonFormField<String>(
                          value: selectedAutismLevel,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
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
                              selectedAutismLevel = value!;
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

              const Text('Phone Number'),

              const SizedBox(height: 8),

              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,

                decoration: InputDecoration(
                  hintText: 'Enter phone number',

                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
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
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                items: specialists
                    .map(
                      (specialist) => DropdownMenuItem(
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
                  // 3. تحديث الـ onPressed ليدعم استدعاء الـ API عند الحفظ
                  onPressed: () async {
                    if (widget.parentData == null) {
                      try {
                        // CREATE NEW PARENT
                        await _service.createParent(
                          name: _childNameController.text.trim(),
                          mobileNumber: _phoneController.text.trim(),
                          password: _passwordController.text,
                        );

                        if (context.mounted) {
                          Navigator.pop(context, true);
                        }
                      } catch (e) {
                        print("Error creating parent: $e");
                      }
                    } else {
                      // UPDATE لاحقاً
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,

                    shape: RoundedRectangleBorder(
                      borderRadius: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ).borderRadius,
                    ),
                  ),

                  child: Text(
                    widget.parentData == null ? 'Save' : 'Update',
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