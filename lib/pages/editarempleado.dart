import 'package:flutter/material.dart';
import 'package:logger/logger.dart'; // Importa Logger
import './adminusers.dart';
import '../database/db_helper.dart';
import '../models/usuario.dart';

class EditarEmpleadoPage extends StatefulWidget {
  final Usuario usuario; // Recibe el usuario a editar
  final String contrasena; // Recibe la contraseña actual

  const EditarEmpleadoPage(
      {super.key, required this.usuario, required this.contrasena});

  @override
  _EditarEmpleadoPageState createState() => _EditarEmpleadoPageState();
}

class _EditarEmpleadoPageState extends State<EditarEmpleadoPage> {
  // Opciones para el turno
  List<String> turnos = ['Matutino', 'Vespertino'];
  String? selectedTurno;
  late TextEditingController _nombreController;
  late TextEditingController _telefonoController;
  late TextEditingController _turnoController;
  late TextEditingController _usuarioController;
  late TextEditingController _contrasenaController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.usuario.nombre);
    _telefonoController = TextEditingController(text: widget.usuario.telefono);
    _turnoController = TextEditingController(text: widget.usuario.turno);
    _usuarioController = TextEditingController(text: widget.usuario.usuario);
    _contrasenaController =
        TextEditingController(text: widget.usuario.contrasena);
    selectedTurno = widget.usuario.turno == 'M' ? 'Matutino' : 'Vespertino';
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _telefonoController.dispose();
    _turnoController.dispose();
    _usuarioController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

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
                  builder: (context) => const AdministrarUsuariosPage(),
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
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Nombre: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Aleo',
                          ))),
                  TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Teléfono: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Aleo'))),
                  TextField(
                    controller: _telefonoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Turno: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Aleo'))),
                  DropdownButtonFormField<String>(
                    value: selectedTurno,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTurno = newValue;
                      });
                    },
                    items: turnos.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Usuario: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Aleo'))),
                  TextField(
                    controller: _usuarioController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                    ),
                    enabled: false, // Desactiva la edición
                  ),
                  const SizedBox(height: 20),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Contraseña: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Aleo'))),
                  TextField(
                    controller: _contrasenaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                    ),
                    enabled: false, // Desactiva la edición
                    obscureText: true, // Muestra los asteriscos
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Convierte el turno seleccionado a 'M' o 'V'
                  String turno = selectedTurno == 'Matutino' ? 'M' : 'V';

                  // Crea un usuario actualizado
                  // Aseguramos que la contraseña que no se edita se conserve sin cambios.
                  String contrasenaFinal = widget.contrasena.isNotEmpty
                      ? widget.contrasena
                      : widget.usuario.contrasena;

                  Usuario updatedUsuario = Usuario(
                    idUsuario: widget.usuario.idUsuario,
                    nombre: _nombreController.text,
                    telefono: _telefonoController.text,
                    usuario: widget
                        .usuario.usuario, // No permite modificar el usuario
                    contrasena:
                        contrasenaFinal, // Utilizamos la contraseña sin cambios
                    turno: turno, // Guarda 'M' o 'V'
                    rol: widget.usuario.rol,
                  );

                  // Configura el logger
                  var logger = Logger();
                  logger.i("Información que se enviará a la base de datos:");
                  logger.i("ID Usuario: ${updatedUsuario.idUsuario}");
                  logger.i("Nombre: ${updatedUsuario.nombre}");
                  logger.i("Teléfono: ${updatedUsuario.telefono}");
                  logger.i("Turno: ${updatedUsuario.turno}");
                  logger.i("Usuario: ${updatedUsuario.usuario}");
                  logger.i("Contraseña: ${updatedUsuario.contrasena}");
                  logger.i("Rol: ${updatedUsuario.rol}");

                  // Actualiza el usuario en la base de datos
                  final dbHelper = DatabaseHelper();
                  await dbHelper.actualizarUsuario(updatedUsuario);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Usuario actualizado exitosamente"),
                    backgroundColor: Colors.green,
                  ));

                  // Navega a la página de administración de usuarios
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
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
