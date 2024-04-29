//import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:e_ibrary_app/models/book.dart';
import 'package:e_ibrary_app/screens/home/widgets/fetching_books.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> subjects = [
    'horror',
    'fiction',
    'drama',
    'politics',
    'history',
    'philosophy',
    'religion',
    'art',
    'business+economics',
    'computers',
    'biography+autobiography',
    'adventure',
    'education',
  ];

  String username = '';

  @override
  void initState() {
    getUserData();
    //loadAllBooks();
    super.initState();
  }

  void getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      username = userData.data()!['username'];
    });
  }

  //! Fetching data from api codes.
  /*void laodBooks(String subject) async {
    int maxResults = 40;
    final url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=subject:$subject&printType=books&maxResults=$maxResults&key=AIzaSyCnOLkw1Jet0UHAl3tx2vbA_uf7JjA0Oak');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> items = data['items'];
        for (final item in items) {
          Book book = Book.fromJson(item);
          //! storing the firestore.
          Book.uploadBookToFirebase(book, subject);
        }
      } else {
        print(response.statusCode);
      }
    } catch (err) {
      print(err);
    }
  }

  void loadAllBooks() {
    for (final subject in subjects) {
      laodBooks(subject);
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 25,
            left: 25,
            top: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi $username',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'What book are you\npicking up today ?',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 50),
                for (final subject in subjects) FetchBooks(subject: subject),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
