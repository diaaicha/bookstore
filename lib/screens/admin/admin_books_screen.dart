import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../models/book_model.dart';
import '../../services/api_services.dart';
import 'add_edit_book_screen.dart';

class AdminBooksScreen extends StatefulWidget {
  const AdminBooksScreen({super.key});

  @override
  State<AdminBooksScreen> createState() =>
      _AdminBooksScreenState();
}

class _AdminBooksScreenState
    extends State<AdminBooksScreen> {

  late Future<List<BookModel>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = ApiService.getBooks();
  }

  void _refresh() {
    setState(() {
      futureBooks = ApiService.getBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Gestion des livres"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditBookScreen(),
            ),
          );
          _refresh();
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<BookModel>>(
        future: futureBooks,
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          final books = snapshot.data!;

          return ListView.builder(
            padding:
            const EdgeInsets.all(AppSizes.paddingM),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return _bookCard(book);
            },
          );
        },
      ),
    );
  }

  Widget _bookCard(BookModel book) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingM),
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray200,
            blurRadius: 6,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// IMAGE FIXED WIDTH
          SizedBox(
            width: 60,
            height: 80,
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(AppSizes.radiusS),
              child: Image.network(
                book.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image),
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// INFOS
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.gray700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "${book.price} FCFA",
                  style: const TextStyle(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          /// ACTIONS VERTICALES
          Column(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                  color: AppColors.blue,
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          AddEditBookScreen(book: book),
                    ),
                  );
                  _refresh();
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  size: 20,
                  color: AppColors.red,
                ),
                onPressed: () async {
                  await ApiService.deleteBook(book.id);
                  _refresh();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

}
