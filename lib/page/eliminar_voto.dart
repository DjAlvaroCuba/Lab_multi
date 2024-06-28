import 'package:flutter/material.dart';
import 'package:lab_final/data/api_service.dart';
import 'package:lab_final/model/evento.dart';

class VotoDetailPage extends StatelessWidget {
  final ApiService apiService;
  final Voto voto;

  VotoDetailPage({required this.apiService, required this.voto});

  Future<void> _deleteVoto(BuildContext context) async {
    try {
      await apiService.deleteVoto(voto.id!);
      Navigator.pop(context, true); 
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error deleting voto')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voto Detalles'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteVoto(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Evento: ${voto.evento}', style: TextStyle(fontSize: 20)),
            Text('Nombre: ${voto.nombre}', style: TextStyle(fontSize: 20)),
            Text('Descripción: ${voto.descripcion}', style: TextStyle(fontSize: 20)),
            Text('Organización: ${voto.organizacion}', style: TextStyle(fontSize: 20)),
            Text('Encargado: ${voto.encargado}', style: TextStyle(fontSize: 20)),
            Text('Firmas: ${voto.firmas}', style: TextStyle(fontSize: 20)),
            
          ],
        ),
      ),
    );
  }
}
