import 'package:flutter/material.dart';
import '../../core/theme/appColors.dart';
import '../../core/widgets/metricBadge.dart';
import '../notifications/notificationScreen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _selectedCat = 0;
  final List<String> _categories = ['All News', 'Market Updates', 'Weather', 'Crops', 'Government'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('News & Insights', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            Text('Stay updated with the latest in agriculture', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            color: AppColors.textPrimary,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            color: AppColors.textPrimary,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Category Chips
            SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = _selectedCat == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCat = index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                      ),
                      child: Text(
                        _categories[index],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Featured Hero Card
            _buildFeaturedHeroCard(),

            const SizedBox(height: 20),

            // Top Stories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Top Stories', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                Text('View All >', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: 10),
            _buildStoryItem(
              tag: 'MARKET',
              tagType: MetricBadgeType.success,
              title: 'Tomato Prices Rise in Major Markets',
              sub: 'Tomato prices have increased by up to 18% in wholesale markets this week.',
              meta: '4h ago • 3 min read',
              icon: '🍅',
            ),
            const SizedBox(height: 10),
            _buildStoryItem(
              tag: 'CROPS',
              tagType: MetricBadgeType.info,
              title: 'Rice Production to Increase by 7% This Year',
              sub: 'Government data shows positive outlook for rice production in FY 2081/82.',
              meta: '6h ago • 4 min read',
              icon: '🍚',
            ),
            const SizedBox(height: 10),
            _buildStoryItem(
              tag: 'TECHNOLOGY',
              tagType: MetricBadgeType.neutral,
              title: 'New AI Tool Helps Detect Plant Diseases Early',
              sub: 'Researchers develop AI model that identifies 15+ plant diseases with 95% accuracy.',
              meta: '1d ago • 5 min read',
              icon: '🌱',
            ),

            const SizedBox(height: 18),

            // Newsletter subscription card
            Container(
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
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Daily Market Update', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
                        Text('Get daily price trends and insights in your inbox.', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.mail_outline_rounded, size: 14, color: Colors.white),
                    label: const Text('Subscribe', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      minimumSize: Size.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Editor's Picks
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Editor\'s Picks', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                Text('View All >', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: 10),
            _buildEditorsPicksHorizontal(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedHeroCard() {
    return Container(
      height: 190,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF075E3D), Color(0xFF0E8A5E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('NEW', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white)),
              ),
              const Icon(Icons.bolt_rounded, color: Colors.amber, size: 20),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Monsoon Forecast 2025: Timely Rains Expected Across Nepal',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.25,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Above-normal rainfall expected this season could boost crop yields across major farming regions.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11, color: Colors.white70),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('2h ago • 5 min read', style: TextStyle(fontSize: 10, color: Colors.white60)),
              Row(
                children: [
                  CircleAvatar(radius: 3, backgroundColor: Colors.white),
                  SizedBox(width: 4),
                  CircleAvatar(radius: 3, backgroundColor: Colors.white38),
                  SizedBox(width: 4),
                  CircleAvatar(radius: 3, backgroundColor: Colors.white38),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoryItem({
    required String tag,
    required MetricBadgeType tagType,
    required String title,
    required String sub,
    required String meta,
    required String icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text(icon, style: const TextStyle(fontSize: 32))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MetricBadge(text: tag, type: tagType),
                const SizedBox(height: 4),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 2),
                Text(
                  sub,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(meta, style: const TextStyle(fontSize: 9, color: AppColors.textMuted)),
                    const Icon(Icons.bookmark_border_rounded, size: 16, color: AppColors.textMuted),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorsPicksHorizontal() {
    final picks = [
      {'tag': 'CROPS', 'title': 'Best Vegetable Combinations for Higher Yield', 'meta': '2d ago • 6 min read', 'icon': '🥬'},
      {'tag': 'SUSTAINABILITY', 'title': 'Sustainable Farming Practices for Long-term Success', 'meta': '3d ago • 5 min read', 'icon': '🌾'},
      {'tag': 'GUIDE', 'title': 'Pest Control: Natural Solutions That Work', 'meta': '4d ago • 4 min read', 'icon': '🧑‍🌾'},
    ];

    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: picks.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final p = picks[index];
          return Container(
            width: 160,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text(p['icon'] as String, style: const TextStyle(fontSize: 28))),
                ),
                const SizedBox(height: 8),
                MetricBadge(text: p['tag'] as String, type: MetricBadgeType.primary),
                const SizedBox(height: 4),
                Text(
                  p['title'] as String,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Text(p['meta'] as String, style: const TextStyle(fontSize: 8, color: AppColors.textMuted)),
              ],
            ),
          );
        },
      ),
    );
  }
}
