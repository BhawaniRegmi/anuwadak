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