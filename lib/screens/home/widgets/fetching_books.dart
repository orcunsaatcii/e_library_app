import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_ibrary_app/screens/home/widgets/book_item.dart';
import 'package:flutter/material.dart';

class FetchBooks extends StatelessWidget {
  const FetchBooks({super.key, required this.subject});

  final String subject;

  @override
  Widget build(BuildContext context) {
    String formatSubject(String subject) {
      String temp = subject.replaceFirst(subject[0], subject[0].toUpperCase());
      String formattedSubject = temp.replaceFirst('+', ' & ');
      return formattedSubject;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formatSubject(subject),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('${subject}_books')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'No books found',
                  style: TextStyle(color: Colors.black),
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Something went wrong !',
                  style: TextStyle(color: Colors.black),
                ),
              );
            }
            final loadedBooks = snapshot.data!.docs;
            return SizedBox(
              height: 250,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: loadedBooks.length,
                itemBuilder: (context, index) =>
                    BookItem(book: loadedBooks[index]),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
