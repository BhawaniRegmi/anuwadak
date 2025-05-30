// lib/views/vehicles_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/vehicle_controller.dart';
import '../models/vehicle.dart'; // Import the Vehicle model

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<VehicleController>(context, listen: false).fetchVehicles();
            },
          ),
        ],
      ),
      body: Consumer<VehicleController>(
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
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => controller.fetchVehicles(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (controller.vehicles.isEmpty) {
            return const Center(child: Text('No vehicles found.'));
          }

          return ListView.builder(
            itemCount: controller.vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = controller.vehicles[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('${vehicle.year} ${vehicle.make} ${vehicle.model}'),
                  subtitle: Text('Color: ${vehicle.color}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteConfirmationDialog(context, controller, vehicle);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddVehicleDialog(context, Provider.of<VehicleController>(context, listen: false));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddVehicleDialog(BuildContext context, VehicleController controller) {
    String? make, model, color;
    int? year;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Vehicle'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Make'),
                    onSaved: (value) => make = value,
                    validator: (value) => value!.isEmpty ? 'Please enter make' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Model'),
                    onSaved: (value) => model = value,
                    validator: (value) => value!.isEmpty ? 'Please enter model' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Year'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => year = int.tryParse(value!),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter year';
                      if (int.tryParse(value) == null) return 'Please enter a valid number';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Color'),
                    onSaved: (value) => color = value,
                    validator: (value) => value!.isEmpty ? 'Please enter color' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  if (make != null && model != null && year != null && color != null) {
                    final newVehicle = Vehicle(
                      id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
                      make: make!,
                      model: model!,
                      year: year!,
                      color: color!,
                    );
                    controller.addVehicle(newVehicle);
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, VehicleController controller, Vehicle vehicle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Vehicle'),
          content: Text('Are you sure you want to delete ${vehicle.make} ${vehicle.model}?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
              onPressed: () {
                controller.deleteVehicle(vehicle.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}