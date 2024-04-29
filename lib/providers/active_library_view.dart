import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveLibraryNotifier
    extends StateNotifier<Stream<QuerySnapshot<Map<String, dynamic>>>> {
  ActiveLibraryNotifier()
      : super(FirebaseFirestore.instance.collection('books').snapshots());

  void setActiveLibrary(Stream<QuerySnapshot<Map<String, dynamic>>> booksType) {
    state = booksType;
  }
}

final activeLibraryProvider = StateNotifierProvider<ActiveLibraryNotifier,
    Stream<QuerySnapshot<Map<String, dynamic>>>>((ref) {
  return ActiveLibraryNotifier();
});
