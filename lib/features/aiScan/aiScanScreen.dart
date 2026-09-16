import 'package:flutter/material.dart';
import '../../core/theme/appColors.dart';
import '../../core/widgets/metricBadge.dart';
import 'diseaseResultScreen.dart';
import '../notifications/notificationScreen.dart';

class AiScanScreen extends StatefulWidget {
  final int initialTabIndex;

  const AiScanScreen({super.key, this.initialTabIndex = 0});

  @override
  State<AiScanScreen> createState() => _AiScanScreenState();
}

class _AiScanScreenState extends State<AiScanScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _chatInputController = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text': "Hello Saugat! 👋\nI'm your Agro AI Assistant.\nHow can I help you with your farm today?",
      'time': '10:30 AM',
    },
    {
      'isUser': true,
      'text': 'My tomato plants have yellow spots on the leaves. What could be the reason?',
      'time': '10:32 AM',
    },
    {
      'isUser': false,
      'text': "Yellow spots on tomato leaves can be caused by several factors. Here are the most common reasons:\n\n• Early Blight: Yellow spots with dark centers.\n• Septoria Leaf Spot: Small circular spots with gray centers.\n• Nutrient Deficiency: Especially lack of magnesium or potassium.\n• Overwatering: Can cause yellowing and poor root health.\n\nI recommend checking the underside of the leaves and ensuring proper watering and nutrition. Would you like treatment suggestions?",
      'time': '10:34 AM',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTabIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _chatInputController.dispose();
    super.dispose();
  }

  void _sendMessage([String? textToSend]) {
    final text = textToSend ?? _chatInputController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({
        'isUser': true,
        'text': text,
        'time': 'Just now',
      });
      _chatInputController.clear();
    });

    // Simulated quick AI response
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _messages.add({
          'isUser': false,
          'text': "For $text, apply organic cold-pressed neem oil (2ml per liter of water) during early morning or evening. Also prune diseased lower leaves to improve air circulation.",
          'time': 'Just now',
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.eco_rounded, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 8),
            const Text(
              'AI Scan / Chat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
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
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textMuted,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          tabs: const [
            Tab(text: 'AI Scan'),
            Tab(text: 'AI Chat'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildScanTab(context),
          _buildChatTab(context),
        ],
      ),
    );
  }

  // TAB 1: AI SCAN
  Widget _buildScanTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Main scan box with frame corners
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(Icons.photo_camera_outlined, color: AppColors.primary, size: 26),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Scan a Plant',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Detect diseases, pests or get crop info\ninstantly with AI.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 18),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const DiseaseResultScreen()),
                    );
                  },
                  icon: const Icon(Icons.camera_alt_rounded, size: 18, color: Colors.white),
                  label: const Text('Take Photo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 46),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const DiseaseResultScreen()),
                    );
                  },
                  icon: const Icon(Icons.image_outlined, size: 18, color: AppColors.primary),
                  label: const Text('Choose from Gallery', style: TextStyle(fontWeight: FontWeight.w700)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    minimumSize: const Size(double.infinity, 46),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Tips Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFBBF7D0)),
            ),
            child: const Row(
              children: [
                Icon(Icons.lightbulb_outline_rounded, color: AppColors.primary, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Best Results Tips',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Capture clear images of leaves, stems or fruits in natural light for accurate diagnosis.',
                        style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // What can AI detect?
          const Text(
            'What can AI detect?',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildDetectCard('Plant Diseases', 'Identify common diseases & get solutions', Icons.eco_outlined),
              const SizedBox(width: 8),
              _buildDetectCard('Pest Detection', 'Detect pests & learn effective control', Icons.pest_control_outlined),
              const SizedBox(width: 8),
              _buildDetectCard('Crop Info', 'Get information about crops & growing tips', Icons.yard_outlined),
              const SizedBox(width: 8),
              _buildDetectCard('Treatment', 'Personalized remedies & best practices', Icons.medication_liquid_outlined),
            ],
          ),

          const SizedBox(height: 20),

          // Recent Scans
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Scans',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
              Text(
                'View All',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 10),

          _buildRecentScanItem(
            context,
            title: 'Tomato – Early Blight',
            date: 'Detected on 2 May 2025 • 10:30 AM',
            status: 'Disease Detected',
            statusType: MetricBadgeType.danger,
            icon: Icons.grass_rounded,
          ),
          const SizedBox(height: 8),
          _buildRecentScanItem(
            context,
            title: 'Chili – Aphids',
            date: 'Detected on 30 Apr 2025 • 04:15 PM',
            status: 'Pest Detected',
            statusType: MetricBadgeType.warning,
            icon: Icons.bug_report_outlined,
          ),
          const SizedBox(height: 8),
          _buildRecentScanItem(
            context,
            title: 'Rice – Healthy',
            date: 'Detected on 28 Apr 2025 • 09:20 AM',
            status: 'Healthy',
            statusType: MetricBadgeType.success,
            icon: Icons.spa_outlined,
          ),

          const SizedBox(height: 16),

          // Bottom AI Chat Banner
          Container(
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
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.support_agent_rounded, color: AppColors.primary, size: 24),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Have a question about your crop?',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                      ),
                      Text(
                        'Chat with our AI assistant for expert advice.',
                        style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    _tabController.animateTo(1);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    minimumSize: Size.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Open AI Chat', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDetectCard(String title, String subtitle, IconData icon) {
    return Expanded(
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 18),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 9, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentScanItem(
    BuildContext context, {
    required String title,
    required String date,
    required String status,
    required MetricBadgeType statusType,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const DiseaseResultScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.orange, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 4),
                  MetricBadge(text: status, type: statusType),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }

  // TAB 2: AI CHAT
  Widget _buildChatTab(BuildContext context) {
    final promptChips = [
      'Treatment for early blight',
      'Fertilizer for tomatoes',
      'Best neem oil products',
      'How to improve soil health?',
    ];

    return Column(
      children: [
        // Top banner
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F7F0),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFC7EBD9)),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Agro AI Assistant',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                    Text(
                      'Your smart farming companion. Ask anything about crops, diseases, pests, or farming practices.',
                      style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Message List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[index];
              final isUser = msg['isUser'] as bool;

              if (isUser) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F7F0),
                      borderRadius: BorderRadius.circular(16).copyWith(bottomRight: Radius.zero),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          msg['text'] as String,
                          style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              msg['time'] as String,
                              style: const TextStyle(fontSize: 9, color: AppColors.textMuted),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.done_all_rounded, size: 12, color: AppColors.primary),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16).copyWith(bottomLeft: Radius.zero),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.auto_awesome, color: Colors.white, size: 12),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Agro AI',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          msg['text'] as String,
                          style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, height: 1.4),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              msg['time'] as String,
                              style: const TextStyle(fontSize: 9, color: AppColors.textMuted),
                            ),
                            const Row(
                              children: [
                                Icon(Icons.thumb_up_outlined, size: 14, color: AppColors.textMuted),
                                SizedBox(width: 8),
                                Icon(Icons.thumb_down_outlined, size: 14, color: AppColors.textMuted),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),

        // Suggested Prompt Chips
        SizedBox(
          height: 38,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: promptChips.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final chip = promptChips[index];
              return ActionChip(
                label: Text(chip, style: const TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600)),
                backgroundColor: AppColors.primaryLight,
                side: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                onPressed: () => _sendMessage(chip),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        // Bottom Input Row
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: const Border(top: BorderSide(color: AppColors.border)),
          ),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file_rounded, color: AppColors.textMuted),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _chatInputController,
                    decoration: InputDecoration(
                      hintText: 'Type your question here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    onSubmitted: (val) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
