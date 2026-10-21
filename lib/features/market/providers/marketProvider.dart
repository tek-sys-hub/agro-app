import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/supabaseService.dart';
import '../../../core/services/nepaliMarketService.dart';

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
    final lowerName = name.toLowerCase();

    String emoji = '🥬';
    if (lowerName.contains('tomato') || lowerName.contains('गोलभेडा')) emoji = '🍅';
    if (lowerName.contains('potato') || lowerName.contains('आलु')) emoji = '🥔';
    if (lowerName.contains('onion') || lowerName.contains('प्याउ')) emoji = '🧅';
    if (lowerName.contains('rice') || lowerName.contains('धान')) emoji = '🍚';
    if (lowerName.contains('maize') || lowerName.contains('मकै')) emoji = '🌽';
    if (lowerName.contains('chili') || lowerName.contains('खुर्सानी')) emoji = '🌶️';
    if (lowerName.contains('garlic') || lowerName.contains('लसुन')) emoji = '🧄';
    if (lowerName.contains('ginger') || lowerName.contains('अदुवा')) emoji = '🫚';
    if (lowerName.contains('cauliflower') || lowerName.contains('काउली')) emoji = '🥦';

    final priceVal = map['price_npr'];
    final unitVal = map['unit'] as String? ?? 'per Kg';

    return CropModel(
      name: name,
      unit: '($unitVal)',
      price: 'Rs. $priceVal /Kg',
      change: map['change_percent'] as String? ?? '0%',
      isUp: map['is_up'] as bool? ?? true,
      icon: emoji,
      category: map['category'] as String? ?? 'Vegetables',
    );
  }

  factory CropModel.fromNepaliCropPrice(NepaliCropPrice p) {
    return CropModel(
      name: p.cropName,
      unit: '(${p.unit})',
      price: 'Rs. ${p.priceNpr.toStringAsFixed(0)} /Kg',
      change: p.changePercent,
      isUp: p.isUp,
      icon: p.icon,
      category: p.category,
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
  final NepaliMarketService _nepaliMarketService = NepaliMarketService.instance;

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
      // Load authentic daily Kalimati & Kanchanpur wholesale market rates
      final nepaliPrices = await _nepaliMarketService.fetchLiveKalimatiPrices();
      final loadedCrops = nepaliPrices.map((p) => CropModel.fromNepaliCropPrice(p)).toList();
      state = state.copyWith(crops: loadedCrops, isLoading: false);
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
