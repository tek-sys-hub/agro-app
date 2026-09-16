import 'package:flutter/material.dart';
import '../../core/theme/appColors.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Category Filter Pills
            SizedBox(
              height: 38,
              child: ListView.separated(
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
            _buildMarketSummaryCard(),

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

  Widget _buildMarketSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text(
                    'Market Summary',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
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
                    Icon(Icons.calendar_today_outlined, size: 12, color: AppColors.textSecondary),
                    SizedBox(width: 4),
                    Text('Today', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 14),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Updated today, 10:30 AM',
              style: TextStyle(fontSize: 10, color: AppColors.textMuted),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _buildSummaryStat(
                value: '12',
                label: 'Crops Up',
                change: '↑ 2 vs yesterday',
                icon: Icons.arrow_upward_rounded,
                iconColor: AppColors.success,
                bgColor: AppColors.successLight,
              ),
              const SizedBox(width: 8),
              _buildSummaryStat(
                value: '5',
                label: 'Crops Down',
                change: '↓ 1 vs yesterday',
                icon: Icons.arrow_downward_rounded,
                iconColor: AppColors.danger,
                bgColor: AppColors.dangerLight,
              ),
              const SizedBox(width: 8),
              _buildSummaryStat(
                value: '2',
                label: 'No Change',
                change: '– 0 vs yesterday',
                icon: Icons.remove_rounded,
                iconColor: Colors.orange,
                bgColor: const Color(0xFFFEF3C7),
              ),
              const SizedBox(width: 8),
              _buildSummaryStat(
                value: 'Rs. 28.4',
                label: 'Overall Avg',
                change: '↑ 1.8% vs yest.',
                icon: Icons.auto_graph_rounded,
                iconColor: AppColors.primary,
                bgColor: AppColors.primaryLight,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStat({
    required String value,
    required String label,
    required String change,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(icon, size: 14, color: iconColor),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 9, color: AppColors.textMuted),
            ),
            const SizedBox(height: 2),
            Text(
              change,
              style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: iconColor),
            ),
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
              painter: _SparklinePainter(points: trendPoints),
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                leading: Text(c['icon'] as String, style: const TextStyle(fontSize: 28)),
                title: Text(
                  c['name'] as String,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                subtitle: Text(c['unit'] as String, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          c['price'] as String,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                        ),
                        Text(
                          c['change'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: isUp ? AppColors.success : AppColors.danger,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 18),
                  ],
                ),
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
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBBF7D0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.analytics_outlined, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Market Insights',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary),
                ),
                SizedBox(height: 2),
                Text(
                  'Tomato prices are likely to rise in the coming week due to low supply in major markets.',
                  style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('View Insights', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                Icon(Icons.chevron_right_rounded, size: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> points;

  _SparklinePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final min = points.reduce((a, b) => a < b ? a : b);
    final max = points.reduce((a, b) => a > b ? a : b);
    final range = (max - min == 0) ? 1.0 : (max - min);

    final linePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final dotPaint = Paint()..color = AppColors.primary;
    final dotInnerPaint = Paint()..color = Colors.white;

    for (int i = 0; i < points.length; i++) {
      final x = (size.width / (points.length - 1)) * i;
      final normalizedY = (points[i] - min) / range;
      final y = size.height - (normalizedY * (size.height - 20) + 10);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      // draw node dots
      canvas.drawCircle(Offset(x, y), 3.5, dotPaint);
      canvas.drawCircle(Offset(x, y), 1.8, dotInnerPaint);
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
