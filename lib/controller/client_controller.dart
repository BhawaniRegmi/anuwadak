import 'package:flutter/foundation.dart';
import 'package:your_app_name/models/client_model.dart'; // Adjust import path

class ClientController extends ChangeNotifier {
  List<Client> _clients = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Client> get clients => _clients;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  ClientController() {
    fetchClients(); // Fetch clients when the controller is initialized
  }

  Future<void> fetchClients() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate fetching data from an API or database
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

      // Dummy data
      _clients = [
        Client(
          id: 'CLT001',
          name: 'Alice Johnson',
          email: 'alice@example.com',
          phone: '123-456-7890',
          company: 'Tech Solutions Inc.',
          registrationDate: DateTime(2023, 1, 15),
        ),
        Client(
          id: 'CLT002',
          name: 'Bob Williams',
          email: 'bob@example.com',
          phone: '987-654-3210',
          company: 'Global Innovations',
          registrationDate: DateTime(2022, 11, 1),
        ),
        Client(
          id: 'CLT003',
          name: 'Carol Davis',
          email: 'carol@example.com',
          phone: '555-123-4567',
          company: 'Creative Hub Ltd.',
          registrationDate: DateTime(2023, 5, 20),
        ),
        Client(
          id: 'CLT004',
          name: 'David Lee',
          email: 'david@example.com',
          phone: '111-222-3333',
          company: 'Future Ventures',
          registrationDate: DateTime(2021, 8, 10),
        ),
      ];
    } catch (e) {
      _errorMessage = 'Failed to load clients: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Example: Add a new client (in a real app, this would involve an API call)
  Future<void> addClient(Client newClient) async {
    // Simulate API call to add client
    await Future.delayed(const Duration(const Duration(milliseconds: 500));
    _clients.add(newClient);
    notifyListeners();
  }

  // Example: Delete a client
  Future<void> deleteClient(String clientId) async {
    // Simulate API call to delete client
    await Future.delayed(const Duration(milliseconds: 500));
    _clients.removeWhere((client) => client.id == clientId);
    notifyListeners();
  }

  // Example: Update a client
  Future<void> updateClient(Client updatedClient) async {
    // Simulate API call to update client
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _clients.indexWhere((client) => client.id == updatedClient.id);
    if (index != -1) {
      _clients[index] = updatedClient;
      notifyListeners();
    }
  }
}