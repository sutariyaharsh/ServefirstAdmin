import 'package:hive/hive.dart';
import 'package:servefirst_admin/model/response/location_survey/employee.dart';

class LocalEmployeeService {
  late Box<Employee> _employeesBox;

  Future<void> init() async {
    _employeesBox = await Hive.openBox<Employee>('Employees');
  }

  Future<void> assignAllEmployees({required List<Employee> employees}) async {
    await _employeesBox.clear();
    await _employeesBox.addAll(employees);
  }

  List<Employee> getEmployees() => _employeesBox.values.toList();
}