import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab_final/model/evento.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  
  Future<List<Voto>> getVotos() async {
    final response = await http.get(Uri.parse('$baseUrl/api/votos/'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Voto> votos = body.map((dynamic item) => Voto.fromJson(item)).toList();
      return votos;
    } else {
      throw Exception('Failed to load votos');
    }
  }

  
  Future<Voto> createVoto(Voto voto) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/votos/'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(voto.toJson()),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        return Voto.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create voto: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to create voto: $e');
    }
  }

 
  Future<Voto> updateVoto(int id, Voto voto) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/votos/$id/'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(voto.toJson()),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return Voto.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update voto: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to update voto: $e');
    }
  }


  Future<void> deleteVoto(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/votos/$id/'),
        headers: {"Content-Type": "application/json"},
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode != 204) {
        throw Exception('Failed to delete voto: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to delete voto: $e');
    }
  }
}
