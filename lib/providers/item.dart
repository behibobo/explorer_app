import 'dart:developer';
import 'package:explorer/models/found_treasure.dart';
import 'package:explorer/models/loplob.dart';
import 'package:explorer/models/loplobs.dart';
import 'package:explorer/models/treasure.dart';
import 'package:explorer/models/user_loplob.dart';
import 'package:flutter/material.dart';
import 'package:explorer/providers/auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:explorer/models/item.dart';


class ItemProvider {
  
 static Future<List<Item>> getItems(int offset, int limit) async {
    final url = 'http://194.5.205.107:3000/app/items?offset=$offset&limit=$limit';
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

  static Future<List<Item>> getGiftItems(int offset, int limit) async {
    final url = 'http://194.5.205.107:3000/app/gift_items?offset=$offset&limit=$limit';
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


Future<List<Treasure>> getTreasures() async {
    final url = 'http://194.5.205.107:3000/app/treasures';
    String token = await getToken();
    List<Treasure> items;
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
          .map((data) => new Treasure.fromJson(data))
          .toList();
      return items;
    }
    return items;
  }






  static Future<List<FoundTrasure>> getFoundTreasures(int offset, int limit) async {
    final url = 'http://194.5.205.107:3000/app/found_treasures?offset=$offset&limit=$limit';
    String token = await getToken();
    List<FoundTrasure> items;
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
          .map((data) => new FoundTrasure.fromJson(data))
          .toList();
      return items;
    }
    return items;
  }

  static Future<List<UserLoplob>> getUserLoplobs(int offset, int limit) async {
    final url = 'http://194.5.205.107:3000/app/purchased_loplobs?offset=$offset&limit=$limit';
    String token = await getToken();
    List<UserLoplob> items;
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
          .map((data) => new UserLoplob.fromJson(data))
          .toList();
      return items;
    }
    return items;
  }


  Future<List<Loplobs>> getAllLoplobs() async {
    final url = 'http://194.5.205.107:3000/app/loplobs';
    String token = await getToken();
    List<Loplobs> items;
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
          .map((data) => new Loplobs.fromJson(data))
          .toList();
      return items;
    }
    return items;
  }


  Future<List<Loplob>> getLoplob(int id) async {
    final url = 'http://194.5.205.107:3000/app/loplobs/$id';
    String token = await getToken();
    List<Loplob> items;
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
          .map((data) => new Loplob.fromJson(data))
          .toList();
      return items;
    }
    return items;
  }

  Future<Map> purchaseloplob(String uuid, int requiredCredit) async {
    final url = 'http://194.5.205.107:3000/app/loplobs';
    String token = await getToken();

    Map body = {
      "uuid": uuid,
      "required_credit": requiredCredit,
    };

    final jsonBody = json.encode(body);

    Map<String, dynamic> result = {
      "success": false,
      "message": 'Unknown error.',
      "value": 0
    };

    final response = await http.post( url, 
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },body: jsonBody,);
    
    
    final responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
        result["value"] = responseJson["value"];
        result["success"] = responseJson["success"];
        result["message"] = responseJson["message"];

    }
    return result;
  }

  storeUserData(apiResponse) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('token', apiResponse['access_token']);
    await storage.setString('name', apiResponse['user']['full_name']);
  }

  static Future<String> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String token = storage.getString('token');
    return token;
  }


}