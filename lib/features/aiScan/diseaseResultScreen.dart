import 'package:flutter/material.dart';
import '../../core/theme/appColors.dart';
import '../../core/widgets/metricBadge.dart';

class DiseaseResultScreen extends StatefulWidget {
  const DiseaseResultScreen({super.key});

  @override
  State<DiseaseResultScreen> createState() => _DiseaseResultScreenState();
}

class _DiseaseResultScreenState extends State<DiseaseResultScreen> {
  int _treatmentTabIndex = 0; // 0: Organic, 1: Chemical

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disease Result',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            Text(
              'AI analysis completed',
              style: TextStyle(fontSize: 11, color: AppColors.textMuted),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            color: AppColors.textPrimary,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            color: AppColors.textPrimary,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Leaf Preview & Diagnosis Card
            _buildDiagnosisCard(),
            const SizedBox(height: 14),

            // Action Alert
            _buildActionBanner(),
            const SizedBox(height: 20),

            // About the Disease
            _buildAboutDisease(),
            const SizedBox(height: 20),

            // Symptoms
            _buildSymptoms(),
            const SizedBox(height: 20),

            // Probable Causes
            _buildCauses(),
            const SizedBox(height: 20),

            // Recommended Treatment
            _buildTreatments(),
            const SizedBox(height: 20),

            // Need Help Banner
            _buildExpertBanner(),
            const SizedBox(height: 24),

            // Bottom Buttons
            _buildBottomButtons(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosisCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leaf Image Placeholder with Frame
              Stack(
                children: [
                  Container(
                    width: 120,
                    height: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC8E6C9),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Icon(Icons.grass_rounded, size: 54, color: AppColors.primary),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.fullscreen_rounded, size: 14, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    left: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'View Original',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              // Disease Name & Confidence
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MetricBadge(
                      text: 'Disease Detected',
                      type: MetricBadgeType.danger,
                      icon: Icons.warning_amber_rounded,
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Early Blight',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                    ),
                    const Text(
                      '(Alternaria solani)',
                      style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Confidence Score', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        Text('92%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                        value: 0.92,
                        minHeight: 6,
                        backgroundColor: Color(0xFFE5E7EB),
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: AppColors.borderSubtle),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.bar_chart_rounded, size: 20, color: Colors.orange),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Severity', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                          Text('● Medium', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.orange)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.eco_rounded, size: 20, color: AppColors.primary),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Affected Area', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                          Text('35% of leaf area', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFBBF7D0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.shield_outlined, color: AppColors.primary, size: 22),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Take action early to prevent further spread.',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary),
                ),
                Text(
                  'Timely treatment can save your crop.',
                  style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                ),
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
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('View Treatment', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                Icon(Icons.chevron_right_rounded, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutDisease() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('About the Disease', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            Text('Learn More', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Early Blight is a common fungal disease that affects tomato leaves, causing dark spots with concentric rings. It can reduce photosynthesis and drastically reduce yield if left untreated.',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
        ),
      ],
    );
  }

  Widget _buildSymptoms() {
    final symptoms = [
      {'title': 'Dark brown spots', 'sub': 'with concentric rings'},
      {'title': 'Yellowing around', 'sub': 'lesions'},
      {'title': 'Leaf drying', 'sub': 'and curling'},
      {'title': 'Defoliation in', 'sub': 'severe cases'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Symptoms', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 10),
        Row(
          children: symptoms.map((s) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.pest_control_rounded, size: 24, color: Colors.orange),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      s['title']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      s['sub']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 9, color: AppColors.textMuted),
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

  Widget _buildCauses() {
    final causes = [
      {'title': 'High Humidity', 'sub': '(>85%)', 'icon': Icons.water_drop_outlined, 'color': Colors.blue},
      {'title': 'Warm Temperature', 'sub': '(20–28°C)', 'icon': Icons.thermostat_outlined, 'color': Colors.redAccent},
      {'title': 'Overhead Irrigation', 'sub': '', 'icon': Icons.shower_outlined, 'color': Colors.teal},
      {'title': 'Poor Air Circulation', 'sub': '', 'icon': Icons.air_rounded, 'color': Colors.indigo},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Probable Causes', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: causes.map((c) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(c['icon'] as IconData, size: 16, color: c['color'] as Color),
                  const SizedBox(width: 6),
                  Text(
                    '${c['title']} ${c['sub']}'.trim(),
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTreatments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Recommended Treatment', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            Text('View All Products', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
          ],
        ),
        const SizedBox(height: 10),
        // Toggle Buttons (Organic vs Chemical)
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _treatmentTabIndex = 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: _treatmentTabIndex == 0 ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.eco_outlined, size: 14, color: _treatmentTabIndex == 0 ? Colors.white : AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          'Organic Solutions',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: _treatmentTabIndex == 0 ? Colors.white : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _treatmentTabIndex = 1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: _treatmentTabIndex == 1 ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.science_outlined, size: 14, color: _treatmentTabIndex == 1 ? Colors.white : AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          'Chemical Solutions',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: _treatmentTabIndex == 1 ? Colors.white : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildTreatmentItem('Neem Oil Spray', 'Organic fungicide, effective for early stage', 'Organic', true),
        const SizedBox(height: 8),
        _buildTreatmentItem('Trichoderma Viride', 'Bio-fungicide to improve soil & plant health', 'Organic', true),
        const SizedBox(height: 8),
        _buildTreatmentItem('Copper Oxychloride', 'Effective against early blight fungus', 'Chemical', false),
      ],
    );
  }

  Widget _buildTreatmentItem(String title, String desc, String badgeText, bool isOrganic) {
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
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: isOrganic ? AppColors.primaryLight : const Color(0xFFEDE9FE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isOrganic ? Icons.eco_rounded : Icons.science_rounded,
              color: isOrganic ? AppColors.primary : Colors.deepPurple,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text(desc, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
                const SizedBox(height: 4),
                MetricBadge(
                  text: badgeText,
                  type: isOrganic ? MetricBadgeType.success : MetricBadgeType.info,
                ),
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
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('View Product', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                SizedBox(width: 4),
                Icon(Icons.shopping_cart_outlined, size: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpertBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFDCFCE7),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.headset_mic_rounded, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Need Help?', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                Text('Talk to our plant protection expert', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_rounded, size: 14, color: Colors.white),
            label: const Text('Chat Now', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.document_scanner_outlined, size: 16),
            label: const Text('Scan Another', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Report saved to your profile!')),
              );
            },
            icon: const Icon(Icons.bookmark_outline_rounded, size: 16, color: Colors.white),
            label: const Text('Save Report', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }
}
