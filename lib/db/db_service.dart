import 'package:hive/hive.dart';

class DBService {
  // Create
  Future<void> openBox() async {
    var box = await Hive.openBox("todo");
  }

  Future<void> writeToDB(String userData) async {
    await Hive.box("todo").add(userData);
  }

  // Read
  Future<dynamic> getTodo() async {
    try {
      await openBox();
      return Hive.box("todo").values.toList();
    } catch (e) {
      return e.toString();
    }
  }
  // Update
  // Delete
}
