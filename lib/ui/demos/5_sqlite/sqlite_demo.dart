import 'package:flutter/material.dart';
import 'package:flutter_demo/services/service_locator.dart';
import 'package:flutter_demo/ui/demos/5_sqlite/databse.dart';

class SqliteDemo extends StatefulWidget {


  @override
  State<SqliteDemo> createState() => _SqliteDemoState();
}

class _SqliteDemoState extends State<SqliteDemo> {
  final db = getIt<DatabaseHelper>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("2. Sqlite Demo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ElevatedButton(onPressed: (){
                final row = {
                  DatabaseHelper.columnName: 'John', 
                  DatabaseHelper.columnAge: 23,
                };
                db.insert(row);
              }, child: Text("Insert")),
          
                 SizedBox(height: 16),

              ElevatedButton(
              onPressed: () async {
                final rows = await db.queryAllRows();
                print(rows);
              }, child: Text("Query")),
                 
                 SizedBox(height: 16),

              ElevatedButton(onPressed: (){
                final row = {
                  DatabaseHelper.columnId: 1, 
                  DatabaseHelper.columnName: 'Johnathan', 
                  DatabaseHelper.columnAge: 23,
                };
                db.update(row);
              }, child: Text("Update")),

                 SizedBox(height: 16),

              ElevatedButton(onPressed: (){
                db.delete(1);
              }, child: Text("Delete")),


            ],
          ),
        ),
      ),
    );
  }
}