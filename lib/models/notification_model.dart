class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String orderId;
  final DateTime createdAt;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.orderId,
    required this.createdAt,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: int.parse(json['id'].toString()),
      title: json['title'],
      message: json['message'],
      orderId: json['order_id'],
      createdAt: DateTime.parse(json['created_at']),
      isRead: json['is_read'] == 1,
    );
  }
}
