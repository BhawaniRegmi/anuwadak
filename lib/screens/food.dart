import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_app_name/controllers/food_item_controller.dart'; // Adjust import path as needed
import 'package:your_app_name/models/food_item.dart'; // Adjust import path as needed

class FoodItemScreen extends StatelessWidget {
  // Initialize the controller
  final FoodItemController foodItemController = Get.put(FoodItemController());

  FoodItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Items'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (foodItemController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (foodItemController.foodItems.isEmpty) {
          return const Center(
            child: Text('No food items found. Pull to refresh!',
                style: TextStyle(fontSize: 18)),
          );
        } else {
          return RefreshIndicator(
            onRefresh: foodItemController.fetchFoodItems,
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: foodItemController.foodItems.length,
              itemBuilder: (context, index) {
                final foodItem = foodItemController.foodItems[index];
                return FoodItemCard(foodItem: foodItem);
              },
            ),
          );
        }
      }),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final FoodItem foodItem;

  const FoodItemCard({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                foodItem.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodItem.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    foodItem.description,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber[700], size: 18),
                      const SizedBox(width: 4),
                      Text(
                        foodItem.rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${foodItem.reviews} reviews)',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '\$${foodItem.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  // Add a button to view details or add to cart
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle add to cart or view details
                        Get.snackbar(
                          'Added to Cart',
                          '${foodItem.name} added to cart!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}