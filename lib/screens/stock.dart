import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/stock_controller.dart';
import '../models/stock_model.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We use Consumer to listen for changes in StockController
    return Consumer<StockController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Stock Watchlist'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  controller.fetchStocks(); // Refresh data
                },
              ),
            ],
          ),
          body: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : controller.errorMessage != null
                  ? Center(
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
                              onPressed: () => controller.fetchStocks(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : controller.stocks.isEmpty
                      ? const Center(child: Text('No stocks to display. Pull to refresh or check connection.'))
                      : ListView.builder(
                          itemCount: controller.stocks.length,
                          itemBuilder: (context, index) {
                            final stock = controller.stocks[index];
                            final bool isUp = stock.priceChange >= 0;

                            return Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            stock.symbol,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            stock.companyName,
                                            style: TextStyle(color: Colors.grey[600]),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '\$${stock.currentPrice.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            stock.priceChangeDisplay,
                                            style: TextStyle(
                                              color: isUp ? Colors.green : Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Optional: Add an icon indicating up/down
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Icon(
                                        isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                        color: isUp ? Colors.green : Colors.red,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
        );
      },
    );
  }
}