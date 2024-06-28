class Voto {
  final int? id;
  final String evento;
  final String nombre;
  final String descripcion;
  final String organizacion;
  final String encargado;
  final int firmas;

  Voto({
    this.id,
    required this.evento,
    required this.nombre,
    required this.descripcion,
    required this.organizacion,
    required this.encargado,
    required this.firmas,
  });

  factory Voto.fromJson(Map<String, dynamic> json) {
    return Voto(
      id: json['id'],
      evento: json['evento'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      organizacion: json['organizacion'],
      encargado: json['encargado'],
      firmas: json['firmas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'evento': evento,
      'nombre': nombre,
      'descripcion': descripcion,
      'organizacion': organizacion,
      'encargado': encargado,
      'firmas': firmas,
    };
  }
}
