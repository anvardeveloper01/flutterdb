import 'package:flutter/material.dart';
import 'package:workwithdb/db/db_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _todoController = TextEditingController();
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  @override
  Scaffold build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("TODO"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Task kiritish uchun joy
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (v) {
                    if (v!.length < 3) {
                      return "Kamida 3 ta belgi kirit";
                    } else {
                      return null;
                    }
                  },
                  key: _key,
                  controller: _todoController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Vazifani kirit",
                  ),
                ),
              ),
            ),
            // Kiritilgan tasklar
            Expanded(
              flex: 8,
              child: FutureBuilder(
                future: DBService().getTodo(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (snapshot.data is String) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (c, i) {
                        return ListTile(
                          title: Text(snapshot.data[i]),
                        );
                      },
                      itemCount: (snapshot.data as List).length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (_key.currentState!.isValid) {
              await DBService().openBox();
              await DBService().writeToDB(_todoController.text);
              setState(() {});
            }
          },
          label: const Text("Saqlash"),
        ),
      );
}
