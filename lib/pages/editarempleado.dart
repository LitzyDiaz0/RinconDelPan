import 'package:flutter/material.dart';
import './adminusers.dart';
import '../database/db_helper.dart';
import '../models/usuario.dart';

class EditarEmpleadoPage extends StatelessWidget {
  final Usuario usuario; // Recibe el usuario a editar
  final String contrasena; 

  const EditarEmpleadoPage({super.key, required this.usuario, required this.contrasena}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            iconSize: 30,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const AdministrarUsuariosPage(),
                ),
              );
            },
          ),
          title: const Text(
            'Editar Empleado',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Aleo',
              color: Color.fromARGB(255, 133, 64, 8),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: ClipOval(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/img/empleados.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  // Campo de texto para "Nombre"
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Nombre:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Aleo',
                        )),
                  ),
                  TextField(
                    controller: TextEditingController(text: usuario.nombre),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo de texto para "Teléfono"
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Teléfono:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Aleo')),
                  ),
                  TextField(
                    controller: TextEditingController(text: usuario.telefono),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),

                  // Campo de texto para "Turno"
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Turno:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Aleo')),
                  ),
                  TextField(
                    controller: TextEditingController(text: usuario.turno),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo de texto para "Usuario"
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Usuario:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Aleo')),
                  ),
                  TextField(
                    controller: TextEditingController(text: usuario.usuario),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            // Botón para guardar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Actualiza el usuario en la base de datos
                  Usuario updatedUsuario = Usuario(
                    idUsuario: usuario.idUsuario,
                    nombre: usuario.nombre, // Aquí debes obtener el valor actualizado
                    telefono: usuario.telefono,
                    usuario: usuario.usuario,
                    contrasena: usuario.contrasena, // Puede ser que este también
                    turno: usuario.turno,
                    rol: usuario.rol,
                  );

                  final dbHelper = DatabaseHelper();
                  await dbHelper.actualizarUsuario(updatedUsuario);

                  // Regresar a la página de administración de usuarios
                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdministrarUsuariosPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(237, 255, 225, 151),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
