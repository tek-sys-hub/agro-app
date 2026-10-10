import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/supabaseService.dart';

class CropModel {
  final String name;
  final String unit;
  final String price;
  final String change;
  final bool isUp;
  final String icon;
  final String category;

  const CropModel({
    required this.name,
    required this.unit,
    required this.price,
    required this.change,
    required this.isUp,
    required this.icon,
    required this.category,
  });

  factory CropModel.fromMap(Map<String, dynamic> map) {
    final name = map['crop_name'] as String? ?? 'Crop';
    String emoji = '🌱';
    if (name.toLowerCase().contains('rice')) emoji = '🍚';
    if (name.toLowerCase().contains('tomato')) emoji = '🍅';
    if (name.toLowerCase().contains('potato')) emoji = '🥔';
    if (name.toLowerCase().contains('maize')) emoji = '🌽';
    if (name.toLowerCase().contains('chili')) emoji = '🌶️';

    final priceVal = map['price_npr'];
    final unitVal = map['unit'] as String? ?? 'per Kg';

    return CropModel(
      name: name,
      unit: '($unitVal)',
      price: 'Rs. $priceVal /Kg',
      change: map['change_percent'] as String? ?? '0%',
      isUp: map['is_up'] as bool? ?? true,
      icon: emoji,
      category: map['category'] as String? ?? 'Crops',
    );
  }
}

class MarketState {
  final int selectedCategoryIndex;
  final String searchQuery;
  final bool isLoading;
  final List<CropModel> crops;

  const MarketState({
    required this.selectedCategoryIndex,
    required this.searchQuery,
    required this.isLoading,
    required this.crops,
  });

  MarketState copyWith({
    int? selectedCategoryIndex,
    String? searchQuery,
    bool? isLoading,
    List<CropModel>? crops,
  }) {
    return MarketState(
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      crops: crops ?? this.crops,
    );
  }
}

class MarketNotifier extends StateNotifier<MarketState> {
  final SupabaseService _supabaseService = SupabaseService.instance;

  MarketNotifier()
      : super(
          const MarketState(
            selectedCategoryIndex: 0,
            searchQuery: '',
            isLoading: false,
            crops: [],
          ),
        ) {
    loadMarketPrices();
  }

  Future<void> loadMarketPrices() async {
    state = state.copyWith(isLoading: true);
    final data = await _supabaseService.fetchMarketPrices();
    if (data.isNotEmpty) {
      final loadedCrops = data.map((map) => CropModel.fromMap(map)).toList();
      state = state.copyWith(crops: loadedCrops, isLoading: false);
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  void setCategoryIndex(int index) {
    state = state.copyWith(selectedCategoryIndex: index);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }
}

final marketProvider = StateNotifierProvider<MarketNotifier, MarketState>((ref) {
  return MarketNotifier();
});

final filteredCropsProvider = Provider<List<CropModel>>((ref) {
  final marketState = ref.watch(marketProvider);
  if (marketState.searchQuery.isEmpty) {
    return marketState.crops;
  }
  return marketState.crops.where((crop) {
    return crop.name.toLowerCase().contains(marketState.searchQuery.toLowerCase());
  }).toList();
});
