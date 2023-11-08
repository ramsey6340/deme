import 'address.dart';

class User {
  final String userId;
  final String name;
  final String login;
  final String imageUrl;
  final Address address;

  User({
    required this.userId,
    required this.name,
    required this.imageUrl,
    required this.login,
    required this.address
  });
}