class User {
  String _email;
  String _password;
  String _name;
  final DateTime _createdAt;
  final String _role;

  // Constructor dengan default role 'user'
  User(
    this._email,
    this._password,
    this._name,
    this._createdAt, {
    String role = 'user',
  }) : _role = role;

  // Getters
  String get email => _email;
  String get password => _password;
  String get name => _name;
  DateTime get createdAt => _createdAt;
  String get role => _role;

  // Setters
  set email(String value) => _email = value;
  set password(String value) => _password = value;
  set name(String value) => _name = value;

  String getDisplayName() {
    return _name.isNotEmpty ? _name : _email.split('@')[0];
  }

  String getFirstLetter() {
    return getDisplayName().substring(0, 1);
  }
}
