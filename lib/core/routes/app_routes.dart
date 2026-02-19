import 'package:flutter/material.dart';

// SCREENS
import '../../screens/auth/auth_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/books/books_list_screen.dart';
import '../../screens/books/book_detail_screen.dart';
import '../../screens/books/search_screen.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/payment/payment_screen.dart';
import '../../screens/orders/orders_screen.dart';
import '../../screens/profile/edit_profile_screen.dart';
import '../../screens/profile/language_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/profile/addresses_screen.dart';
import '../../screens/orders/order_detail_screen.dart';
import '../../screens/profile/addresses_screen.dart';
import '../../screens/payment/add_payment_method_screen.dart';
import '../../models/order_model.dart';
import '../../screens/orders/order_tracking_screen.dart';
import '../../screens/profile/settings_screen.dart';
import '../../screens/profile/notifications_screen.dart';
import '../../screens/profile/help_support_screen.dart';
import '../../screens/profile/about_screen.dart';
import '../../screens/profile/favorites_screen.dart';
import '../../screens/admin/admin_dashboard_screen.dart';
import '../../screens/admin/admin_books_screen.dart';
import '../../screens/admin/admin_orders_screen.dart';
import '../../screens/admin/admin_users_screen.dart';


class AppRoutes {
  static const auth = '/auth';
  static const home = '/home';
  static const books = '/books';
  static const bookDetail = '/book-detail';
  static const search = '/search';
  static const cart = '/cart';
  static const payment = '/payment';
  static const orders = '/orders';
  static const profile = '/profile';
  static const notifications = '/notifications';
  static const categories = '/categories';
  static const orderDetail = '/order-detail';
  static const addPaymentMethod = '/add-payment-method';
  static const address = '/address';
  static const String orderTracking = '/order-tracking';
  static const settings = '/settings';
  static const editProfile = '/edit-profile';
  static const language = '/language';
  static const security = '/security';
  //static const notifications = '/notifications';
  static const helpSupport = '/help-support';
  static const about = '/about';
  static const favorites = '/favorites';
  static const adminDashboard = '/admin';
  static const adminBooks = '/admin-books';
  static const adminOrders = '/admin-orders';
  static const adminUsers = '/admin-users';




  static final Map<String, WidgetBuilder> routes = {
    auth: (_) =>  AuthScreen(),
    home: (_) => const HomeScreen(),
    books: (_) => const BooksListScreen(),
    bookDetail: (_) => const BookDetailScreen(),
    search: (_) => const SearchScreen(),
    cart: (_) => const CartScreen(),
    payment: (_) => const PaymentScreen(),
    orders: (_) => const OrdersScreen(),
    profile: (_) => const ProfileScreen(),
    address: (_) => const AddressesScreen(),
    addPaymentMethod: (_) => AddPaymentMethodScreen(),
    settings: (_) => const SettingsScreen(),
    editProfile: (_) => EditProfileScreen(),
    language: (_) => const LanguageScreen(),
    //security: (_) => const SecurityScreen(),
    //language: (context) => const LanguageScreen(),
    notifications: (_) => NotificationsScreen(),
    helpSupport: (_) => HelpSupportScreen(),
    about: (_) => AboutScreen(),
    favorites: (_) => const FavoritesScreen(),
    // adminDashboard: (_) => const AdminDashboardScreen(),
    // adminBooks: (_) => const AdminBooksScreen(),
    // adminOrders: (_) => const AdminOrdersScreen(),
    // adminUsers: (_) => const AdminUsersScreen(),


    orderDetail: (context) {
      final order =
      ModalRoute.of(context)!.settings.arguments as OrderModel;
      return OrderDetailScreen(order: order);
    },
    orderTracking: (context) {
      final order =
      ModalRoute.of(context)!.settings.arguments as OrderModel;
      return OrderTrackingScreen(order: order);
    },

  };
}
