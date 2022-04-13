import 'package:flutter/material.dart';
import 'package:flutter_sqlite/sqldb.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  SqlDb _sqldb = SqlDb();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // const TextField(
                  //   decoration: InputDecoration(
                  //     hintText: 'Enter Note',
                  //   ),
                  // ),
                  TextFormField(
                    controller: note,
                    decoration: const InputDecoration(
                      hintText: 'Enter Note',
                      label: Text('Note'),
                    ),
                  ),
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(
                      hintText: 'Enter Title',
                      label: Text('Title'),
                    ),
                  ),
                  TextFormField(
                    controller: color,
                    decoration: const InputDecoration(
                      hintText: 'Enter Color',
                      label: Text('Color'),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () async {
                      var response = _sqldb.insertData('''
                      INSERT INTO notes(title, notes, color) VALUES("${note.text}","${title.text}","${color.text}")
                      ''');

                      // clear text field
                      note.clear();
                      title.clear();
                      color.clear();

                      Navigator.of(context).pushNamed('/home');
                    },
                    child: const Text('Save'),
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
