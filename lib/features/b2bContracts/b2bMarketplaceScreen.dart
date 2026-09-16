import 'package:flutter/material.dart';
import '../../core/theme/appColors.dart';
import '../../core/widgets/metricBadge.dart';
import 'createContractScreen.dart';
import '../notifications/notificationScreen.dart';

class B2bMarketplaceScreen extends StatefulWidget {
  const B2bMarketplaceScreen({super.key});

  @override
  State<B2bMarketplaceScreen> createState() => _B2bMarketplaceScreenState();
}

class _B2bMarketplaceScreenState extends State<B2bMarketplaceScreen> {
  int _tabIndex = 0;
  final List<String> _productCategories = ['All Categories', 'Grains', 'Pulses', 'Spices', 'Oilseeds'];
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          children: const [
            Text('B2B Contracts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            SizedBox(width: 4),
            Icon(Icons.check_circle_rounded, size: 16, color: AppColors.primary),
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
            // Top Hero Banner
            _buildHeroBanner(context),
            const SizedBox(height: 16),

            // 4 Trust Badges
            _buildTrustBadges(),
            const SizedBox(height: 16),

            // Segmented Tabs
            _buildSegmentedTabs(),
            const SizedBox(height: 14),

            if (_tabIndex == 0) ...[
              // Category Filters
              _buildCategoryFilters(),
              const SizedBox(height: 16),

              // Top Vendors & Products
              _buildTopVendors(context),
              const SizedBox(height: 20),

              // How B2B Contracts Work
              _buildHowItWorks(),
              const SizedBox(height: 16),

              // Supplier Registration Banner
              _buildSupplierBanner(),
              const SizedBox(height: 24),
            ] else ...[
              _buildMyContractsTab(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F7F0),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFC7EBD9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Smart sourcing for your business',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Connect with trusted farmers & suppliers and get the best deals.',
                      style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.handshake_rounded, color: AppColors.primary, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CreateContractScreen()),
                  );
                },
                icon: const Icon(Icons.assignment_add, size: 14, color: Colors.white),
                label: const Text('Post a Requirement', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_circle_outline_rounded, size: 14, color: AppColors.primary),
                label: const Text('How it works', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrustBadges() {
    final badges = [
      {'title': 'Verified Vendors', 'sub': 'KYC & quality checked', 'icon': Icons.verified_user_outlined},
      {'title': 'Secure Contracts', 'sub': 'Transparent terms', 'icon': Icons.description_outlined},
      {'title': 'Reliable Delivery', 'sub': 'On-time, every time', 'icon': Icons.local_shipping_outlined},
      {'title': 'Dedicated Support', 'sub': 'We are here to help', 'icon': Icons.support_agent_outlined},
    ];

    return Row(
      children: badges.map((b) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Icon(b['icon'] as IconData, color: AppColors.primary, size: 18),
                const SizedBox(height: 4),
                Text(
                  b['title'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                Text(
                  b['sub'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 7.5, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSegmentedTabs() {
    final tabs = ['Browse Products', 'My Contracts', 'My Requirements'];
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _tabIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _tabIndex = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                child: Text(
                  tabs[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _productCategories.length + 1,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == _productCategories.length) {
            return OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.filter_list_rounded, size: 14),
              label: const Text('Filter', style: TextStyle(fontSize: 11)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.border),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            );
          }
          final isSelected = _selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategoryIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
              ),
              child: Text(
                _productCategories[index],
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
    );
  }

  Widget _buildTopVendors(BuildContext context) {
    final products = [
      {
        'title': 'Premium Basmati Rice',
        'vendor': 'GreenField Agro Pvt. Ltd.',
        'rating': '4.8',
        'location': 'Kapilvastu, Nepal',
        'price': 'NPR 82',
        'moq': '500 kg',
        'tags': ['Bulk Supply', 'Quality Assured', 'Lab Tested'],
        'icon': '🌾',
      },
      {
        'title': 'Toor Dal (Pigeon Pea)',
        'vendor': 'Himalaya Pulses',
        'rating': '4.6',
        'location': 'Rupandehi, Nepal',
        'price': 'NPR 110',
        'moq': '300 kg',
        'tags': ['Bulk Supply', 'Quality Assured', 'Moisture < 12%'],
        'icon': '🍲',
      },
      {
        'title': 'Mustard Seeds',
        'vendor': 'Agro Fresh Suppliers',
        'rating': '4.7',
        'location': 'Bara, Nepal',
        'price': 'NPR 70',
        'moq': '400 kg',
        'tags': ['Bulk Supply', 'Quality Assured', 'Clean & Sorted'],
        'icon': '🌱',
      },
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Top Vendors', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            Text('View All Vendors >', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
          ],
        ),
        const SizedBox(height: 10),
        ...products.map((p) => _buildProductCard(context, p)),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> p) {
    final tags = p['tags'] as List<String>;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
            width: 80,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(p['icon'] as String, style: const TextStyle(fontSize: 36)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MetricBadge(text: 'Verified', type: MetricBadgeType.success, icon: Icons.check_circle_outline),
                    const Icon(Icons.bookmark_border_rounded, size: 18, color: AppColors.textMuted),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  p['title'] as String,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text('By ${p['vendor']}', style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                    const SizedBox(width: 4),
                    const Icon(Icons.star_rounded, size: 12, color: Colors.amber),
                    Text(p['rating'] as String, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                  ],
                ),
                Text(p['location'] as String, style: const TextStyle(fontSize: 9, color: AppColors.textMuted)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 4,
                  children: tags.map((t) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(t, style: const TextStyle(fontSize: 8, color: AppColors.textSecondary)),
                  )).toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From ${p['price']} /kg', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary)),
                        Text('MOQ: ${p['moq']}', style: const TextStyle(fontSize: 9, color: AppColors.textMuted)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const CreateContractScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        minimumSize: Size.zero,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('View Details', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorks() {
    final steps = [
      {'num': '1', 'title': 'Post Requirement', 'desc': 'Tell us what you need & quantity', 'icon': Icons.assignment_outlined},
      {'num': '2', 'title': 'Get Quotes', 'desc': 'Vendors send best quotes & terms', 'icon': Icons.groups_outlined},
      {'num': '3', 'title': 'Negotiate & Confirm', 'desc': 'Finalize terms & sign contract', 'icon': Icons.handshake_outlined},
      {'num': '4', 'title': 'Delivery & Support', 'desc': 'Receive on time with full support', 'icon': Icons.local_shipping_outlined},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('How B2B Contracts Work?', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            Text('See Process >', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: steps.map((s) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFFDCFCE7),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(s['icon'] as IconData, size: 16, color: AppColors.primary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${s['num']}. ${s['title']}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      s['desc'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 7.5, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSupplierBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.storefront_rounded, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Are you a Supplier?', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                Text('Join AgroSmart B2B network & grow.', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Register', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildMyContractsTab(BuildContext context) {
    return Column(
      children: [
        // Active contract card from contacts-2.png
        Container(
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
                children: const [
                  MetricBadge(text: 'Active Contract', type: MetricBadgeType.success),
                  Text('CT-2024-00018', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Purchase of Rice',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              const Text('Total: 1000 kg (1 Ton) • Rice (Basmati)', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Fulfilled: 450 kg (45%)', style: TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.w600)),
                  Text('In Progress: 350 kg', style: TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.w600)),
                  Text('Pending: 200 kg', style: TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: const LinearProgressIndicator(
                  value: 0.45,
                  minHeight: 6,
                  backgroundColor: Color(0xFFE5E7EB),
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CreateContractScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 36),
                ),
                child: const Text('View Contract Details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
