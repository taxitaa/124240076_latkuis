import 'package:flutter/material.dart';

import '../models/bookModels.dart';

const Color _sand = Color(0xFFF3E6D5);
const Color _wine = Color(0xFF800020);
const Color _coral = Color(0xFFD45060);
const Color _paper = Color(0xFFFFF9F2);

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _sand,
      appBar: AppBar(
        title: Text(book.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        backgroundColor: _wine,
        foregroundColor: _paper,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 220,
                      height: 300,
                      child: Image.network(
                        book.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const ColoredBox(
                              color: _paper,
                              child: Icon(
                                Icons.menu_book_rounded,
                                color: _wine,
                                size: 64,
                              ),
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  book.title,
                  style: const TextStyle(
                    color: _wine,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${book.author}  ·  ${book.year}',
                  style: const TextStyle(color: Colors.black54, fontSize: 15),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _InfoChip(label: book.genre),
                    _InfoChip(label: 'Rating ${book.rating}'),
                    _InfoChip(label: '${book.pages} halaman'),
                  ],
                ),
                const SizedBox(height: 22),
                const Text(
                  'Tentang buku',
                  style: TextStyle(
                    color: _wine,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book.description,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Penerbit: ${book.publisher}',
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _sand),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(label, style: const TextStyle(color: _wine, fontSize: 13)),
      ),
    );
  }
}
