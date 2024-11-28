import 'dart:convert';

class Usuario {
  int? idUsuario; // El id puede ser nulo si es autoincrementable
  String nombre;
  String telefono;
  String usuario;
  String contrasena;
  String turno; // Tipo char en la base de datos
  String rol;

  Usuario({
    this.idUsuario,
    required this.nombre,
    required this.telefono,
    required this.usuario,
    required this.contrasena,
    required this.turno,
    required this.rol,
  });

  // Convertir un objeto Usuario a un mapa para la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id_usuario': idUsuario,
      'nombre': nombre,
      'telefono': telefono,
      'usuario': usuario,
      'contrasena': contrasena,
      'turno': turno,
      'rol': rol,
    };
  }

  // Crear un objeto Usuario desde un mapa (registro de la base de datos)
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['id_usuario'],
      nombre: map['nombre'],
      telefono: map['telefono'],
      usuario: map['usuario'],
      contrasena: map['contrasena'],
      turno: map['turno'],
      rol: map['rol'],
    );
  }

  // Convertir un objeto Usuario a un objeto JSON (en caso de que lo necesites)
  String toJson() => json.encode(toMap());

  // Crear un objeto Usuario desde un JSON
  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source));
}
