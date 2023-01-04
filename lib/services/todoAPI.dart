import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:todo_api/models/todo.dart';

Future<List<Todo>> getTodo() async {
  String baseUrl = "https://motof.pythonanywhere.com/get/";
  // Uri url = Uri.parse(baseUrl);
  Uri url = Uri(
    scheme: 'https',
    host: 'motof.pythonanywhere.com',
    path: 'get',
  );
  // Make a request to the API
  final response = await http.get(url);
  // Check if the request was successful
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Todo> todos = [];

    for (var todo in jsonDecode(response.body)) {
      todos.add(Todo.fromJson(todo));
    }
    return todos.reversed.toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load todo');
  }
}

// Add todo task

Future addTask(Todo todo) async {
  Uri url = Uri.parse('https://motof.pythonanywhere.com/add/');

  var data = jsonEncode(todo.toJson());

  final response = await http.post(
    url,
    headers: {'Content-type': 'application/json'},
    body: jsonEncode(
      {
        'title': 'ok',
        'description': 'Muzan'
        // 'completed': todo.completed,
      },
    ),
  );
  print(response.body);
  if (response.statusCode == 200) {
    print('Todo added');
  } else {
    throw Exception('Failed to add todo');
  }
  
}
Future deleteTask(int index) async {
    Uri url = Uri.parse('https://motof.pythonanywhere.com/remove/$index');
    final response = await http.get(url);
  }