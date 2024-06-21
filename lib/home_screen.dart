import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formateo de fechas
import 'package:lab14_cuba/db_helper.dart'; // Ajusta el nombre de tu paquete

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _allTeams = [];
  bool _isLoading = true;

  void _refreshData() async {
    final teams = await SQLHelper.getAllTeams();
    setState(() {
      _allTeams = teams;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _addTeam(String teamName) async {
    await SQLHelper.createTeam(teamName);
    _refreshData();
  }

  Future<void> _updateTeam(int id, String teamName) async {
    await SQLHelper.updateTeam(id, teamName);
    _refreshData();
  }

  void _deleteTeam(int id) async {
    await SQLHelper.deleteTeam(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text("Equipo borrado"),
    ));
    _refreshData();
  }

  void _setLastMatchDate(int id) async {
    final DateTime now = DateTime.now();
    await SQLHelper.updateLastMatchDate(id, now);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Last match date updated to ${DateFormat('yyyy-MM-dd HH:mm:ss').format(now)}'),
    ));
    _refreshData();
  }

  final TextEditingController _teamNameController = TextEditingController();

  void showBottomSheet(int? id) async {
    String initialTeamName = '';
    if (id != null) {
      final existingTeam = _allTeams.firstWhere((element) => element['id'] == id);
      initialTeamName = existingTeam['team_name'];
    }

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _teamNameController..text = initialTeamName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "EQUIPO DE FUTBOL",
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final teamName = _teamNameController.text.trim();
                  if (teamName.isNotEmpty) {
                    if (id == null) {
                      await _addTeam(teamName);
                    } else {
                      await _updateTeam(id, teamName);
                    }
                    _teamNameController.text = "";
                    Navigator.of(context).pop();
                    print("EQUIPO AGREGADO");
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(id == null ? "AGREGAR EQUIPO" : "ACTUALIZAR"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEAF4),
      appBar: AppBar(
        title: Text("LAB14_cuba_"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _allTeams.length,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.all(15),
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      _allTeams[index]['team_name'],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fecha de creacion: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(_allTeams[index]['created_at']))}'),
                      if (_allTeams[index]['last_match_date'] != null)
                        Text('Ultimo partido: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(_allTeams[index]['last_match_date']))}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => showBottomSheet(_allTeams[index]['id']),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTeam(_allTeams[index]['id']),
                      ),
                      IconButton(
                        icon: Icon(Icons.event),
                        onPressed: () => _setLastMatchDate(_allTeams[index]['id']),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
