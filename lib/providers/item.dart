import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:explorer/providers/auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:explorer/models/item.dart';


class ItemProvider {
  
  Future<List<Item>> getItems() async {
    final url = 'http://194.5.205.107:3000/app/items';
    String token = await getToken();
    List<Item> items;
    final response = await http.get( url, 
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    
    if(response.statusCode == 401)
    {
        AuthProvider auth = new AuthProvider();
        auth.logOut();
    }
    
    final responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      items = (responseJson as List)
          .map((data) => new Item.fromJson(data))
          .toList();
      return items;
    }
    return items;
  }


  Future<Map> scanItem(String barcode) async {
    final url = 'http://194.5.205.107:3000/app/scan_item';
    String token = await getToken();
    
    Map<String, String> body = {
      'code': barcode
    };

    final response = await http.post( url, 
    headers: {
      'Authorization': 'Bearer $token',
    }, body: body,);

    

    if(response.statusCode == 401)
    {
        AuthProvider auth = new AuthProvider();
        auth.logOut();
    }
    
    Map<String, dynamic> result = {
      "success": false,
      "message": 'Unknown error.',
      "item": Item
    };

    if(response.statusCode == 200)
    {
        final responseJson = json.decode(response.body);
        result["item"] = Item.fromJson(responseJson["item"]);
        result["success"] = responseJson["success"];
        result["message"] = responseJson["message"];
    }

      return result;
    }
  

  Future<List<Item>> getLastItems() async {
    final url = 'http://194.5.205.107:3000/app/last_items';
    String token = await getToken();
    List<Item> items;
    final response = await http.get( url, 
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if(response.statusCode == 401)
    {
        AuthProvider auth = new AuthProvider();
        auth.logOut();
    }

    final responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      items = (responseJson as List)
          .map((data) => new Item.fromJson(data))
          .toList();
      return items;
    }
    return items;
  }

  storeUserData(apiResponse) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('token', apiResponse['access_token']);
    await storage.setString('name', apiResponse['user']['full_name']);
  }

  Future<String> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String token = storage.getString('token');
    return token;
  }


}