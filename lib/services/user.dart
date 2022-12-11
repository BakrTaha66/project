class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final bool isDarkMood;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.isDarkMood,
  });

  User copy({
    String? imagePath,
    String? name,
    String? email,
    String? password,
    String? about,
    bool? isDarkMood,
  }) =>
      User(
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        email: email ?? this.email,
        about: about ?? this.about,
        isDarkMood: isDarkMood ?? this.isDarkMood,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        imagePath: json['imagePath'],
        name: json['name'],
        email: json['email'],
        about: json['about'],
        isDarkMood: json['isDarkMood'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'name': name,
        'email': email,
        'about': about,
        'isDarkMood': isDarkMood,
      };
}
