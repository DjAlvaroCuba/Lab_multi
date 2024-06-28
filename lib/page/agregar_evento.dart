import 'package:flutter/material.dart';
import 'package:lab_final/data/api_service.dart';
import 'package:lab_final/model/evento.dart';

class AddVotoPage extends StatefulWidget {
  final ApiService apiService;

  AddVotoPage({required this.apiService});

  @override
  _AddVotoPageState createState() => _AddVotoPageState();
}

class _AddVotoPageState extends State<AddVotoPage> {
  final _formKey = GlobalKey<FormState>();
  final _eventoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _organizacionController = TextEditingController();
  final _encargadoController = TextEditingController();
  final _firmasController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final evento = _eventoController.text;
      final nombre = _nombreController.text;
      final descripcion = _descripcionController.text;
      final organizacion = _organizacionController.text;
      final encargado = _encargadoController.text;
      final firmas = int.tryParse(_firmasController.text);

      if (firmas != null) {
        final newVoto = Voto(
          evento: evento,
          nombre: nombre,
          descripcion: descripcion,
          organizacion: organizacion,
          encargado: encargado,
          firmas: firmas,
        );

        try {
          await widget.apiService.createVoto(newVoto);
          Navigator.pop(context, true); 
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al crear el voto. Por favor, intenta nuevamente.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _eventoController.dispose();
    _nombreController.dispose();
    _descripcionController.dispose();
    _organizacionController.dispose();
    _encargadoController.dispose();
    _firmasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Voto'),
        backgroundColor: Colors.blue, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _eventoController,
                decoration: InputDecoration(
                  labelText: 'Evento',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre de evento';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _organizacionController,
                decoration: InputDecoration(
                  labelText: 'Organización',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una organización';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _encargadoController,
                decoration: InputDecoration(
                  labelText: 'Encargado',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un encargado';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _firmasController,
                decoration: InputDecoration(
                  labelText: 'Firmas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el número de firmas';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingresa un número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Agregar'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
