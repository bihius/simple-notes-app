import 'package:flutter/material.dart';
import 'package:dsw52703/db/notes_database.dart';
import 'package:dsw52703/models/note.dart';
import 'package:dsw52703/views/widgets/note_form.dart';


class AddEditNoteView extends StatefulWidget {
  final Note? note;

  const AddEditNoteView({
    super.key,
    this.note,
  });

  @override
  State<AddEditNoteView> createState() => _AddEditNoteViewState();
}

class _AddEditNoteViewState extends State<AddEditNoteView> {
  final _formKey = GlobalKey<FormState>();
  late bool isFavourite;
  late int number;
  late String title;
  late String data;

  @override
  void initState() {
    super.initState();

    isFavourite = widget.note?.isFavourite ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    data = widget.note?.data ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [
        IconButton(
          icon: Icon(
            isFavourite ? Icons.star : Icons.star_border, size: 32,
            color: isFavourite ? Colors.yellow : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              isFavourite = !isFavourite;
            });
          },
        ),
        buildButton(),
      ],
    ),
    body: Form(
      key: _formKey,
      child: NoteFormWidget(
        isFavourite: isFavourite,
        number: number,
        title: title,
        data: data,
        onChangedFavorite: (isFavourite) =>
            setState(() => this.isFavourite = isFavourite),
        onChangedNumber: (number) => setState(() => this.number = number),
        onChangedTitle: (title) => setState(() => this.title = title),
        onChangedData: (data) =>
            setState(() => this.data = data),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && data.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        icon: const Icon(Icons.save),
        label: const Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isFavourite: isFavourite,
      number: number,
      title: title,
      data: data,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      isFavourite: true,
      number: number,
      data: data,
      createdTime: DateTime.now().toString(),
    );

    await NotesDatabase.instance.create(note);
  }
}