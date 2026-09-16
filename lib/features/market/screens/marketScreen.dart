import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';
import '../widgets/sparklinePainter.dart';
import '../widgets/marketSummaryCard.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['Overview', 'Crops', 'Trends', 'Markets'];

  @override
  Widget build(BuildContext context) {
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
                  'Kathmandu, Nepal',
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
                  final isSelected = _selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategoryIndex = index),
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
                            Icon(Icons.grass_rounded, size: 16, color: isSelected ? Colors.white : AppColors.textSecondary)
                          else if (index == 2)
                            Icon(Icons.bar_chart_rounded, size: 16, color: isSelected ? Colors.white : AppColors.textSecondary)
                          else
                            Icon(Icons.storefront_rounded, size: 16, color: isSelected ? Colors.white : AppColors.textSecondary),
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

            // Price Trend Card (with chart)
            _buildPriceTrendCard(),

            const SizedBox(height: 20),

            // Top Crops by Price
            _buildTopCropsList(context),

            const SizedBox(height: 20),

            // Market Insights Card
            _buildMarketInsightsCard(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceTrendCard() {
    final trendPoints = [24.6, 25.1, 26.2, 26.8, 27.1, 27.8, 28.4];
    final dates = ['26 Apr', '27 Apr', '28 Apr', '29 Apr', '30 Apr', '1 May', '2 May'];

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
                    'Price Trend (Average Price)',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.info_outline_rounded, size: 14, color: AppColors.textMuted),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Row(
                  children: [
                    Text('7 Days', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 14),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Custom Painted Trend Chart
          SizedBox(
            height: 100,
            child: CustomPaint(
              size: const Size(double.infinity, 100),
              painter: SparklinePainter(points: trendPoints),
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
              _buildTrendSummaryItem('Lowest Price', 'Rs. 18.7 /Kg', '(Potato)', Icons.arrow_downward_rounded, AppColors.success),
              _buildTrendSummaryItem('Highest Price', 'Rs. 64.0 /Kg', '(Rice)', Icons.arrow_upward_rounded, AppColors.danger),
              _buildTrendSummaryItem('Price Change', '↑ 1.8%', 'vs last 7 days', Icons.show_chart_rounded, AppColors.primary),
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

  Widget _buildTopCropsList(BuildContext context) {
    final crops = [
      {'name': 'Rice', 'unit': '(per Kg)', 'price': 'Rs. 64 /Kg', 'change': '↑ 0.8%', 'isUp': true, 'icon': '🍚'},
      {'name': 'Tomato', 'unit': '(per Kg)', 'price': 'Rs. 48 /Kg', 'change': '↑ 2.3%', 'isUp': true, 'icon': '🍅'},
      {'name': 'Potato', 'unit': '(per Kg)', 'price': 'Rs. 32 /Kg', 'change': '↓ 1.1%', 'isUp': false, 'icon': '🥔'},
      {'name': 'Maize', 'unit': '(per Kg)', 'price': 'Rs. 30 /Kg', 'change': '↑ 1.5%', 'isUp': true, 'icon': '🌽'},
      {'name': 'Chili', 'unit': '(per Kg)', 'price': 'Rs. 120 /Kg', 'change': '↓ 0.5%', 'isUp': false, 'icon': '🌶️'},
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Row(
              children: [
                Text(
                  'Top Crops by Price',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                SizedBox(width: 4),
                Icon(Icons.info_outline_rounded, size: 14, color: AppColors.textMuted),
              ],
            ),
            Row(
              children: [
                Text('Sort by: Price (High to Low)', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                Icon(Icons.keyboard_arrow_down_rounded, size: 14),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
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
              final isUp = c['isUp'] as bool;
              return ListTile(
                leading: Text(c['icon'] as String, style: const TextStyle(fontSize: 24)),
                title: Row(
                  children: [
                    Text(c['name'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                    const SizedBox(width: 4),
                    Text(c['unit'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(c['price'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                    Text(
                      c['change'] as String,
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: isUp ? AppColors.success : AppColors.danger),
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
                'Market Intelligence',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Vegetable prices in Kalimati market show a slight upward trend this week due to transport disruption caused by early monsoon rains. High demand for organic tomatoes continues.',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
          ),
        ],
      ),
    );
  }
}
