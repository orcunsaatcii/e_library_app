import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_ibrary_app/providers/active_button_provider.dart';
import 'package:e_ibrary_app/screens/book_detail/screen/book_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryItem extends ConsumerStatefulWidget {
  const LibraryItem({super.key, required this.item});

  final QueryDocumentSnapshot<Map<String, dynamic>> item;

  @override
  ConsumerState<LibraryItem> createState() => _LibraryItemState();
}

class _LibraryItemState extends ConsumerState<LibraryItem> {
  @override
  Widget build(BuildContext context) {
    ActiveButton activeButton = ref.watch(activeButtonProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailScreen(book: widget.item),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.item['image_links']['thumbnail'],
              width: 50,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item['title'],
                    softWrap: true,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    (widget.item['authors'].isEmpty)
                        ? '-'
                        : (widget.item['authors'].length == 1)
                            ? widget.item['authors'][0]
                            : '${widget.item['authors'][0]} & ${widget.item['authors'][1]}',
                    style: const TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                  const SizedBox(height: 7),
                  if (activeButton == ActiveButton.paidBooks)
                    Text(
                      (widget.item['sale_info']['listPrice']['currencyCode'] ==
                              'TRY')
                          ? '₺${widget.item['sale_info']['listPrice']['amount']}'
                          : '\$'
                              '${widget.item['sale_info']['listPrice']['amount']}',
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
