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
import '../../screens/profile/profile_screen.dart';
import '../../screens/profile/addresses_screen.dart';
import '../../screens/orders/order_detail_screen.dart';
import '../../screens/profile/addresses_screen.dart';
import '../../screens/payment/add_payment_method_screen.dart';
import '../../models/order_model.dart';



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

    orderDetail: (context) {
      final order =
      ModalRoute.of(context)!.settings.arguments as OrderModel;
      return OrderDetailScreen(order: order);
    },

  };
}
