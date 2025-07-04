// lib/controllers/search_controller.dart
import 'package:flutter/material.dart';
import '../models/user_model.dart'; // Make sure the path is correct

class SearchController extends ChangeNotifier {
  List<UserModel> _allUsers = []; // Holds all potential users (mock data for now)
  List<UserModel> _filteredUsers = []; // Holds users after applying search/filters

  // --- Search Parameters ---
  String _searchText = '';
  String? _selectedGender;
  String? _selectedReligion;
  String? _selectedCommunity;
  RangeValues _ageRange = const RangeValues(18, 60); // Default age range

  SearchController() {
    _initializeMockData(); // Initialize with some mock data
    _applyFilters(); // Apply initial filters to populate _filteredUsers
  }

  // Getters to expose data to the UI
  List<UserModel> get filteredUsers => _filteredUsers;
  String get searchText => _searchText;
  String? get selectedGender => _selectedGender;
  String? get selectedReligion => _selectedReligion;
  String? get selectedCommunity => _selectedCommunity;
  RangeValues get ageRange => _ageRange;

  // --- Actions ---

  void updateSearchText(String text) {
    _searchText = text;
    _applyFilters();
  }

  void updateSelectedGender(String? gender) {
    _selectedGender = gender;
    _applyFilters();
  }

  void updateSelectedReligion(String? religion) {
    _selectedReligion = religion;
    _applyFilters();
  }

  void updateSelectedCommunity(String? community) {
    _selectedCommunity = community;
    _applyFilters();
  }

  void updateAgeRange(RangeValues range) {
    _ageRange = range;
    _applyFilters();
  }

  void resetFilters() {
    _searchText = '';
    _selectedGender = null;
    _selectedReligion = null;
    _selectedCommunity = null;
    _ageRange = const RangeValues(18, 60);
    _applyFilters();
  }

  // --- Filtering Logic ---
  void _applyFilters() {
    _filteredUsers = _allUsers.where((user) {
      final matchesSearchText = _searchText.isEmpty ||
          user.name.toLowerCase().contains(_searchText.toLowerCase()) ||
          user.occupation.toLowerCase().contains(_searchText.toLowerCase()) ||
          user.location.toLowerCase().contains(_searchText.toLowerCase());

      final matchesGender = _selectedGender == null || user.gender == _selectedGender;
      final matchesReligion = _selectedReligion == null || user.religion == _selectedReligion;
      final matchesCommunity = _selectedCommunity == null || user.community == _selectedCommunity;
      final matchesAge = user.age >= _ageRange.start && user.age <= _ageRange.end;

      return matchesSearchText &&
          matchesGender &&
          matchesReligion &&
          matchesCommunity &&
          matchesAge;
    }).toList();

    notifyListeners(); // Notify listeners (UI) that data has changed
  }

  // --- Mock Data Initialization (Replace with actual API calls in a real app) ---
  void _initializeMockData() {
    _allUsers = [
      UserModel(
        id: '1',
        name: 'Aisha Sharma',
        age: 28,
        gender: 'Female',
        religion: 'Hindu',
        community: 'Brahmin',
        occupation: 'Software Engineer',
        location: 'Kathmandu',
        bio: 'Passionate coder and nature lover.',
        imageUrl: 'https://via.placeholder.com/150/FF0000/FFFFFF?text=Aisha',
      ),
      UserModel(
        id: '2',
        name: 'Rahul Singh',
        age: 30,
        gender: 'Male',
        religion: 'Hindu',
        community: 'Thakur',
        occupation: 'Doctor',
        location: 'Pokhara',
        bio: 'Dedicated doctor seeking a compatible partner.',
        imageUrl: 'https://via.placeholder.com/150/0000FF/FFFFFF?text=Rahul',
      ),
      UserModel(
        id: '3',
        name: 'Fatima Khan',
        age: 26,
        gender: 'Female',
        religion: 'Islam',
        community: 'Syed',
        occupation: 'Architect',
        location: 'Lalitpur',
        bio: 'Creative architect with a love for design.',
        imageUrl: 'https://via.placeholder.com/150/00FF00/FFFFFF?text=Fatima',
      ),
      UserModel(
        id: '4',
        name: 'David Abraham',
        age: 32,
        gender: 'Male',
        religion: 'Christianity',
        community: 'Protestant',
        occupation: 'Teacher',
        location: 'Bhaktapur',
        bio: 'Enthusiastic teacher, enjoys reading and sports.',
        imageUrl: 'https://via.placeholder.com/150/FFFF00/000000?text=David',
      ),
      UserModel(
        id: '5',
        name: 'Priya Gupta',
        age: 25,
        gender: 'Female',
        religion: 'Hindu',
        community: 'Vaishya',
        occupation: 'Marketing Manager',
        location: 'Kathmandu',
        bio: 'Ambitious marketing professional.',
        imageUrl: 'https://via.placeholder.com/150/FF00FF/FFFFFF?text=Priya',
      ),
      UserModel(
        id: '6',
        name: 'Ali Raza',
        age: 29,
        gender: 'Male',
        religion: 'Islam',
        community: 'Sunni',
        occupation: 'Software Developer',
        location: 'Biratnagar',
        bio: 'Tech enthusiast looking for a life partner.',
        imageUrl: 'https://via.placeholder.com/150/00FFFF/000000?text=Ali',
      ),
    ];
  }
}