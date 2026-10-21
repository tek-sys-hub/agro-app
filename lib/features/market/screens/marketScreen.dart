import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/appColors.dart';
import '../providers/marketProvider.dart';
import '../widgets/sparklinePainter.dart';
import '../widgets/marketSummaryCard.dart';

class MarketScreen extends ConsumerWidget {
  const MarketScreen({super.key});

  static const List<String> _categories = ['Overview', 'Vegetables', 'Crops & Grains', 'Fruits', 'Spices'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marketState = ref.watch(marketProvider);
    final cropsList = ref.watch(filteredCropsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Market Prices',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: const Row(
              children: [
                Icon(Icons.location_on_rounded, size: 14, color: AppColors.primary),
                SizedBox(width: 4),
                Text(
                  'Kanchanpur, Nepal',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                ),
                Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.textMuted),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Category Filter Pills
            SizedBox(
              height: 38,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = marketState.selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () => ref.read(marketProvider.notifier).setCategoryIndex(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: Row(
                        children: [
                          if (index == 0)
                            Icon(Icons.trending_up_rounded, size: 16, color: isSelected ? Colors.white : AppColors.textSecondary)
                          else if (index == 1)
                            Icon(Icons.eco_rounded, size: 16, color: isSelected ? Colors.white : AppColors.textSecondary)
                          else if (index == 2)
                            Icon(Icons.grass_rounded, size: 16, color: isSelected ? Colors.white : AppColors.textSecondary)
                          else if (index == 3)
                            Icon(Icons.apple_rounded, size: 16, color: isSelected ? Colors.white : AppColors.textSecondary)
                          else
                            Icon(Icons.spa_rounded, size: 16, color: isSelected ? Colors.white : AppColors.textSecondary),
                          const SizedBox(width: 6),
                          Text(
                            _categories[index],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Market Summary Card
            const MarketSummaryCard(),

            const SizedBox(height: 16),

            // Price Trend Card (with interactive chart & date range selection)
            _buildPriceTrendCard(ref, marketState),

            const SizedBox(height: 20),

            // Top Crops by Price
            _buildTopCropsList(context, cropsList),

            const SizedBox(height: 20),

            // Market Insights Card
            _buildMarketInsightsCard(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceTrendCard(WidgetRef ref, MarketState state) {
    final notifier = ref.read(marketProvider.notifier);
    final range = state.trendRange;

    List<double> trendPoints = [42.0, 44.5, 45.0, 48.2, 50.0, 52.5, 54.0];
    List<String> dates = ['15 Oct', '16 Oct', '17 Oct', '18 Oct', '19 Oct', '20 Oct', 'Today'];

    if (range == '14 Days') {
      trendPoints = [38.0, 40.0, 41.5, 42.0, 43.5, 44.5, 45.0, 46.5, 48.0, 49.5, 50.0, 51.5, 52.5, 54.0];
      dates = ['8 Oct', '10 Oct', '12 Oct', '14 Oct', '16 Oct', '18 Oct', 'Today'];
    } else if (range == '30 Days') {
      trendPoints = [32.0, 35.0, 38.0, 40.0, 42.0, 45.0, 48.0, 52.0, 54.0];
      dates = ['21 Sep', '26 Sep', '1 Oct', '6 Oct', '11 Oct', '16 Oct', 'Today'];
    }

    final double minVal = trendPoints.reduce((a, b) => a < b ? a : b);
    final double maxVal = trendPoints.reduce((a, b) => a > b ? a : b);
    final double avgVal = trendPoints.reduce((a, b) => a + b) / trendPoints.length;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text(
                    'Price Trend Graph',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.info_outline_rounded, size: 14, color: AppColors.textMuted),
                ],
              ),

              // Interactive Range Selection Popup
              PopupMenuButton<String>(
                onSelected: (val) => notifier.setTrendRange(val),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                itemBuilder: (ctx) => [
                  const PopupMenuItem(value: '7 Days', child: Text('7 Days')),
                  const PopupMenuItem(value: '14 Days', child: Text('14 Days')),
                  const PopupMenuItem(value: '30 Days', child: Text('30 Days')),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Text(range, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      const Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: AppColors.textMuted),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Custom Painted Interactive Trend Chart with Fill Shader
          SizedBox(
            height: 110,
            child: CustomPaint(
              size: const Size(double.infinity, 110),
              painter: SparklinePainter(points: trendPoints, selectedIndex: trendPoints.length - 1),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: dates.map((d) => Text(d, style: const TextStyle(fontSize: 9, color: AppColors.textMuted))).toList(),
          ),

          const SizedBox(height: 14),
          const Divider(height: 1, color: AppColors.borderSubtle),
          const SizedBox(height: 10),

          // Lowest / Highest Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTrendSummaryItem('Period Min', 'Rs. ${minVal.toStringAsFixed(0)} /Kg', '(Radish)', Icons.arrow_downward_rounded, AppColors.success),
              _buildTrendSummaryItem('Period Max', 'Rs. ${maxVal.toStringAsFixed(0)} /Kg', '(Garlic)', Icons.arrow_upward_rounded, AppColors.danger),
              _buildTrendSummaryItem('Period Avg', 'Rs. ${avgVal.toStringAsFixed(0)} /Kg', 'vs $range', Icons.show_chart_rounded, AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendSummaryItem(String label, String value, String sub, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
        Text(sub, style: const TextStyle(fontSize: 9, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildTopCropsList(BuildContext context, List<CropModel> crops) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Row(
              children: [
                Text(
                  'Nepali Market Rates (NPR)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                SizedBox(width: 4),
                Icon(Icons.info_outline_rounded, size: 14, color: AppColors.textMuted),
              ],
            ),
            Row(
              children: [
                Text('Wholesale Rates', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                Icon(Icons.keyboard_arrow_down_rounded, size: 14),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (crops.isEmpty)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(
              child: Text('No commodities found for this category.', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            ),
          )
        else
          Material(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.border),
            ),
            clipBehavior: Clip.antiAlias,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: crops.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.borderSubtle),
              itemBuilder: (context, index) {
                final c = crops[index];
                return ListTile(
                  leading: Text(c.icon, style: const TextStyle(fontSize: 24)),
                  title: Row(
                    children: [
                      Flexible(
                        child: Text(
                          c.name,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(c.unit, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                    ],
                  ),
                  subtitle: Text(c.category, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(c.price, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      Text(
                        c.change,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: c.isUp ? AppColors.success : AppColors.danger),
                      ),
                    ],
                  ),
                  onTap: () {},
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildMarketInsightsCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.insights_rounded, size: 18, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'Kanchanpur Market Intelligence',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Vegetable prices in Kanchanpur wholesale markets show stable rates for red potatoes and tomatoes. High demand for local garlic and ginger continues across Far-Western markets.',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
          ),
        ],
      ),
    );
  }
}
