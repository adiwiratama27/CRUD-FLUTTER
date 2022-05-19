import 'dart:convert';
import 'dart:math';

import 'package:flutter_crud_api_sample_app/models.dart';
import 'package:http/http.dart' as http;

class Repository{
  final _baseUrl = 'https://628373b592a6a5e462241ca1.mockapi.io/';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl+'/users'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Users> users = it.map((e) => Users.fromJson(e)).toList();
        return users;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(String nama, String email) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl+'/users'),
      body: {'nama': nama, 'email': email});
      if (response.statusCode == 201) {
        return true;
      }else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future putData(int id, String nama, String email) async {
    try {
      final response = await http.put(
        Uri.parse(_baseUrl + '/users'+ id.toString()),
        body: {'nama': nama, 'email': email});
      if (response.statusCode == 200) {
        return true;
      }else {
        return false;
      }
    }catch (e) {
      print(e.toString());
    }
  }

  Future deleteData(String id) async {
    try {
        final response = await http.delete(Uri.parse(_baseUrl+'/users'+id));
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
    } catch (e) {
      print(e.toString());
    }
  }
}