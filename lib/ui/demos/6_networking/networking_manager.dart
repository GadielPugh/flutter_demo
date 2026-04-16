import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class NetworkingManager {
  
  final catNotifier = ValueNotifier('');

  

  Future<void> getRequest() async {
    try {
      final uri = Uri.parse('https://catfact.ninja/fact');
      final responde = await get(uri);
      final jsonString = responde.body;
      final map = jsonDecode(jsonString);

      catNotifier.value = 'One euro = ${map['eur']['mnt'].toInt()} tugruk';
    } on ClientException catch(e) {
      catNotifier.value = 'Your internet has a problem';
    }
  }

  Future<void> postRequest() async {}

}