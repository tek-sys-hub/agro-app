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
    final name = map['crop_name'] as String? ?? map['commodityname'] as String? ?? 'Crop';
    final lowerName = name.toLowerCase();

    String category = map['category'] as String? ?? 'Vegetables';
    if (lowerName.contains('rice') ||
        lowerName.contains('paddy') ||
        lowerName.contains('wheat') ||
        lowerName.contains('maize') ||
        lowerName.contains('corn') ||
        lowerName.contains('millet') ||
        lowerName.contains('buckwheat') ||
        lowerName.contains('dal') ||
        lowerName.contains('lentil') ||
        lowerName.contains('धान') ||
        lowerName.contains('गहुँ') ||
        lowerName.contains('मकै') ||
        lowerName.contains('कोदो') ||
        lowerName.contains('फापर')) {
      category = 'Crops';
    } else if (lowerName.contains('apple') ||
        lowerName.contains('banana') ||
        lowerName.contains('orange') ||
        lowerName.contains('lemon') ||
        lowerName.contains('papaya') ||
        lowerName.contains('watermelon') ||
        lowerName.contains('स्याउ') ||
        lowerName.contains('केरा') ||
        lowerName.contains('सुन्तला')) {
      category = 'Fruits';
    } else if (lowerName.contains('chili') ||
        lowerName.contains('garlic') ||
        lowerName.contains('ginger') ||
        lowerName.contains('turmeric') ||
        lowerName.contains('coriander') ||
        lowerName.contains('खुर्सानी') ||
        lowerName.contains('लसुन') ||
        lowerName.contains('अदुवा') ||
        lowerName.contains('बेसार')) {
      category = 'Spices';
    }

    String emoji = '🥬';
    if (lowerName.contains('tomato') || lowerName.contains('गोलभेडा')) emoji = '🍅';
    if (lowerName.contains('potato') || lowerName.contains('आलु')) emoji = '🥔';
    if (lowerName.contains('onion') || lowerName.contains('प्याउ')) emoji = '🧅';
    if (lowerName.contains('rice') || lowerName.contains('धान') || lowerName.contains('चामल')) emoji = '🍚';
    if (lowerName.contains('maize') || lowerName.contains('corn') || lowerName.contains('मकै')) emoji = '🌽';
    if (lowerName.contains('chili') || lowerName.contains('खुर्सानी')) emoji = '🌶️';
    if (lowerName.contains('garlic') || lowerName.contains('लसुन')) emoji = '🧄';
    if (lowerName.contains('ginger') || lowerName.contains('अदुवा')) emoji = '🫚';
    if (lowerName.contains('cauliflower') || lowerName.contains('काउली')) emoji = '🥦';
    if (lowerName.contains('apple') || lowerName.contains('स्याउ')) emoji = '🍎';
    if (lowerName.contains('banana') || lowerName.contains('केरा')) emoji = '🍌';
    if (lowerName.contains('orange') || lowerName.contains('सुन्तला')) emoji = '🍊';
    if (lowerName.contains('lemon') || lowerName.contains('कागति')) emoji = '🍋';
    if (lowerName.contains('watermelon') || lowerName.contains('तरबुजा')) emoji = '🍉';
    if (lowerName.contains('wheat') || lowerName.contains('गहुँ')) emoji = '🌾';

    final priceVal = map['price_npr'];
    final unitVal = map['unit'] as String? ?? 'per Kg';

    return CropModel(
      name: name,
      unit: '($unitVal)',
      price: 'Rs. $priceVal /Kg',
      change: map['change_percent'] as String? ?? '0%',
      isUp: map['is_up'] as bool? ?? true,
      icon: emoji,
      category: category,
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
  final String summaryPeriod; // 'Today', 'Yesterday', '7 Days', '30 Days'
  final String trendRange; // '7 Days', '14 Days', '30 Days'
  final bool isLoading;
  final List<CropModel> crops;

  const MarketState({
    required this.selectedCategoryIndex,
    required this.searchQuery,
    required this.summaryPeriod,
    required this.trendRange,
    required this.isLoading,
    required this.crops,
  });

  MarketState copyWith({
    int? selectedCategoryIndex,
    String? searchQuery,
    String? summaryPeriod,
    String? trendRange,
    bool? isLoading,
    List<CropModel>? crops,
  }) {
    return MarketState(
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      summaryPeriod: summaryPeriod ?? this.summaryPeriod,
      trendRange: trendRange ?? this.trendRange,
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
            summaryPeriod: 'Today',
            trendRange: '7 Days',
            isLoading: false,
            crops: [],
          ),
        ) {
    loadMarketPrices();
  }

  Future<void> loadMarketPrices() async {
    state = state.copyWith(isLoading: true);

    final Map<String, CropModel> cropMap = {};

    final nepaliPrices = await _nepaliMarketService.fetchLiveKalimatiPrices();
    for (final p in nepaliPrices) {
      final model = CropModel.fromNepaliCropPrice(p);
      cropMap[model.name.toLowerCase()] = model;
    }

    final dbData = await _supabaseService.fetchMarketPrices();
    for (final map in dbData) {
      final model = CropModel.fromMap(map);
      cropMap[model.name.toLowerCase()] = model;
    }

    state = state.copyWith(
      crops: cropMap.values.toList(),
      isLoading: false,
    );
  }

  void setCategoryIndex(int index) {
    state = state.copyWith(selectedCategoryIndex: index);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setSummaryPeriod(String period) {
    state = state.copyWith(summaryPeriod: period);
  }

  void setTrendRange(String range) {
    state = state.copyWith(trendRange: range);
  }
}

final marketProvider = StateNotifierProvider<MarketNotifier, MarketState>((ref) {
  return MarketNotifier();
});

final filteredCropsProvider = Provider<List<CropModel>>((ref) {
  final marketState = ref.watch(marketProvider);
  List<CropModel> list = marketState.crops;

  final catIndex = marketState.selectedCategoryIndex;
  if (catIndex == 1) {
    // Vegetables
    list = list.where((c) {
      final cat = c.category.toLowerCase();
      return cat.contains('veg') || cat.contains('तरकारी');
    }).toList();
  } else if (catIndex == 2) {
    // Crops & Grains
    list = list.where((c) {
      final cat = c.category.toLowerCase();
      return cat.contains('crop') || cat.contains('grain') || cat.contains('खाद्यान्न');
    }).toList();
  } else if (catIndex == 3) {
    // Fruits
    list = list.where((c) {
      final cat = c.category.toLowerCase();
      return cat.contains('fruit') || cat.contains('फलफूल');
    }).toList();
  } else if (catIndex == 4) {
    // Spices
    list = list.where((c) {
      final cat = c.category.toLowerCase();
      return cat.contains('spice') || cat.contains('मसला');
    }).toList();
  }

  if (marketState.searchQuery.isNotEmpty) {
    final query = marketState.searchQuery.toLowerCase();
    list = list.where((crop) => crop.name.toLowerCase().contains(query)).toList();
  }

  return list;
});
