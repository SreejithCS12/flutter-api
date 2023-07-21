import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'models/contact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmployeeListScreen(),
    );
  }
}

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Future<List<Employee>> _employeeListFuture;

  @override
  void initState() {
    super.initState();
    _employeeListFuture = fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.blue[300],
      ),
      body: FutureBuilder<List<Employee>>(
        future: _employeeListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          final employees = snapshot.data!;
          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employee = employees[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(employee.imageUrl),
                ),
                title: Text(employee.name),
                subtitle: Text(employee.email),
              );
            },
          );
        },
      ),
    );
  }
}
