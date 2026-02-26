import 'package:flutter/material.dart';

class WidgetsLayoutDemo extends StatelessWidget {
  const WidgetsLayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Widget and Layout')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text('Hello'),
              Text('World'),
              Text("MIU"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.favorite_border),
              ),
              IconButton(
                onPressed: () {
                  print('Hello');
                },
                icon: Icon(Icons.waving_hand),
              ),
          
              
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  children: [
                        //SizedBox(width: 15),
                    Text('Row item 1'),
                        SizedBox(width: 15),
                    Text('Row item 1'),
                        SizedBox(width: 15),
                    Text('Row item 1'),
                  
                  ],
                ),
              ),
          
                  SizedBox(height: 16),
          
              ElevatedButton(onPressed: (){
                print('Elevated button was clicked');
              }, child: Text("Click me")),
          
                 SizedBox(height: 16),
          
              OutlinedButton(onPressed: (){
                print('Outline button was clicked');
              }, child: Text("Click me")),
          
                 SizedBox(height: 16),
          
              TextButton(onPressed: (){
                print('Text button was clicked');
              }, child: Text("Click me", style: TextStyle(color: Colors.redAccent),)),  
            ],
          ),
        ),
      ),
    );
  }
}