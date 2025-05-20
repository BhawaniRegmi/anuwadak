import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_advertisement_example/controllers/ad_controller.dart';

class AdScreen extends StatelessWidget {
  const AdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AdController(AdRepository()), // Inject the repository
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Advertisement'),
        ),
        body: Center(
          child: Consumer<AdController>(
            builder: (context, controller, child) {
              if (controller.isLoading) {
                return const CircularProgressIndicator();
              } else if (controller.errorMessage != null) {
                return Text('Error: ${controller.errorMessage}');
              } else if (controller.currentAd != null) {
                return GestureDetector(
                  onTap: controller.openAdLink,
                  child: Card(
                    margin: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.currentAd!.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (controller.currentAd!.imageUrl.isNotEmpty)
                          Image.network(
                            controller.currentAd!.imageUrl,
                            height: 150.0,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(
                                height: 150.0,
                                child: Center(child: Text('Failed to load image')),
                              );
                            },
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Click here for more info!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.blue.shade700),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Text('No advertisement available.');
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<AdController>(context, listen: false).loadAd();
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}