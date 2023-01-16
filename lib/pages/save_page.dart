import 'package:flutter/material.dart';

import '../db/operation.dart';
import '../models/note.dart';

class SavePage extends StatelessWidget {
  //const SavePage({super.key});

  static const String ROUTE = "/save";

  final _formKey = GlobalKey<FormState>();
  final titleControler = TextEditingController();
  final contentControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Note note = ModalRoute.of(context).settings.arguments;
    _init(note);

    return Scaffold(
      appBar: AppBar(
        title: Text("Guardar"),
      ),
      body: Container(
        child: _buildform(note),
      ),
    );
  }

  _init(Note note) {
    titleControler.text = note.title;
    contentControler.text = note.content;
  }

  Widget _buildform(Note note) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: titleControler,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Tiene que colocar data";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Titulo",
                border: OutlineInputBorder(), //
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: contentControler,
              maxLines: 8,
              maxLength: 1000,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Tiene que colocar data";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Contenido",
                border: OutlineInputBorder(), //
              ),
            ),
            ElevatedButton(
                child: const Text("Guardar"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("valido " + titleControler.text);

                    Operation.insert(Note(
                      title: titleControler.text,
                      content: contentControler.text,
                    ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
