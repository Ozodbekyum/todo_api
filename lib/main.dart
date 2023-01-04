import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todo_api/services/todoAPI.dart';
import 'package:todo_api/models/todo.dart';

void main() {
  runApp(
    const MaterialApp(
      home: TodoAPP(),
    ),
  );
}

class TodoAPP extends StatefulWidget {
  const TodoAPP({Key? key}) : super(key: key);

  @override
  State<TodoAPP> createState() => _TodoAPPState();
}

class _TodoAPPState extends State<TodoAPP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
        ),
        body: Center(
          child: FutureBuilder(
            future: getTodo(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          deleteTask(snapshot.data![index].id);
                        });
                      },
                      title: Text(snapshot.data![index].title),
                      subtitle: Text(snapshot.data![index].description),
                      trailing:
                          Text(snapshot.data![index].completed.toString()),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              addTask(Todo(
                title: 'Test',
                description: 'Test',
                completed: false,
                id: 1,
              ));
            });
          },
          child: const Icon(Icons.add),
        ));
  }
}
