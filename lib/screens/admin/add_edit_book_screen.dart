import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/sizes.dart';
import '../../models/book_model.dart';
import '../../services/api_services.dart';
import '../../providers/book_provider.dart';

class AddEditBookScreen extends StatefulWidget {
  final BookModel? book;

  const AddEditBookScreen({super.key, this.book});

  @override
  State<AddEditBookScreen> createState() =>
      _AddEditBookScreenState();
}

class _AddEditBookScreenState
    extends State<AddEditBookScreen> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController authorController;
  late TextEditingController priceController;
  late TextEditingController categoryController;
  late TextEditingController descriptionController;

  XFile? selectedImage;
  String? imageUrl;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(text: widget.book?.title ?? '');

    authorController =
        TextEditingController(text: widget.book?.author ?? '');

    priceController =
        TextEditingController(text: widget.book?.price.toString() ?? '');

    categoryController =
        TextEditingController(text: widget.book?.category ?? '');

    descriptionController =
        TextEditingController(text: widget.book?.description ?? '');

    imageUrl = widget.book?.image;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final image =
    await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  Future<void> _saveBook() async {

    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {

      /// Upload image si nouvelle sélection
      if (selectedImage != null) {
        imageUrl =
        await ApiService.uploadImage(selectedImage!);
      }

      /// Création BookModel pour le Provider
      final newBook = BookModel(
        id: widget.book?.id ??
            DateTime.now().millisecondsSinceEpoch,
        title: titleController.text,
        author: authorController.text,
        price: int.parse(priceController.text),
        oldPrice: widget.book?.oldPrice,
        discount: widget.book?.discount,
        image: imageUrl ?? '',
        category: categoryController.text,
        rating: widget.book?.rating ?? 0,
        reviews: widget.book?.reviews ?? 0,
        description: descriptionController.text,
        publisher: widget.book?.publisher ?? "",
        pages: widget.book?.pages ?? 0,
        isbn: widget.book?.isbn ?? "",
        inStock: true,
        releaseDate: DateTime.now(),
      );

      final provider = context.read<BookProvider>();

      if (widget.book == null) {
        /// ➜ AJOUT LOCAL
        provider.addBook(newBook);

        /// ➜ AJOUT API
        await ApiService.addBook(newBook.toJson());

      } else {
        /// ➜ UPDATE LOCAL
        provider.updateBook(newBook);

        /// ➜ UPDATE API
        await ApiService.updateBook(newBook.toJson());
      }

      Navigator.pop(context);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur : $e"),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          widget.book == null
              ? "Ajouter un livre"
              : "Modifier le livre",
        ),
      ),
      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(AppSizes.paddingM),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              /// IMAGE
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius:
                    BorderRadius.circular(
                        AppSizes.radiusM),
                  ),
                  child: selectedImage != null
                      ? Image.file(
                    File(selectedImage!.path),
                    fit: BoxFit.cover,
                  )
                      : (imageUrl != null &&
                      imageUrl!.isNotEmpty)
                      ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, __, ___) =>
                    const Icon(
                      Icons.broken_image,
                      size: 50,
                    ),
                  )
                      : const Icon(
                    Icons.add_a_photo,
                    size: 50,
                    color:
                    AppColors.gray500,
                  ),
                ),
              ),

              const SizedBox(
                  height: AppSizes.paddingL),

              _inputField("Titre", titleController),
              _inputField("Auteur", authorController),
              _inputField("Prix", priceController,
                  isNumber: true),
              _inputField(
                  "Catégorie", categoryController),
              _inputField(
                  "Description", descriptionController,
                  maxLines: 3),

              const SizedBox(
                  height: AppSizes.paddingL),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    AppColors.primary,
                    padding:
                    const EdgeInsets.all(
                        AppSizes.paddingM),
                  ),
                  onPressed:
                  isLoading ? null : _saveBook,
                  child: isLoading
                      ? const CircularProgressIndicator(
                      color: Colors.white)
                      : const Text(
                    "Enregistrer",
                    style: TextStyle(
                        color:
                        AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(
      String label,
      TextEditingController controller, {
        bool isNumber = false,
        int maxLines = 1,
      }) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: AppSizes.paddingM),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber
            ? TextInputType.number
            : TextInputType.text,
        maxLines: maxLines,
        validator: (value) {
          if (value == null ||
              value.isEmpty) {
            return "Champ obligatoire";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(
                AppSizes.radiusM),
          ),
        ),
      ),
    );
  }
}
