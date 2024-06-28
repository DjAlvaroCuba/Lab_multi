import 'package:flutter/material.dart';
import 'package:lab_final/data/api_service.dart';
import 'package:lab_final/model/evento.dart';
import 'package:lab_final/page/EditVotoPage.dart';
import 'package:lab_final/page/agregar_evento.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ApiService apiService =
      ApiService(baseUrl: 'http://192.168.1.53:8000/');
  List<Voto> votos = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchVotos();
  }

  Future<void> fetchVotos() async {
    setState(() {
      isLoading = true;
    });
    try {
      votos = await apiService.getVotos();
    } catch (e) {
      
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _navigateToAddVotoPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddVotoPage(apiService: apiService),
      ),
    );

    if (result == true) {
      fetchVotos();
    }
  }

  Future<void> _navigateToEditVotoPage(Voto voto) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditVotoPage(apiService: apiService, voto: voto),
      ),
    );

    if (result == true) {
      fetchVotos();
    }
  }

  Future<void> _deleteVoto(int id) async {
    try {
      await apiService.deleteVoto(id);
      fetchVotos();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error deleting voto')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Votos'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: votos.length,
              itemBuilder: (context, index) {
                final voto = votos[index];
                return Dismissible(
                  key: Key(voto.id.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmación'),
                          content: Text('¿Estás seguro de eliminar ${voto.nombre}?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('Eliminar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    _deleteVoto(voto.id!);
                  },
                  child: Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      title: Text(
                        voto.nombre,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(voto.descripcion),
                      onTap: () => _navigateToEditVotoPage(voto),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddVotoPage,
        child: Icon(Icons.add),
      ),
    );
  }
}
