import 'package:flutter/material.dart';

import '../models/bookModels.dart';
import 'detail.dart';

const Color _sand = Color(0xFFF3E6D5);
const Color _wine = Color(0xFF800020);
const Color _coral = Color(0xFFD45060);
const Color _paper = Color(0xFFFFF9F2);

class LibraryPage extends StatelessWidget {
	const LibraryPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: _sand,
			appBar: AppBar(
				title: const Text('PustakaKu'),
				backgroundColor: _wine,
				foregroundColor: _paper,
				actions: [
					IconButton(
						tooltip: 'Logout',
						onPressed: () {
							Navigator.of(context).pushNamedAndRemoveUntil(
								'/login',
								(route) => false,
							);
						},
						icon: const Icon(Icons.logout_rounded),
					),
					const SizedBox(width: 8),
				],
			),
			body: Center(
				child: ConstrainedBox(
					constraints: const BoxConstraints(maxWidth: 1120),
					child: Padding(
						padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								const Text(
									'Koleksi Buku',
									style: TextStyle(
										color: _wine,
										fontSize: 24,
										fontWeight: FontWeight.w600,
									),
								),
								const SizedBox(height: 16),
								Expanded(
									child: LayoutBuilder(
										builder: (context, constraints) {
											final columns = switch (constraints.maxWidth) {
												>= 850 => 4,
												>= 560 => 3,
												_ => 2,
											};

											return GridView.builder(
												itemCount: bookList.length,
												gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
													crossAxisCount: columns,
													crossAxisSpacing: 14,
													mainAxisSpacing: 14,
													childAspectRatio: 0.62,
												),
												itemBuilder: (context, index) {
													final book = bookList[index];
													return _BookTile(book: book);
												},
											);
										},
									),
								),
							],
						),
					),
				),
			),
		);
	}
}

class _BookTile extends StatelessWidget {
	const _BookTile({required this.book});

	final BookModel book;

	@override
	Widget build(BuildContext context) {
		return Material(
			color: _paper,
			borderRadius: BorderRadius.circular(8),
			clipBehavior: Clip.antiAlias,
			child: InkWell(
				onTap: () {
					Navigator.of(context).push(
						MaterialPageRoute<void>(
							builder: (_) => BookDetailPage(book: book),
						),
					);
				},
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Expanded(
							child: SizedBox.expand(
								child: Image.network(
									book.imageUrl,
									fit: BoxFit.cover,
									errorBuilder: (context, error, stackTrace) => const ColoredBox(
										color: _sand,
										child: Center(
											child: Icon(
												Icons.menu_book_rounded,
												color: _wine,
												size: 42,
											),
										),
									),
									loadingBuilder: (context, child, progress) {
										if (progress == null) return child;
										return const ColoredBox(
											color: _sand,
											child: Center(
												child: CircularProgressIndicator(
													color: _coral,
													strokeWidth: 2,
												),
											),
										);
									},
								),
							),
						),
						Padding(
							padding: const EdgeInsets.fromLTRB(12, 11, 12, 12),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text(
										book.title,
										maxLines: 2,
										overflow: TextOverflow.ellipsis,
										style: const TextStyle(
											color: _wine,
											fontSize: 14,
											fontWeight: FontWeight.w600,
											height: 1.25,
										),
									),
									const SizedBox(height: 5),
									Text(
										book.author,
										maxLines: 1,
										overflow: TextOverflow.ellipsis,
										style: const TextStyle(color: Colors.black54, fontSize: 12),
									),
									const SizedBox(height: 3),
									Text(
										'${book.year}',
										style: const TextStyle(color: _coral, fontSize: 12),
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
