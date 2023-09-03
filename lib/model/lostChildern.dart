class LostChildren {
  final String name;
  final String age;
  final String parentName;
  final String parentContact;
  final String description;
  final String image;
  final String lostdate;

  const LostChildren({
    required this.name,
    required this.age,
    required this.parentName,
    required this.parentContact,
    required this.description,
    required this.image,
    required this.lostdate,
  });

  static LostChildren fromJson(Map<String, dynamic> json) => LostChildren(
      name: json['childName'],
      age: json['childAge'],
      parentName: json['parentName'],
      parentContact: json['contact'],
      description: json['description'],
      image: json['imgUrl'],
      lostdate: json['lostDate']);
}
