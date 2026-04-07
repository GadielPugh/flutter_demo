import 'package:flutter/material.dart';

class SqliteDemo extends StatefulWidget {


  @override
  State<SqliteDemo> createState() => _SqliteDemoState();
}

class _SqliteDemoState extends State<SqliteDemo> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("2. Sqlite Demo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // Center aligns the scroll view in the middle of the screen
      body: Center(
        // SingleChildScrollView ensures the content scrolls if the screen is too small
        child: SingleChildScrollView(
          child: Column(
            // MainAxisSize.min ensures the column only takes up needed space
            // so the Center widget can do its job vertically
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ElevatedButton(onPressed: (){}, child: Text("Insert")),
          
                 SizedBox(height: 16),

              ElevatedButton(onPressed: (){}, child: Text("Query")),
                 
                 SizedBox(height: 16),

              ElevatedButton(onPressed: (){
                ;
              }, child: Text("Delete")),

                 SizedBox(height: 16),

              ElevatedButton(onPressed: (){
                ;
              }, child: Text("Insert")),


            ],
          ),
        ),
      ),
    );
  }
}