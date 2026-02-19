import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../models/notification_model.dart';
import '../../services/api_services.dart';

class NotificationsScreen extends StatefulWidget {
  final String userId;

  const NotificationsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<NotificationsScreen> {

  late Future<List<NotificationModel>> futureNotifs;

  @override
  void initState() {
    super.initState();
    futureNotifs =
        ApiService.getNotifications(widget.userId);
  }

  void _refresh() {
    setState(() {
      futureNotifs =
          ApiService.getNotifications(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Notifications'),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: futureNotifs,
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          final notifications = snapshot.data!;

          if (notifications.isEmpty) {
            return const Center(
              child: Text(
                "Aucune notification",
                style: TextStyle(
                  color: AppColors.gray500,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _refresh(),
            child: ListView.builder(
              padding:
              const EdgeInsets.all(AppSizes.paddingM),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];

                return _notificationCard(notif);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _notificationCard(NotificationModel notif) {
    return Container(
      margin:
      const EdgeInsets.only(bottom: AppSizes.paddingM),
      padding:
      const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius:
        BorderRadius.circular(AppSizes.radiusM),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray200,
            blurRadius: 6,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          /// 🔔 Icon
          Container(
            padding: const EdgeInsets.all(
                AppSizes.paddingS),
            decoration: BoxDecoration(
              color: notif.isRead
                  ? AppColors.gray200
                  : AppColors.primary
                  .withOpacity(0.15),
              borderRadius:
              BorderRadius.circular(
                  AppSizes.radiusS),
            ),
            child: Icon(
              Icons.notifications,
              color: notif.isRead
                  ? AppColors.gray500
                  : AppColors.primary,
            ),
          ),

          const SizedBox(
              width: AppSizes.paddingM),

          /// 📄 Text
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  notif.title,
                  style: const TextStyle(
                    fontWeight:
                    FontWeight.bold,
                    color:
                    AppColors.gray700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notif.message,
                  style: const TextStyle(
                    color:
                    AppColors.gray500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatDate(notif.createdAt),
                  style: const TextStyle(
                    fontSize: 12,
                    color:
                    AppColors.gray400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
