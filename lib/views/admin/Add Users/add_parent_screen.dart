import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/app_colors.dart';
import '../../../providers/parents_provider.dart';
import '../../../providers/parent_details_provider.dart';

class AddParentScreen extends StatefulWidget {
  final Map<String, dynamic>? parentData;

  const AddParentScreen({super.key, this.parentData});

  @override
  State<AddParentScreen> createState() => _AddParentScreenState();
}

class _AddParentScreenState extends State<AddParentScreen> {
  final TextEditingController _childNameController = TextEditingController();
  final TextEditingController _childAgeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String selectedAutismLevel = 'Mild';
  String selectedSpecialist = 'Dr. Ahmad';
  bool obscurePassword = true;
  bool _dataLoaded = false; // ✅ عشان ما نعبي الـ controllers أكثر من مرة

  final List<String> autismLevels = ['Mild', 'Moderate', 'Severe'];
  final List<String> specialists = ['Dr. Ahmad', 'Dr. Sarah', 'Dr. Mohammad'];

  @override
  void initState() {
    super.initState();
    final id = widget.parentData?['id'];
    if (id != null) {
      Future.microtask(() =>
          context.read<ParentDetailsProvider>().fetchParentById(
              int.tryParse(id.toString()) ?? 0));
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

  String? _validate() {
    if (_childNameController.text.trim().isEmpty) return 'Please enter child name';
    if (_phoneController.text.trim().isEmpty) return 'Please enter phone number';

    final age = int.tryParse(_childAgeController.text.trim());
    if (_childAgeController.text.isNotEmpty) {
      if (age == null || age <= 0) return 'Please enter a valid age';
      if (age > 18) return 'Age must be 18 or less';
    }

    if (widget.parentData == null && _passwordController.text.isEmpty) {
      return 'Please enter password';
    }
    return null;
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
    final detailsProvider = context.watch<ParentDetailsProvider>();

    // ✅ لما تجي البيانات من الـ API حطيها بالـ controllers مرة وحدة بس
    if (detailsProvider.parentData != null && !_dataLoaded) {
      _childNameController.text = detailsProvider.parentData!['name'] ?? '';
      _phoneController.text = detailsProvider.parentData!['mobile_number'] ?? '';
      _dataLoaded = true;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.parentData == null ? 'Add Parent' : 'Edit Parent',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: detailsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
              sectionTitle('Child Information'),
              const SizedBox(height: 20),

              const Text('Child Name'),
              const SizedBox(height: 8),
              TextField(
                controller: _childNameController,
                decoration: InputDecoration(
                  hintText: 'Enter child name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          items: autismLevels
                              .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                              .toList(),
                          onChanged: (v) => setState(() => selectedAutismLevel = v!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 20),

              sectionTitle('Account Information'),
              const SizedBox(height: 20),

              const Text('Phone Number'),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter phone number',
                  prefixIcon: const Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 20),

              const Text('Password'),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => obscurePassword = !obscurePassword),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 20),

              const Text('Assign Specialist'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedSpecialist,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.medical_services_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: specialists
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => selectedSpecialist = v!),
              ),

              const SizedBox(height: 35),

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

                    final provider = context.read<ParentsProvider>();
                    bool success;

                    if (widget.parentData == null) {
                      success = await provider.createParent(
                        name: _childNameController.text.trim(),
                        mobileNumber: _phoneController.text.trim(),
                        password: _passwordController.text,
                      );
                    } else {
                      success = await provider.updateParent(
                        id: int.parse(widget.parentData!['id'].toString()),
                        name: _childNameController.text.trim(),
                        mobileNumber: _phoneController.text.trim(),
                        password: _passwordController.text,
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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