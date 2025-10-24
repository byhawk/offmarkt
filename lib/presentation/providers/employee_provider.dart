import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/employee.dart';

part 'employee_provider.g.dart';

@riverpod
class EmployeeNotifier extends _$EmployeeNotifier {
  @override
  List<Employee> build() {
    // Gelecekte burada çalışan verileri yüklenecek
    return [];
  }

  // TODO: Çalışan işe alma, çıkarma ve yönetme fonksiyonları eklenecek
}