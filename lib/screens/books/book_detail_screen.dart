import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/book_provider.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/buttons/primary_button.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final book = context.watch<BookProvider>().selectedBook!;

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(book.image, height: 240),
            const SizedBox(height: 16),
            Text(book.description),
            const Spacer(),
            PrimaryButton(
              text: 'Ajouter au panier',
              onPressed: () {
                context.read<CartProvider>().addToCart(book);
              },
            )
          ],
        ),
      ),
    );
  }
}
