import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:dsw52703/db/notes_database.dart';
import 'package:dsw52703/models/note.dart';
import 'package:dsw52703/views/home/note_detail_view.dart';
import 'package:dsw52703/views/home/edit_note_view.dart';
import 'package:dsw52703/views/widgets/note_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    try {
      final allNotes = await NotesDatabase.instance.readAllNotes();
      setState(() => notes = allNotes);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to read notes'),
        ),
      );
    }
    finally {
      setState(() => isLoading = false);
    }


  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Notes', style: TextStyle(fontSize: 24)),
      actions: const [Icon(Icons.search), SizedBox(width: 12)],
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
              ? const Text('No Notes',
            style: TextStyle(color: Colors.white, fontSize: 24),
          )
              : buildNotes(),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.black87,
      child: Icon(Icons.add, color: Colors.white),
      onPressed: () async {
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddEditNoteView()));
        refreshNotes();
      },
    ),
  );

  Widget buildNotes() => StaggeredGridView.countBuilder(
    crossAxisCount: 2,
    mainAxisSpacing: 2,
    crossAxisSpacing: 2,
    itemCount: notes.length,
    itemBuilder: (context, index) {
      final note = notes[index];
      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteDetailPage(noteId: note.id!),
          ));
          refreshNotes();
        },
        child: NoteCardWidget(note: note, index: index),
      );
    },
    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
  );
}