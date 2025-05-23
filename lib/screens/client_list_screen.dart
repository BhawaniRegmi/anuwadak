import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_app_name/controllers/client_controller.dart'; // Adjust import path
import 'package:your_app_name/models/client_model.dart'; // Adjust import path

class ClientListScreen extends StatelessWidget {
  const ClientListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<ClientController>(context, listen: false).fetchClients();
            },
          ),
        ],
      ),
      body: Consumer<ClientController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${controller.errorMessage}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => controller.fetchClients(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (controller.clients.isEmpty) {
            return const Center(child: Text('No clients found.'));
          }

          return ListView.builder(
            itemCount: controller.clients.length,
            itemBuilder: (context, index) {
              final client = controller.clients[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(client.name[0]),
                  ),
                  title: Text(client.name),
                  subtitle: Text('${client.company}\n${client.email}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // In a real app, you'd likely add a confirmation dialog
                      controller.deleteClient(client.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Client ${client.name} deleted!')),
                      );
                    },
                  ),
                  onTap: () {
                    // Navigate to a client detail screen or open an edit dialog
                    _showClientDetails(context, client);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example: Add a new client
          // In a real app, you would navigate to a form to input client details
          final newClient = Client(
            id: 'CLT${DateTime.now().millisecondsSinceEpoch}', // Unique ID
            name: 'New Client ${DateTime.now().second}',
            email: 'new_client_${DateTime.now().second}@example.com',
            phone: '000-000-0000',
            company: 'New Venture Co.',
            registrationDate: DateTime.now(),
          );
          Provider.of<ClientController>(context, listen: false).addClient(newClient);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${newClient.name} added!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showClientDetails(BuildContext context, Client client) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(client.name),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('ID: ${client.id}'),
                Text('Email: ${client.email}'),
                Text('Phone: ${client.phone}'),
                Text('Company: ${client.company}'),
                Text('Registered: ${client.registrationDate.toLocal().toString().split(' ')[0]}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Edit (Dummy)'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                // Simulate updating a client
                final updatedClient = Client(
                  id: client.id,
                  name: '${client.name} (Updated)',
                  email: 'updated_${client.email}',
                  phone: client.phone,
                  company: client.company,
                  registrationDate: client.registrationDate,
                );
                Provider.of<ClientController>(context, listen: false).updateClient(updatedClient);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${updatedClient.name} updated!')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}