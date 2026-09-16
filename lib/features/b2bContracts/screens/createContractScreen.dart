import 'package:flutter/material.dart';
import '../../../core/theme/appColors.dart';

class CreateContractScreen extends StatefulWidget {
  const CreateContractScreen({super.key});

  @override
  State<CreateContractScreen> createState() => _CreateContractScreenState();
}

class _CreateContractScreenState extends State<CreateContractScreen> {
  int _currentStep = 1; // 1 to 4
  final String _cropType = 'Rice (Basmati)';
  final String _quantity = '1000';
  final String _grade = 'Premium';
  final String _price = '120';
  final String _deadline = '20 May 2024';
  final String _location = 'Kathmandu, Nepal';

  // Step 2 Suppliers selection
  final Set<int> _selectedSuppliers = {0, 1, 4}; // Hari Bahadur, Sita Magar, Ram Prasad Yadav
  final List<Map<String, dynamic>> _suppliers = [
    {'name': 'Hari Bahadur Thapa', 'loc': 'Kavre, Nepal', 'comm': '250 kg', 'pct': '25%', 'type': 'Farmer'},
    {'name': 'Sita Magar', 'loc': 'Nawalpur, Nepal', 'comm': '150 kg', 'pct': '15%', 'type': 'Farmer'},
    {'name': 'Dipak Chaudhary', 'loc': 'Chitwan, Nepal', 'comm': '100 kg', 'pct': '10%', 'type': 'Farmer'},
    {'name': 'Bishnu Adhikari', 'loc': 'Parsa, Nepal', 'comm': '120 kg', 'pct': '12%', 'type': 'Farmer'},
    {'name': 'Ram Prasad Yadav', 'loc': 'Chitwan, Nepal', 'comm': '200 kg', 'pct': '20%', 'type': 'Mentor'},
    {'name': 'Laxman Subedi', 'loc': 'Kathmandu, Nepal', 'comm': '100 kg', 'pct': '10%', 'type': 'Mentor'},
  ];

  // Step 3 Terms
  final String _paymentType = 'Partial Advance';
  final String _advancePercent = '30';
  final String _paymentMethod = 'Bank Transfer';
  final String _packaging = '50kg Bags';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          _getStepTitle(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            color: AppColors.textPrimary,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 4-step stepper bar
          _buildStepperHeader(),
          const Divider(height: 1, color: AppColors.border),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: _buildCurrentStepContent(),
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 1:
        return 'Create New Contract';
      case 2:
        return 'Select Suppliers';
      case 3:
        return 'Set Terms & Conditions';
      case 4:
        return 'Review Contract';
      default:
        return 'Create Contract';
    }
  }

  Widget _buildStepperHeader() {
    final steps = ['Requirement', 'Suppliers', 'Terms', 'Review'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(steps.length, (index) {
          final stepNum = index + 1;
          final isActive = _currentStep == stepNum;
          final isCompleted = _currentStep > stepNum;

          return Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppColors.primary
                          : isActive
                              ? AppColors.primary
                              : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive || isCompleted ? AppColors.primary : AppColors.border,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: isCompleted
                          ? const Icon(Icons.check, size: 16, color: Colors.white)
                          : Text(
                              '$stepNum',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isActive ? Colors.white : AppColors.textMuted,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    steps[index],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                      color: isActive ? AppColors.primary : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              if (index < steps.length - 1)
                Container(
                  width: 30,
                  height: 1.5,
                  margin: const EdgeInsets.only(bottom: 16),
                  color: isCompleted ? AppColors.primary : AppColors.border,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 1:
        return _buildStep1Requirement();
      case 2:
        return _buildStep2Suppliers();
      case 3:
        return _buildStep3Terms();
      case 4:
        return _buildStep4Review();
      default:
        return const SizedBox();
    }
  }

  // STEP 1: REQUIREMENT
  Widget _buildStep1Requirement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('What do you need?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),

        _buildLabel('Crop Type *'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_cropType, style: const TextStyle(fontWeight: FontWeight.w600)),
              const Icon(Icons.keyboard_arrow_right_rounded, color: AppColors.textMuted),
            ],
          ),
        ),

        const SizedBox(height: 14),
        _buildLabel('Total Quantity *'),
        TextField(
          controller: TextEditingController(text: _quantity),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter quantity',
            suffixText: 'kg',
            suffixStyle: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildQtyChip('500 kg', false),
            const SizedBox(width: 8),
            _buildQtyChip('1 Ton', true),
            const SizedBox(width: 8),
            _buildQtyChip('2 Ton', false),
            const SizedBox(width: 8),
            _buildQtyChip('5 Ton+', false),
          ],
        ),

        const SizedBox(height: 14),
        _buildLabel('Quality Grade'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_grade, style: const TextStyle(fontWeight: FontWeight.w600)),
              const Icon(Icons.keyboard_arrow_right_rounded, color: AppColors.textMuted),
            ],
          ),
        ),

        const SizedBox(height: 14),
        _buildLabel('Target Price (NPR / kg)'),
        TextField(
          controller: TextEditingController(text: _price),
          keyboardType: TextInputType.number,
        ),

        const SizedBox(height: 14),
        _buildLabel('Delivery Deadline *'),
        TextField(
          controller: TextEditingController(text: _deadline),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textMuted),
          ),
        ),

        const SizedBox(height: 14),
        _buildLabel('Delivery Location *'),
        TextField(
          controller: TextEditingController(text: _location),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.location_on_outlined, size: 18, color: AppColors.textMuted),
          ),
        ),

        const SizedBox(height: 14),
        _buildLabel('Additional Notes (Optional)'),
        TextField(
          maxLines: 3,
          controller: TextEditingController(text: 'Need high quality rice. Moisture content below 14%. Packaging in 50kg bags.'),
        ),

        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => setState(() => _currentStep = 2),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Next: Add Suppliers', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildQtyChip(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : AppColors.textSecondary,
        ),
      ),
    );
  }

  // STEP 2: SELECT SUPPLIERS
  Widget _buildStep2Suppliers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TextField(
          decoration: InputDecoration(
            hintText: 'Search farmers by name or location',
            prefixIcon: Icon(Icons.search_rounded, color: AppColors.textMuted),
            suffixIcon: Icon(Icons.filter_list_rounded, color: AppColors.primary),
          ),
        ),
        const SizedBox(height: 14),

        // List of suppliers
        ...List.generate(_suppliers.length, (index) {
          final s = _suppliers[index];
          final isChecked = _selectedSuppliers.contains(index);
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isChecked ? AppColors.primary : AppColors.border),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primaryLight,
                  child: Text(s['name'][0], style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s['name'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                      Text('${s['loc']} • ${s['type']}', style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(s['comm'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                    Text(s['pct'], style: const TextStyle(fontSize: 9, color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(width: 8),
                Checkbox(
                  value: isChecked,
                  activeColor: AppColors.primary,
                  onChanged: (val) {
                    setState(() {
                      if (val == true) {
                        _selectedSuppliers.add(index);
                      } else {
                        _selectedSuppliers.remove(index);
                      }
                    });
                  },
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: 16),

        // Progress committed
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Total Committed', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  Text('720 kg / 1000 kg (72%)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: const LinearProgressIndicator(
                  value: 0.72,
                  minHeight: 6,
                  backgroundColor: Color(0xFFE5E7EB),
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: () => setState(() => _currentStep = 3),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Next: Set Terms', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // STEP 3: SET TERMS
  Widget _buildStep3Terms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel('Price per kg (NPR) *'),
        TextField(controller: TextEditingController(text: _price)),

        const SizedBox(height: 14),
        _buildLabel('Payment Type'),
        TextField(controller: TextEditingController(text: _paymentType)),

        const SizedBox(height: 14),
        _buildLabel('Advance Payment (%)'),
        TextField(controller: TextEditingController(text: _advancePercent)),

        const SizedBox(height: 14),
        _buildLabel('Payment Method'),
        TextField(controller: TextEditingController(text: _paymentMethod)),

        const SizedBox(height: 14),
        _buildLabel('Packaging Requirement'),
        TextField(controller: TextEditingController(text: _packaging)),

        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => setState(() => _currentStep = 4),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Next: Review Contract', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // STEP 4: REVIEW
  Widget _buildStep4Review() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Contract Summary', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  Text('Edit', style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 10),
              _buildReviewRow('Crop Type', _cropType),
              _buildReviewRow('Total Quantity', '$_quantity kg (1 Ton)'),
              _buildReviewRow('Target Price', 'NPR $_price / kg'),
              _buildReviewRow('Delivery Deadline', _deadline),
              _buildReviewRow('Delivery Location', _location),
            ],
          ),
        ),

        const SizedBox(height: 14),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Payment & Delivery', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              Text('Payment Type: Partial Advance (30%)', style: TextStyle(fontSize: 12)),
              Text('Payment Method: Bank Transfer', style: TextStyle(fontSize: 12)),
              Text('Packaging: 50kg Bags', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),

        const SizedBox(height: 24),

        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('B2B Contract Posted Successfully!')),
            );
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Post Contract', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildReviewRow(String title, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          Text(val, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
