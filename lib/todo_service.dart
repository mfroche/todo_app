import 'package:hive/hive.dart';

import 'todo_item.dart';

class TodoService {
  final String _boxName = "todoBox";

  Future<Box<TodoItem>> get _box async =>
      await Hive.openBox<TodoItem>(_boxName);

  //add todo item to Hive box
  Future<void> addItem(TodoItem todoItem) async {
    var box = await _box;
    box.add(todoItem);
  }

  //retrieve todo items from Hive box
  Future<List<TodoItem>> getAllTodos(TodoItem todoItem) async {
    var box = await _box;
    return box.values.toList();
  }

  //delete todo item in Hive box
  Future<void> deleteTodo(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }

  Future<void> toggleCompleted(int index, TodoItem todoItem) async {
    var box = await _box;
    todoItem.isCompleted = !todoItem.isCompleted;
    await box.putAt(index, todoItem);
  }
}
