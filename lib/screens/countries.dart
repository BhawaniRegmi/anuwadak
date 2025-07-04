import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/country_viewmodel.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch countries when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CountryViewModel>(context, listen: false).fetchCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries of the World'),
        centerTitle: true,
      ),
      body: Consumer<CountryViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.fetchCountries(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (viewModel.countries.isEmpty) {
            return const Center(
              child: Text('No countries found. Pull to refresh or check connection.'),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () => viewModel.fetchCountries(),
              child: ListView.builder(
                itemCount: viewModel.countries.length,
                itemBuilder: (context, index) {
                  final country = viewModel.countries[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          if (country.flagUrl != null)
                            Image.network(
                              country.flagUrl!,
                              width: 50,
                              height: 30,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 30),
                            ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  country.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (country.capital != null)
                                  Text('Capital: ${country.capital}'),
                                if (country.region != null)
                                  Text('Region: ${country.region}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}