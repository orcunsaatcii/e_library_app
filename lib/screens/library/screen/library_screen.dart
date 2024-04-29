import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_ibrary_app/providers/active_button_provider.dart';
import 'package:e_ibrary_app/providers/active_library_view.dart';
import 'package:e_ibrary_app/screens/library/widgets/filter_buttons.dart';
import 'package:e_ibrary_app/screens/library/widgets/library_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        ref.watch(activeLibraryProvider);

    final activeButton = ref.watch(activeButtonProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const FilterButtons(),
            const SizedBox(height: 15),
            StreamBuilder(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      activeButton != ActiveButton.magazines
                          ? 'No books found'
                          : 'No magazines found',
                      style: const TextStyle(color: Colors.black),
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
                final loadedMagazines = snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                    itemCount: loadedMagazines.length,
                    itemBuilder: (context, index) =>
                        LibraryItem(item: loadedMagazines[index]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
