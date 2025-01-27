import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isFavourite;
  final int? number;
  final String? title;
  final String? data;
  final ValueChanged<bool> onChangedFavorite;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedData;

  const NoteFormWidget({
    super.key,
    this.isFavourite = false,
    this.number = 0,
    this.title = '',
    this.data = '',
    required this.onChangedFavorite,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedData,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          const SizedBox(height: 8),
          buildDescription(),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    style: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Title',
      hintStyle: TextStyle(color: Colors.black),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'The title cannot be empty' : null,
    onChanged: onChangedTitle,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 5,
    initialValue: data,
    style: const TextStyle(color: Colors.black, fontSize: 18),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Type something...',
      hintStyle: TextStyle(color: Colors.black),
    ),
    validator: (title) => title != null && title.isEmpty
        ? 'Note cannot be empty'
        : null,
    onChanged: onChangedData,
  );
}