import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_ibrary_app/providers/active_button_provider.dart';
import 'package:e_ibrary_app/providers/active_library_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterButtons extends ConsumerWidget {
  const FilterButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ActiveButton activeButton = ref.watch(activeButtonProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              ref
                  .read(activeButtonProvider.notifier)
                  .setActiveButton(ActiveButton.books);

              ref.read(activeLibraryProvider.notifier).setActiveLibrary(
                    FirebaseFirestore.instance.collection('books').snapshots(),
                  );
            },
            style: TextButton.styleFrom(
              shape: (activeButton == ActiveButton.books)
                  ? LinearBorder.bottom(
                      size: 0.6,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    )
                  : null,
            ),
            child: const Text('Books'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(activeButtonProvider.notifier)
                  .setActiveButton(ActiveButton.magazines);

              ref.read(activeLibraryProvider.notifier).setActiveLibrary(
                    FirebaseFirestore.instance
                        .collection('magazines')
                        .snapshots(),
                  );
            },
            style: TextButton.styleFrom(
              shape: (activeButton == ActiveButton.magazines)
                  ? LinearBorder.bottom(
                      size: 0.6,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    )
                  : null,
            ),
            child: const Text('Magazines'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(activeButtonProvider.notifier)
                  .setActiveButton(ActiveButton.freeBooks);

              ref.read(activeLibraryProvider.notifier).setActiveLibrary(
                    FirebaseFirestore.instance
                        .collection('free_books')
                        .snapshots(),
                  );
            },
            style: TextButton.styleFrom(
              shape: (activeButton == ActiveButton.freeBooks)
                  ? LinearBorder.bottom(
                      size: 0.6,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    )
                  : null,
            ),
            child: const Text('Free Books'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(activeButtonProvider.notifier)
                  .setActiveButton(ActiveButton.paidBooks);

              ref.read(activeLibraryProvider.notifier).setActiveLibrary(
                    FirebaseFirestore.instance
                        .collection('paid_books')
                        .snapshots(),
                  );
            },
            style: TextButton.styleFrom(
              shape: (activeButton == ActiveButton.paidBooks)
                  ? LinearBorder.bottom(
                      size: 0.6,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    )
                  : null,
            ),
            child: const Text('Paid Books'),
          ),
        ],
      ),
    );
  }
}
