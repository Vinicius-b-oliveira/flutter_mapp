class Activity {
  final String activity;
  final double accessibility;
  final String type;
  final int participants;
  final double price;
  final String? link;
  final String? key;
  final String? duration;
  final bool? kidFriendly;

  const Activity({
    required this.activity,
    required this.accessibility,
    required this.type,
    required this.participants,
    required this.price,
    this.link,
    this.key,
    this.duration,
    this.kidFriendly,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      activity: json['activity'] as String,
      accessibility:
          (json['accessibility'] is String)
              ? _parseAccessibility(json['accessibility'] as String)
              : (json['accessibility'] as num).toDouble(),
      type: json['type'] as String,
      participants: json['participants'] as int? ?? json['participants'] as int,
      price: (json['price'] as num).toDouble(),
      link: json['link'] as String?,
      key: json['key'] as String?,
      duration: json['duration'] as String?,
      kidFriendly: json['kidFriendly'] as bool?,
    );
  }

  static double _parseAccessibility(String value) {
    switch (value.toLowerCase()) {
      case 'high':
        return 0.8;
      case 'medium':
        return 0.5;
      case 'low':
        return 0.2;
      default:
        return 0.5;
    }
  }
}
