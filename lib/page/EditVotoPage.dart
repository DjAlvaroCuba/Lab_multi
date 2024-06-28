import 'package:flutter/material.dart';
import 'package:lab_final/data/api_service.dart';
import 'package:lab_final/model/evento.dart';

class EditVotoPage extends StatefulWidget {
  final ApiService apiService;
  final Voto voto;

  EditVotoPage({required this.apiService, required this.voto});

  @override
  _EditVotoPageState createState() => _EditVotoPageState();
}

class _EditVotoPageState extends State<EditVotoPage> {
  final _formKey = GlobalKey<FormState>();
  final _eventoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _organizacionController = TextEditingController();
  final _encargadoController = TextEditingController();
  final _firmasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _eventoController.text = widget.voto.evento;
    _nombreController.text = widget.voto.nombre;
    _descripcionController.text = widget.voto.descripcion;
    _organizacionController.text = widget.voto.organizacion;
    _encargadoController.text = widget.voto.encargado;
    _firmasController.text = widget.voto.firmas.toString();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final evento = _eventoController.text;
      final nombre = _nombreController.text;
      final descripcion = _descripcionController.text;
      final organizacion = _organizacionController.text;
      final encargado = _encargadoController.text;
      final firmas = int.tryParse(_firmasController.text);

      final updatedVoto = Voto(
        id: widget.voto.id,
        evento: evento,
        nombre: nombre,
        descripcion: descripcion,
        organizacion: organizacion,
        encargado: encargado,
        firmas: firmas ?? 0,
      );

      try {
        await widget.apiService.updateVoto(widget.voto.id!, updatedVoto);
        Navigator.pop(context, true); 
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al actualizar el voto. Por favor, intenta nuevamente.'),
            backgroundColor: Colors.red, 
          ),
        );
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
        title: Text('Editar Voto'),
        backgroundColor: Colors.blue, // Personaliza el color de fondo del AppBar
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
                child: Text('Actualizar'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0), // Ajusta el espaciado interno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
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
