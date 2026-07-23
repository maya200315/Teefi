import 'package:flutter/material.dart';
import '../services/behavior_service.dart';
import '../models/behavior_model.dart';

class BehaviorProvider extends ChangeNotifier {
  final BehaviorService _service = BehaviorService();

  List<ChildBriefModel> _children = [];
  ChildBriefModel? _selectedChild;
  ChildProfileModel? _childProfile;

  // ثابتة — نفس الـ IDs الموجودة بالباك اند
  final List<BehaviorTypeModel> _behaviorTypes = [
    BehaviorTypeModel(id: 2, name: 'تفاعل إيجابي'),
    BehaviorTypeModel(id: 1, name: 'نوبة غضب'),
    BehaviorTypeModel(id: 3, name: 'سلوك تكراري'),
    BehaviorTypeModel(id: 4, name: 'استجابة'),
  ];

  int? _selectedBehaviorTypeId;

  bool _isLoading = false;
  bool _isSaving = false;
  String? _errorMessage;

  List<ChildBriefModel> get children => _children;
  ChildBriefModel? get selectedChild => _selectedChild;
  ChildProfileModel? get childProfile => _childProfile;
  List<BehaviorTypeModel> get behaviorTypes => _behaviorTypes;
  int? get selectedBehaviorTypeId => _selectedBehaviorTypeId;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get errorMessage => _errorMessage;

  Future<void> init() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final childrenData = await _service.getChildren();
      _children = childrenData.map((e) => ChildBriefModel.fromJson(e)).toList();

      if (_children.isNotEmpty) {
        await selectChild(_children.first);
      }
    } catch (e) {
      print('BEHAVIOR INIT ERROR: $e');
      _errorMessage = 'Failed to load data';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> selectChild(ChildBriefModel child) async {
    _selectedChild = child;
    notifyListeners();

    try {
      final data = await _service.getChildProfile(child.id);
      _childProfile = ChildProfileModel.fromJson(data);
    } catch (e) {
      print('BEHAVIOR PROFILE ERROR: $e');
      _errorMessage = 'Failed to load child profile';
    }
    notifyListeners();
  }

  void selectBehaviorType(int id) {
    _selectedBehaviorTypeId = id;
    notifyListeners();
  }

  Future<bool> saveBehavior({String? notes}) async {
    print("SAVE");
    print("selectedBehaviorTypeId = $_selectedBehaviorTypeId");
    print("selectedChild = ${_selectedChild?.id}");
    if (_selectedChild == null || _selectedBehaviorTypeId == null) {
      _errorMessage = 'Please select a behavior type';
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _service.createBehavior(
        childId: _selectedChild!.id,
        behaviorTypeId: _selectedBehaviorTypeId!,
        notes: notes,
      );
      _isSaving = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to save behavior';
      _isSaving = false;
      notifyListeners();
      return false;
    }
  }
}