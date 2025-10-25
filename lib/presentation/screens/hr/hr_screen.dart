import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/employee.dart';
import '../../providers/employee_provider.dart';
import '../../widgets/hr/employee_card.dart';

class HrScreen extends ConsumerWidget {
  const HrScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employees = ref.watch(employeeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('İK Yönetimi'),
      ),
      body: employees.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('👥', style: TextStyle(fontSize: 64)),
                  const Gap(AppSpacing.md),
                  Text('Henüz Çalışanınız Yok', style: AppTextStyles.h3),
                  const Gap(AppSpacing.sm),
                  const Text('Yeni bir çalışan işe alarak başlayın.'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return EmployeeCard(
                  employee: employee,
                  onFire: () {
                    ref.read(employeeNotifierProvider.notifier).fireEmployee(employee.id);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => _HireEmployeeDialog(),
          );
        },
        label: const Text('Çalışan İşe Al'),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.accentGold,
        foregroundColor: AppColors.backgroundPrimary,
      ),
    );
  }
}

class _HireEmployeeDialog extends ConsumerStatefulWidget {
  @override
  ConsumerState<_HireEmployeeDialog> createState() => _HireEmployeeDialogState();
}

class _HireEmployeeDialogState extends ConsumerState<_HireEmployeeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _salaryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final position = _positionController.text;
      final salary = double.tryParse(_salaryController.text) ?? 0;

      final (success, message) = ref.read(employeeNotifierProvider.notifier).hireEmployee(
            name: name,
            position: position,
            salary: salary,
          );

      if (success) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$name işe alındı!'), backgroundColor: AppColors.success),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message ?? 'Bir hata oluştu.'), backgroundColor: AppColors.danger),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Yeni Çalışan İşe Al'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'İsim'),
                validator: (value) => value!.isEmpty ? 'İsim boş olamaz' : null,
              ),
              const Gap(AppSpacing.md),
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(labelText: 'Pozisyon'),
                validator: (value) => value!.isEmpty ? 'Pozisyon boş olamaz' : null,
              ),
              const Gap(AppSpacing.md),
              TextFormField(
                controller: _salaryController,
                decoration: const InputDecoration(labelText: 'Maaş', prefixText: '₺'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Maaş boş olamaz';
                  if (double.tryParse(value) == null) return 'Geçersiz sayı';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('İşe Al'),
        ),
      ],
    );
  }
}