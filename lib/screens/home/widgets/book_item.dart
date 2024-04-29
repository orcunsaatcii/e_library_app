import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_ibrary_app/screens/book_detail/screen/book_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookItem extends StatelessWidget {
  const BookItem({super.key, required this.book});

  final QueryDocumentSnapshot<Map<String, dynamic>> book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailScreen(book: book),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(right: 15),
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Hero(
                tag: book['title'],
                child: Image.network(
                  book['image_links']['thumbnail'],
                  width: 150,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              book['title'].toString(),
              softWrap: true,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
