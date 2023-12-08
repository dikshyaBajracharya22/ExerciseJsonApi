class Users {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;

  Users(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.address,
      required this.phone});

  factory Users.jsoon(Map<String, dynamic> jsoon) {
    return Users(
        id: jsoon["id"],
        name: jsoon["name"],
        username: jsoon["username"],
        email: jsoon["email"],
        address:Address.jsoon(jsoon["address"]),
        phone: jsoon["phone"]);
  }
}

class Address {
  final String street;
  final String city;
  final String zipcode;

  Address({required this.street, required this.city, required this.zipcode});

  factory Address.jsoon(Map<String, dynamic> jsoon) {
    return Address(
        street: jsoon["street"],
        city: jsoon["city"],
        zipcode: jsoon["zipcode"]);
  }
}
