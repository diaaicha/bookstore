class DashboardModel {
  final int totalOrders;
  final int totalRevenue;
  final int totalBooks;
  final int totalUsers;
  final Map<String, dynamic> statusStats;

  DashboardModel({
    required this.totalOrders,
    required this.totalRevenue,
    required this.totalBooks,
    required this.totalUsers,
    required this.statusStats,
  });

  factory DashboardModel.fromJson(
      Map<String, dynamic> json) {

    Map<String, dynamic> safeStatus = {};

    if (json['statusStats'] is Map) {
      safeStatus = Map<String, dynamic>.from(
          json['statusStats']);
    }

    return DashboardModel(
      totalOrders:
      int.tryParse(json['totalOrders'].toString()) ?? 0,
      totalRevenue:
      int.tryParse(json['totalRevenue'].toString()) ?? 0,
      totalBooks:
      int.tryParse(json['totalBooks'].toString()) ?? 0,
      totalUsers:
      int.tryParse(json['totalUsers'].toString()) ?? 0,
      statusStats: safeStatus,
    );
  }
}
