class Stock {
  final String symbol;
  final String companyName;
  final double currentPrice;
  final double priceChange;
  final double changePercentage;

  Stock({
    required this.symbol,
    required this.companyName,
    required this.currentPrice,
    required this.priceChange,
    required this.changePercentage,
  });

  // Factory constructor to create a Stock object from a JSON map (useful for API responses)
  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol'] as String,
      companyName: json['companyName'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      priceChange: (json['priceChange'] as num).toDouble(),
      changePercentage: (json['changePercentage'] as num).toDouble(),
    );
  }

  // Helper for display purposes (optional)
  String get priceChangeDisplay {
    String sign = priceChange >= 0 ? '+' : '';
    return '$sign${priceChange.toStringAsFixed(2)} ($sign${changePercentage.toStringAsFixed(2)}%)';
  }

  // For debugging
  @override
  String toString() {
    return 'Stock(symbol: $symbol, companyName: $companyName, currentPrice: $currentPrice, priceChange: $priceChange, changePercentage: $changePercentage)';
  }
}