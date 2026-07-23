import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/behavior_provider.dart';
import '../../models/behavior_model.dart';

class RecordBehaviorScreen extends StatefulWidget {
  const RecordBehaviorScreen({super.key});

  @override
  State<RecordBehaviorScreen> createState() => _RecordBehaviorScreenState();
}

class _RecordBehaviorScreenState extends State<RecordBehaviorScreen> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<BehaviorProvider>().init());
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  // ماب لكل نوع سلوك: أيقونة + اسم إنجليزي، مطابقة على اسم الـ API بالعربي
  Map<String, dynamic> _behaviorMeta(String arabicName) {
    switch (arabicName) {
      case 'تفاعل إيجابي':
        return {'label': 'Positive', 'icon': Icons.sentiment_satisfied_alt};
      case 'نوبة غضب':
        return {'label': 'Anger Episode', 'icon': Icons.sentiment_dissatisfied};
      case 'سلوك تكراري':
        return {'label': 'Repetitive', 'icon': Icons.repeat};
      case 'استجابة':
        return {'label': 'Response', 'icon': Icons.volume_up};
      default:
        return {'label': arabicName, 'icon': Icons.help_outline};
    }
  }

  void _showChildSwitcher(BuildContext context) {
    final provider = context.read<BehaviorProvider>();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: provider.children.map((child) {
            return ListTile(
              title: Text(child.name, textAlign: TextAlign.right),
              onTap: () {
                Navigator.pop(context);
                provider.selectChild(child);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _save() async {
    final provider = context.read<BehaviorProvider>();
    final success = await provider.saveBehavior(notes: _notesController.text.trim());

    if (context.mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Behavior saved successfully')),
        );
        _notesController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.errorMessage ?? 'Failed to save'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BehaviorProvider>();
    final profile = provider.childProfile;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FF),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // ── Header ──────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
            decoration: const BoxDecoration(
              color: Color(0xFF5B9EF5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Record Behavior',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_left, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: provider.children.length > 1
                            ? () => _showChildSwitcher(context)
                            : null,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile?.name ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Age ${profile?.age ?? ''} • ${profile?.autismLevel ?? ''}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.info_outline,
                            color: Colors.white, size: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Body ───────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'نوع السلوك • BEHAVIOR TYPE',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFA0B4D0),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 1.3,
                    ),
                    itemCount: provider.behaviorTypes.length,
                    itemBuilder: (context, index) {
                      final type = provider.behaviorTypes[index];
                      final meta = _behaviorMeta(type.name);
                      final isSelected = provider.selectedBehaviorTypeId == type.id;

                      return GestureDetector(
                        onTap: () => provider.selectBehaviorType(type.id),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF5B9EF5)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF5B9EF5)
                                  : const Color(0xFFD8E8FA),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                meta['icon'],
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF5B9EF5),
                                size: 28,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                meta['label'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF2D5F9E),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                type.name,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected
                                      ? Colors.white70
                                      : const Color(0xFFA0B4D0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Optional',
                          style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                      const Text(
                        'ملاحظات • NOTES',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFA0B4D0),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _notesController,
                    maxLines: 4,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintText: 'Add any notes here...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFFD8E8FA)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Save Button ─────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: provider.isSaving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B9EF5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: provider.isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Save | الحفظ', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}