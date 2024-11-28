import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../database/db_helper.dart';
import './registro.dart';
import './admnprinc.dart';
import './editarempleado.dart';

class AdministrarUsuariosPage extends StatefulWidget {
  const AdministrarUsuariosPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdministrarUsuariosPageState createState() =>
      _AdministrarUsuariosPageState();
}

class _AdministrarUsuariosPageState extends State<AdministrarUsuariosPage> {
  late Future<List<Usuario>> _usuariosFuture;

  // Inicializa la lista de usuarios al cargar la pantalla
  @override
  void initState() {
    super.initState();
    _cargarUsuarios();
  }

  // Método para cargar los usuarios
  void _cargarUsuarios() {
    _usuariosFuture = DatabaseHelper().obtenerUsuarios();
  }

  // Método para actualizar la lista después de cambios
  void _actualizarUsuarios() {
    setState(() {
      _cargarUsuarios();
    });
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
              fontFamily: 'Aleo',
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
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Usuario>>(
              future: _usuariosFuture,
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
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditarEmpleadoPage(
                                                  usuario: usuario,
                                                  contrasena: '',
                                                ),
                                              ),
                                            ).then((_) {
                                              _actualizarUsuarios(); // Actualizar usuarios al volver
                                            });
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
                                          onPressed: () async {
                                            bool? confirmar =
                                                await showDialog<bool>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Confirmación'),
                                                  content: const Text(
                                                      '¿Estás seguro de que deseas eliminar este empleado?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(false),
                                                      child: const Text(
                                                          'Cancelar'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(true),
                                                      child: const Text(
                                                          'Eliminar'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                            if (confirmar == true) {
                                              final dbHelper = DatabaseHelper();
                                              await dbHelper.eliminarUsuario(
                                                  usuario.idUsuario!);

                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Empleado eliminado correctamente'),
                                                ),
                                              );
                                              _actualizarUsuarios();
                                            }
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
