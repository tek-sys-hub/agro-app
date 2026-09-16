import 'package:flutter/material.dart';
import '../../core/theme/appColors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = [
    'Tomato price',
    'Basmati rice',
    'Urea fertilizer',
    'Mustard seeds',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Search', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            Text('Find products, prices, news and more', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: IconButton(
              icon: const Icon(Icons.mic_none_rounded, color: AppColors.primary),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Text Field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search crops, prices, news, vendors...',
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textMuted),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.crop_free_rounded, color: AppColors.primary),
                  onPressed: () {},
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Explore Categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Explore Categories', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                Text('View All', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: 12),
            _buildCategoryGrid(),

            const SizedBox(height: 20),

            // Recent Searches
            if (_recentSearches.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recent Searches', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  GestureDetector(
                    onTap: () => setState(() => _recentSearches.clear()),
                    child: const Text('Clear All', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _recentSearches.map((s) {
                  return Chip(
                    label: Text(s, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    avatar: const Icon(Icons.access_time_rounded, size: 14, color: AppColors.textMuted),
                    deleteIcon: const Icon(Icons.close_rounded, size: 14, color: AppColors.textMuted),
                    onDeleted: () {
                      setState(() {
                        _recentSearches.remove(s);
                      });
                    },
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],

            // Popular Searches
            const Text('Popular Searches', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 10),
            _buildPopularSearches(),

            const SizedBox(height: 24),

            // You can also search
            const Text('You can also search', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 12),
            _buildQuickTopicGrid(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    final cats = [
      {'name': 'Grains', 'icon': Icons.grass_rounded, 'color': Colors.green, 'bg': const Color(0xFFDCFCE7)},
      {'name': 'Pulses', 'icon': Icons.grain_rounded, 'color': Colors.orange, 'bg': const Color(0xFFFEF3C7)},
      {'name': 'Spices', 'icon': Icons.local_fire_department_rounded, 'color': Colors.red, 'bg': const Color(0xFFFEE2E2)},
      {'name': 'Oilseeds', 'icon': Icons.water_drop_rounded, 'color': Colors.blue, 'bg': const Color(0xFFDBEAFE)},
      {'name': 'Vegetables', 'icon': Icons.shopping_basket_rounded, 'color': Colors.purple, 'bg': const Color(0xFFEDE9FE)},
      {'name': 'Fruits', 'icon': Icons.apple_rounded, 'color': Colors.teal, 'bg': const Color(0xFFCCFBF1)},
    ];

    return Row(
      children: cats.map((c) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: c['bg'] as Color, shape: BoxShape.circle),
                  child: Icon(c['icon'] as IconData, color: c['color'] as Color, size: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  c['name'] as String,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPopularSearches() {
    final list = [
      {
        'title': 'Tomato',
        'sub': 'Fresh & Farm Quality',
        'price': 'NPR 82 /kg',
        'change': '▼ 2.4%',
        'isUp': false,
        'market': 'Kalimati Market',
        'icon': '🍅',
      },
      {
        'title': 'Basmati Rice',
        'sub': 'Premium Quality',
        'price': 'NPR 128 /kg',
        'change': '▲ 1.6%',
        'isUp': true,
        'market': 'Biratnagar Market',
        'icon': '🍚',
      },
      {
        'title': 'Toor Dal (Pigeon Pea)',
        'sub': 'High Protein & Pure',
        'price': 'NPR 110 /kg',
        'change': '▼ 0.8%',
        'isUp': false,
        'market': 'Nepalgunj Market',
        'icon': '🍲',
      },
      {
        'title': 'Mustard Seeds',
        'sub': 'Best for Oil Production',
        'price': 'NPR 70 /kg',
        'change': '▲ 0.5%',
        'isUp': true,
        'market': 'Dhangadhi Market',
        'icon': '🌾',
      },
    ];

    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.borderSubtle),
        itemBuilder: (context, index) {
          final item = list[index];
          final isUp = item['isUp'] as bool;
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            leading: Text(item['icon'] as String, style: const TextStyle(fontSize: 28)),
            title: Text(
              item['title'] as String,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['sub'] as String, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
                const SizedBox(height: 3),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Market Price',
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.primary),
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item['price'] as String,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                Text(
                  item['change'] as String,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isUp ? AppColors.success : AppColors.danger,
                  ),
                ),
                Text(
                  item['market'] as String,
                  style: const TextStyle(fontSize: 9, color: AppColors.textMuted),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickTopicGrid() {
    final topics = [
      {'title': 'Market Prices', 'sub': 'Live prices by market', 'icon': Icons.trending_up_rounded, 'color': Colors.teal},
      {'title': 'News & Updates', 'sub': 'Latest agriculture news', 'icon': Icons.newspaper_rounded, 'color': Colors.blue},
      {'title': 'Weather Updates', 'sub': 'Local weather forecast', 'icon': Icons.cloud_outlined, 'color': Colors.lightBlue},
      {'title': 'Fertilizers', 'sub': 'Find fertilizers & chemicals', 'icon': Icons.sanitizer_rounded, 'color': Colors.green},
      {'title': 'Machinery', 'sub': 'Farm tools & machinery', 'icon': Icons.agriculture_rounded, 'color': Colors.orange},
      {'title': 'B2B Vendors', 'sub': 'Bulk purchase & suppliers', 'icon': Icons.business_center_outlined, 'color': Colors.purple},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.2,
      ),
      itemCount: topics.length,
      itemBuilder: (context, index) {
        final t = topics[index];
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: (t['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(t['icon'] as IconData, color: t['color'] as Color, size: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t['title'] as String,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                    Text(
                      t['sub'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 9, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
