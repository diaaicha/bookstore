import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../models/book_model.dart';
import '../models/dashboard_model.dart';
import '../models/notification_model.dart';
import '../models/order_model.dart';
import '../models/user_model.dart';

class ApiService {

  // ⚠️ EMULATEUR ANDROID
  static const String baseUrl =
      "http://10.0.2.2/admin_api";

  // ================= DASHBOARD =================
  static Future<DashboardModel> getDashboardStats() async {

    final response = await http.get(
      Uri.parse("$baseUrl/dashboard/dashboard_stats.php"),
    );

    if (response.statusCode == 200) {
      return DashboardModel.fromJson(
          jsonDecode(response.body));
    } else {
      print("Dashboard Error:");
      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");
      throw Exception("Erreur dashboard");
    }
  }

  // ================= BOOKS =================
  static Future<List<BookModel>> getBooks() async {

    final response = await http.get(
      Uri.parse("$baseUrl/books/get_books.php"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data
          .map((e) => BookModel.fromJson(e))
          .toList();
    } else {
      print("Books Error: ${response.body}");
      throw Exception("Erreur chargement livres");
    }
  }

  static Future<void> addBook(
      Map<String, dynamic> data) async {

    final response = await http.post(
      Uri.parse("$baseUrl/books/add_book.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      print("Add Book Error: ${response.body}");
      throw Exception("Erreur ajout livre");
    }
  }

  static Future<void> updateBook(
      Map<String, dynamic> data) async {

    final response = await http.post(
      Uri.parse("$baseUrl/books/update_book.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      print("Update Book Error: ${response.body}");
      throw Exception("Erreur modification livre");
    }
  }

  static Future<void> deleteBook(int id) async {

    final response = await http.post(
      Uri.parse("$baseUrl/books/delete_book.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id": id}),
    );

    if (response.statusCode != 200) {
      print("Delete Book Error: ${response.body}");
      throw Exception("Erreur suppression livre");
    }
  }

  // ================= ORDERS =================
  static Future<List<OrderModel>> getOrders() async {

    final response = await http.get(
      Uri.parse("$baseUrl/orders/get_orders.php"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data
          .map((json) =>
          OrderModel.fromJson(json))
          .toList();
    } else {
      print("Orders Error: ${response.body}");
      throw Exception("Erreur chargement commandes");
    }
  }

  static Future<void> updateOrderStatus(
      String orderId, String status) async {

    final response = await http.post(
      Uri.parse("$baseUrl/orders/update_order_status.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": orderId,
        "status": status,
      }),
    );

    if (response.statusCode != 200) {
      print("Update Status Error: ${response.body}");
      throw Exception("Erreur mise à jour statut");
    }
  }

  // ================= NOTIFICATIONS =================
  static Future<List<NotificationModel>> getNotifications(
      String userId) async {

    final response = await http.get(
      Uri.parse("$baseUrl/notifications/get_notifications.php?user_id=$userId"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data
          .map((e) =>
          NotificationModel.fromJson(e))
          .toList();
    } else {
      print("Notification Error: ${response.body}");
      throw Exception("Erreur notifications");
    }
  }

  // ================= USERS =================
  static Future<List<UserModel>> getUsers() async {

    final response = await http.get(
      Uri.parse("$baseUrl/users/get_users.php"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data
          .map((e) =>
          UserModel.fromJson(e))
          .toList();
    } else {
      print("Users Error: ${response.body}");
      throw Exception("Erreur chargement utilisateurs");
    }
  }

  static Future<void> updateUserRole(
      String uid, String role) async {

    final response = await http.post(
      Uri.parse("$baseUrl/users/update_user_role.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "uid": uid,
        "role": role,
      }),
    );

    if (response.statusCode != 200) {
      print("Update Role Error: ${response.body}");
      throw Exception("Erreur modification rôle");
    }
  }

  static Future<void> deleteUser(String uid) async {

    final response = await http.post(
      Uri.parse("$baseUrl/users/delete_user.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"uid": uid}),
    );

    if (response.statusCode != 200) {
      print("Delete User Error: ${response.body}");
      throw Exception("Erreur suppression utilisateur");
    }
  }

  static Future<String?> uploadImage(
      XFile imageFile) async {

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/books/upload_image.php"),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      ),
    );

    var response = await request.send();

    var resBody =
    await response.stream.bytesToString();

    print("UPLOAD RESPONSE: $resBody"); // 🔥 DEBUG

    if (response.statusCode == 200) {

      final data = jsonDecode(resBody);

      if (data["success"] == true) {
        return data["url"];
      }
    }

    return null;
  }



}
