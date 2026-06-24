import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class AddSpecialistScreen extends StatefulWidget {
  final Map<String, dynamic>? specialistData;

  const AddSpecialistScreen({
    super.key,
    this.specialistData,
  });

  @override
  State<AddSpecialistScreen> createState() =>
      _AddSpecialistScreenState();
}

class _AddSpecialistScreenState extends State<AddSpecialistScreen> {

  final _nameController = TextEditingController();
  // تم تغيير اسم الـ Controller ليعبر عن رقم الهاتف
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

    if (widget.specialistData != null) {
      _nameController.text =
          widget.specialistData!['name'] ?? '';

      // تعديل جلب البيانات ليعتمد على حقل الهاتف بدلاً من الإيميل
      _phoneController.text =
          widget.specialistData!['phone'] ?? '';

      _passwordController.text =
          widget.specialistData!['password'] ?? '';

      selectedSpecialty =
      widget.specialistData!['specialty'];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose(); // تعديل هنا
    _passwordController.dispose();
    super.dispose();
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
          widget.specialistData == null
              ? 'Add Specialist'
              : 'Edit Specialist',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Container(
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.cardBorder,
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const Text(
                'Specialist Information',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Full Name',
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _nameController,
                decoration: _inputDecoration(
                  'Enter specialist name',
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Specialty',
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: selectedSpecialty,
                decoration: _inputDecoration(
                  'Select specialty',
                ),

                items: specialties.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    selectedSpecialty = value;
                  });
                },
              ),

              const SizedBox(height: 30),

              Divider(
                color: AppColors.cardBorder,
              ),

              const SizedBox(height: 20),

              const Text(
                'Account Information',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),

              const SizedBox(height: 24),

              // تعديل نص العنوان هنا إلى Phone Number
              const Text(
                'Phone Number',
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone, // تحديد نوع الكيبورد ليكون أرقام هواتف
                decoration: _inputDecoration(
                  'Enter phone number', // تعديل نص التلميح
                  icon: Icons.phone_outlined, // تغيير الأيقونة لتناسب الهاتف
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Password',
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: _inputDecoration(
                  'Enter password',
                  icon: Icons.lock_outline,
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {},

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  child: Text(
                    widget.specialistData == null
                        ? 'Submit'
                        : 'Update',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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

  InputDecoration _inputDecoration(
      String hint, {
        IconData? icon,
      }) {
    return InputDecoration(
      hintText: hint,

      prefixIcon:
      icon != null ? Icon(icon, color: AppColors.primary) : null,

      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.cardBorder,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.cardBorder,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.primary,
        ),
      ),
    );
  }
}