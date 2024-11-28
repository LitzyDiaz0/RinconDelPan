import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../database/db_helper.dart';
import './registro.dart';
import './admnprinc.dart';
import './editarempleado.dart';

class AdministrarUsuariosPage extends StatelessWidget {
  const AdministrarUsuariosPage({super.key});

  // Método para obtener los usuarios desde la base de datos
  Future<List<Usuario>> _obtenerUsuarios() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    return await dbHelper.obtenerUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Barra de navegación
          Container(
            height: 80,
            color: const Color.fromARGB(255, 135, 71, 15),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    iconSize: 40,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminPage(rol: ''),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Imagen personalizada
          Padding(
            padding: const EdgeInsets.all(16.0),
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
          const Text(
            'Empleados',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(96, 60, 30, 1),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistroPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  icon: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    padding: const EdgeInsets.all(2.0),
                    child: const Icon(Icons.add, color: Colors.black),
                  ),
                  label: const Text(
                    'Agregar Empleado',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Aquí estaba el error, ahora te paso el usuario correctamente.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditarEmpleadoPage(usuario: Usuario(
                          nombre: "", 
                          telefono: "", 
                          rol: "", 
                          turno: "", 
                          usuario: "", contrasena: ''), contrasena: '',), // Usuario vacío como ejemplo
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  icon: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    padding: const EdgeInsets.all(2.0),
                    child: const Icon(Icons.edit, color: Colors.black),
                  ),
                  label: const Text(
                    'Editar empleado prueba',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Usuario>>(
              future: _obtenerUsuarios(), // Aquí se obtienen los usuarios
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No hay empleados registrados.'));
                } else {
                  List<Usuario> usuarios = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DataTable(
                            columnSpacing: 15,
                            // ignore: deprecated_member_use
                            dataRowHeight: 60,
                            columns: const [
                              DataColumn(label: Text('Nombre')),
                              DataColumn(label: Text('Teléfono')),
                              DataColumn(label: Text('Rol')),
                              DataColumn(label: Text('Turno')),
                              DataColumn(label: Text('Usuario')),
                              DataColumn(label: Text('Acciones')),
                            ],
                            rows: usuarios.map((usuario) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(usuario.nombre)),
                                  DataCell(Text(usuario.telefono)),
                                  DataCell(Text(usuario.rol)),
                                  DataCell(Text(usuario.turno)),
                                  DataCell(Text(usuario.usuario)),
                                  DataCell(Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.white),
                                          onPressed: () {
                                            // Pasar el usuario a la pantalla de edición
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditarEmpleadoPage(
                                                        usuario: usuario, contrasena: '',),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.pink,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.white),
                                          onPressed: () {
                                            // Lógica para eliminar el usuario
                                          },
                                        ),
                                      ),
                                    ],
                                  )),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
