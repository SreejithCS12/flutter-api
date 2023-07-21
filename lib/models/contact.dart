class Employee {
  final String name;
  final String email;
  final String imageUrl;

  Employee({required this.name, required this.email, required this.imageUrl});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
    );
  }
}
