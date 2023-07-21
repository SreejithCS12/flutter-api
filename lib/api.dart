import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/contact.dart';

Future<List<Employee>> fetchEmployees() async {
  final response =
      await http.get('http://www.mocky.io/v2/5d565297300000680030a986' as Uri);

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    return jsonData
        .map((employeeData) => Employee.fromJson(employeeData))
        .toList();
  } else {
    throw Exception('Failed to load employees');
  }
}
