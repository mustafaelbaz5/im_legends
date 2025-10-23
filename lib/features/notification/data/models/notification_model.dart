import 'dart:convert';

import 'package:uuid/uuid.dart';

enum NotificationType { welcome, update, security, promotion, system }

class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String message;
  final DateTime time;
  bool isRead;
  final NotificationType type;

  NotificationModel({
    String? id,
    required this.userId,
    required this.title,
    required this.message,
    DateTime? time,
    this.isRead = false,
    this.type = NotificationType.system,
  }) : id = id ?? const Uuid().v4(),
       time = time ?? DateTime.now();

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      time: DateTime.parse(json['time'] as String),
      isRead: json['isRead'] as bool,
      type: NotificationType.values.firstWhere(
        (e) => e.name == json['type'] as String,
        orElse: () => NotificationType.system,
      ),
    );
  }

  /// Factory from Supabase row
  factory NotificationModel.fromSupabase(Map<String, dynamic> row) {
    return NotificationModel(
      id: row['notification_id'] as String?,
      userId: row['user_id'] as String,
      title: row['title'] as String,
      message: row['message'] as String,
      time: DateTime.parse(row['created_at'] as String),
      isRead: row['is_read'] as bool,
      type: NotificationType.values.firstWhere(
        (e) => e.name == row['type'] as String,
        orElse: () => NotificationType.system,
      ),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'message': message,
    'time': time.toIso8601String(),
    'isRead': isRead,
    'type': type.name,
  };

  /// Convert to Supabase format
  Map<String, dynamic> toSupabase() => {
    'user_id': userId,
    'notification_id': id,
    'title': title,
    'message': message,
    'created_at': time.toIso8601String(),
    'is_read': isRead,
    'type': type.name,
  };

  /// Encode / decode JSON string
  String encode() => json.encode(toJson());
  static NotificationModel decode(String encoded) =>
      NotificationModel.fromJson(json.decode(encoded) as Map<String, dynamic>);

  /// Copy with modifications
  NotificationModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? message,
    DateTime? time,
    bool? isRead,
    NotificationType? type,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      message: message ?? this.message,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
    );
  }
}
