class User {
  // ignore: prefer_typing_uninitialized_variables
  final id;
  final String cpf;
  final String userName;
  final String mothersName;
  final String birth;
  final String gender;

  const User({
    this.id = '',
    required this.cpf,
    required this.userName,
    required this.mothersName,
    required this.birth,
    required this.gender,
  });
}
