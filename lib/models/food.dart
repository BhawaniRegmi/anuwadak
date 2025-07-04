// MARK: - Model (food_item.dart)
class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating; // New field for rating
  final int reviews; // New field for number of reviews

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.rating = 0.0, // Default rating
    this.reviews = 0, // Default reviews
  });

  // Factory constructor to create a FoodItem from a JSON map
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      rating: json['rating']?.toDouble() ?? 0.0,
      reviews: json['reviews']?.toInt() ?? 0,
    );
  }

  // Method to convert a FoodItem to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviews': reviews,
    };
  }
}

// MARK: - Controller (food_item_controller.dart)
import 'package:get/get.dart';
import 'package:your_app_name/models/food_item.dart'; // Adjust import path as needed

class FoodItemController extends GetxController {
  // Observable list of food items
  final RxList<FoodItem> _foodItems = <FoodItem>[].obs;
  List<FoodItem> get foodItems => _foodItems.toList();

  // Observable for loading state
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Simulate fetching data when the controller is initialized
    fetchFoodItems();
  }

  Future<void> fetchFoodItems() async {
    try {
      isLoading.value = true;
      // Simulate a network delay
      await Future.delayed(const Duration(seconds: 2));

      // In a real application, you would fetch data from an API
      // For demonstration, we'll use dummy data
      final List<FoodItem> fetchedData = [
        FoodItem(
          id: 'fi1',
          name: 'Classic Burger',
          description: 'A juicy beef patty with lettuce, tomato, onion, and pickles.',
          price: 12.99,
          imageUrl: 'https://images.unsplash.com/photo-1571091718767-1696176ee176?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          rating: 4.5,
          reviews: 120,
        ),
        FoodItem(
          id: 'fi2',
          name: 'Margherita Pizza',
          description: 'Simple yet delicious pizza with fresh mozzarella, basil, and tomato sauce.',
          price: 15.50,
          imageUrl: 'https://images.unsplash.com/photo-1593560704563-ad3d2ad4f0d0?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          rating: 4.8,
          reviews: 200,
        ),
        FoodItem(
          id: 'fi3',
          name: 'Caesar Salad',
          description: 'Crisp romaine lettuce, croutons, parmesan cheese, and Caesar dressing.',
          price: 9.75,
          imageUrl: 'https://images.unsplash.com/photo-1505576399279-565b52d6aef8?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          rating: 4.2,
          reviews: 80,
        ),
        FoodItem(
          id: 'fi4',
          name: 'Sushi Platter',
          description: 'Assortment of fresh sushi and sashimi.',
          price: 25.00,
          imageUrl: 'https://images.unsplash.com/photo-1611756475739-166f7f6f0f7f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          rating: 4.9,
          reviews: 150,
        ),
        FoodItem(
          id: 'fi5',
          name: 'Vegan Bowl',
          description: 'Healthy bowl with quinoa, roasted vegetables, and a tahini dressing.',
          price: 13.50,
          imageUrl: 'https://images.unsplash.com/photo-1512621776951-a5796249ec5?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          rating: 4.7,
          reviews: 95,
        ),
      ];
      _foodItems.assignAll(fetchedData);
    } catch (e) {
      // Handle error (e.g., show a snackbar or a dialog)
      print('Error fetching food items: $e');
      Get.snackbar('Error', 'Failed to load food items. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // Example of adding a new food item (for future use or admin panel)
  void addFoodItem(FoodItem newItem) {
    _foodItems.add(newItem);
  }

  // Example of updating a food item
  void updateFoodItem(String id, FoodItem updatedItem) {
    final index = _foodItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      _foodItems[index] = updatedItem;
    }
  }

  // Example of deleting a food item
  void deleteFoodItem(String id) {
    _foodItems.removeWhere((item) => item.id == id);
  }
}

// MARK: - View (food_item_screen.dart)
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