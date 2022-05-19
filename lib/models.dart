class Users {
  final String email;
  final String nama;
  final String id;

  const Users({
    required this.email,
    required this.nama,  
    required this.id,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      email: json['email'],
      nama: json['nama'],
      id: json['id'],
    );
  }
}