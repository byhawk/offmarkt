import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/employee.dart';
import 'player_provider.dart';

part 'employee_provider.g.dart';

@riverpod
class EmployeeNotifier extends _$EmployeeNotifier {
  @override
  List<Employee> build() {
    // Başlangıç için sahte (mock) veri
    return [
      Employee(
        id: const Uuid().v4(),
        name: 'Ahmet Yılmaz',
        position: 'Satış Temsilcisi',
        salary: 55000,
        morale: 85,
        hiredAt: DateTime.now().subtract(const Duration(days: 60)),
      ),
      Employee(
        id: const Uuid().v4(),
        name: 'Ayşe Kaya',
        position: 'Pazarlama Uzmanı',
        salary: 62000,
        morale: 92,
        hiredAt: DateTime.now().subtract(const Duration(days: 120)),
      ),
    ];
  }

  /// Yeni bir çalışanı işe alır
  (bool, String?) hireEmployee({
    required String name,
    required String position,
    required double salary,
  }) {
    final playerNotifier = ref.read(playerNotifierProvider.notifier);
    final currentPlayer = ref.read(playerNotifierProvider);

    // Kiralama bedeli olarak 1 aylık maaşı varsayalım
    final hiringCost = salary;

    if (currentPlayer.cash < hiringCost) {
      return (false, 'Yetersiz nakit!');
    }

    final newEmployee = Employee(
      id: const Uuid().v4(),
      name: name,
      position: position,
      salary: salary,
      morale: 100, // Yeni çalışanlar yüksek moralle başlar
      hiredAt: DateTime.now(),
    );
    state = [...state, newEmployee];

    // Oyuncunun parasını düşür
    playerNotifier.updateCash(-hiringCost);

    return (true, null);
  }

  /// Bir çalışanı kovar
  void fireEmployee(String employeeId) {
    state = state.where((employee) => employee.id != employeeId).toList();
  }
}