import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_colors.dart';
import '../../../../providers/specialists_provider.dart';
import '../../../../models/specialist_model.dart';

class AddSpecialistScreen extends StatefulWidget {
  final SpecialistModel? specialistModel;

  const AddSpecialistScreen({super.key, this.specialistModel});

  @override
  State<AddSpecialistScreen> createState() => _AddSpecialistScreenState();
}

class _AddSpecialistScreenState extends State<AddSpecialistScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String? selectedSpecialty;

  final List<String> specialties = [
    'Speech Therapy',
    'Behavior Therapy',
    'Occupational Therapy',
    'Psychologist',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.specialistModel != null) {
      _nameController.text = widget.specialistModel!.name;
      _phoneController.text = widget.specialistModel!.mobileNumber;

      // التأكد من أن القيمة القادمة من الـ API موجودة بالفعل ضمن القائمة لتفادي كراش الـ Dropdown
      final specialty = widget.specialistModel!.specialty;
      selectedSpecialty = specialties.contains(specialty) ? specialty : null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validate() {
    if (_nameController.text.trim().isEmpty) return 'Please enter name';
    if (_phoneController.text.trim().isEmpty) return 'Please enter phone number';
    if (selectedSpecialty == null) return 'Please select specialty';
    if (widget.specialistModel == null && _passwordController.text.trim().isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.specialistModel != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          isEdit ? 'Edit Specialist' : 'Add Specialist',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Specialist Information',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              const SizedBox(height: 24),

              const Text('Full Name', style: TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(controller: _nameController, decoration: _inputDecoration('Enter specialist name')),
              const SizedBox(height: 20),

              const Text('Specialty', style: TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedSpecialty,
                decoration: _inputDecoration('Select specialty'),
                items: specialties.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
                onChanged: (value) => setState(() => selectedSpecialty = value),
              ),
              const SizedBox(height: 30),

              Divider(color: AppColors.cardBorder),
              const SizedBox(height: 20),

              const Text('Account Information',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              const SizedBox(height: 24),

              const Text('Phone Number', style: TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration('Enter phone number', icon: Icons.phone_outlined),
              ),
              const SizedBox(height: 20),

              const Text('Password', style: TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: _inputDecoration(
                  isEdit ? 'Leave empty to keep current password' : 'Enter password',
                  icon: Icons.lock_outline,
                ),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () async {
                    final error = _validate();
                    if (error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error), backgroundColor: Colors.red),
                      );
                      return;
                    }

                    final provider = context.read<SpecialistsProvider>();
                    bool success;

                    if (isEdit) {
                      success = await provider.updateSpecialist(
                        id: widget.specialistModel!.id,
                        name: _nameController.text.trim(),
                        mobileNumber: _phoneController.text.trim(),
                        specialty: selectedSpecialty!,
                        password: _passwordController.text.trim().isEmpty
                            ? null
                            : _passwordController.text.trim(),
                      );
                    } else {
                      success = await provider.createSpecialist(
                        name: _nameController.text.trim(),
                        mobileNumber: _phoneController.text.trim(),
                        password: _passwordController.text.trim(),
                        specialty: selectedSpecialty!,
                      );
                    }

                    if (context.mounted) {
                      if (success) {
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(provider.errorMessage ?? 'Operation failed'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    isEdit ? 'Update' : 'Submit',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, {IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon != null ? Icon(icon, color: AppColors.primary) : null,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cardBorder)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cardBorder)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary)),
    );
  }
}