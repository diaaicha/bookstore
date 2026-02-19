import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../models/user_model.dart';
import '../../services/api_services.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() =>
      _AdminUsersScreenState();
}

class _AdminUsersScreenState
    extends State<AdminUsersScreen> {

  late Future<List<UserModel>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = ApiService.getUsers();
  }

  void _refresh() {
    setState(() {
      futureUsers = ApiService.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Gestion des utilisateurs"),
        actions: [
          IconButton(
            onPressed: _refresh,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: FutureBuilder<List<UserModel>>(
        future: futureUsers,
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          final users = snapshot.data!;

          return ListView.builder(
            padding:
            const EdgeInsets.all(AppSizes.paddingM),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return _userCard(user);
            },
          );
        },
      ),
    );
  }

  Widget _userCard(UserModel user) {
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
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Text(
            user.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.gray700,
            ),
          ),

          Text(user.email),
          Text(user.phone),

          if (user.createdAt != null)
            Text(
              "Inscrit le: ${user.createdAt!.day}/${user.createdAt!.month}/${user.createdAt!.year}",
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.gray500,
              ),
            ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [

              DropdownButton<String>(
                value: user.role,
                items: const [
                  DropdownMenuItem(
                    value: "user",
                    child: Text("User"),
                  ),
                  DropdownMenuItem(
                    value: "admin",
                    child: Text("Admin"),
                  ),
                ],
                onChanged: (value) async {
                  await ApiService.updateUserRole(
                      user.uid, value!);
                  _refresh();
                },
              ),

              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.red,
                ),
                onPressed: () async {
                  await ApiService.deleteUser(user.uid);
                  _refresh();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
