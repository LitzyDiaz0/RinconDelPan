import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../models/usuario.dart';
import '../database/db_helper.dart';
import './adminusers.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  bool _passwordVisible = false;
  String _turnoSeleccionado = "M";
  String _rolSeleccionado = "empleado";

  // Controladores para los campos de texto
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  // Método para registrar el usuario
  void _registrarUsuario() async {
    String nombre = _nombreController.text;
    String telefono = _telefonoController.text;
    String usuario = _usuarioController.text;
    String contrasena = _contrasenaController.text;
    String turno = _turnoSeleccionado;
    String rol = _rolSeleccionado;

    // Asegúrate de validar los campos antes de insertar
    if (nombre.isNotEmpty &&
        telefono.isNotEmpty &&
        usuario.isNotEmpty &&
        contrasena.isNotEmpty) {
      // Crear el objeto Usuario
      Usuario nuevoUsuario = Usuario(
        nombre: nombre,
        telefono: telefono,
        usuario: usuario,
        contrasena: contrasena,
        turno: turno,
        rol: rol,
      );

      // Insertar el usuario en la base de datos
      DatabaseHelper dbHelper = DatabaseHelper();
      await dbHelper.insertarUsuario(nuevoUsuario);
      var logger = Logger();

      // Usar el logger para imprimir la información
      logger.i(
          'Usuario registrado: ${nuevoUsuario.nombre}, ${nuevoUsuario.telefono}, ${nuevoUsuario.usuario},  ${nuevoUsuario.rol}');

      // Mostrar un mensaje de éxito o redirigir al usuario, por ejemplo
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario registrado con éxito')),
      );

      // Si deseas limpiar los campos después del registro
      _nombreController.clear();
      _telefonoController.clear();
      _usuarioController.clear();
      _contrasenaController.clear();
    } else {
      // Mostrar un mensaje de error si algún campo está vacío
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              // Cabecera amarilla
              Container(
                height: 120,
                color: const Color.fromARGB(159, 251, 193, 45),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      iconSize: 30,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AdministrarUsuariosPage(), // Asegúrate de que LoginPage esté importado
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Formulario
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color.fromARGB(123, 0, 0, 0),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 74, 74, 74)
                                .withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Registro',
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'Aleo',
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 109, 49, 12),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Campo Nombre
                          TextField(
                            controller: _nombreController,
                            decoration: InputDecoration(
                              labelText: 'Nombre',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          // Campo Teléfono
                          TextField(
                            controller: _telefonoController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Teléfono',
                              prefixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          // Campo Usuario
                          TextField(
                            controller: _usuarioController,
                            decoration: InputDecoration(
                              labelText: 'Usuario',
                              prefixIcon: const Icon(Icons.account_circle),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          // Campo Contraseña
                          TextField(
                            controller: _contrasenaController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          // Lista Turno
                          DropdownButtonFormField<String>(
                            value: _turnoSeleccionado,
                            items: const [
                              DropdownMenuItem(
                                value: "M",
                                child: Text("Matutino"),
                              ),
                              DropdownMenuItem(
                                value: "V",
                                child: Text("Vespertino"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _turnoSeleccionado = value!;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Turno',
                              prefixIcon: const Icon(Icons.access_time),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),
                          // Lista Rol
                          DropdownButtonFormField<String>(
                            value: _rolSeleccionado,
                            items: const [
                              DropdownMenuItem(
                                value: "admin",
                                child: Text("Admin"),
                              ),
                              DropdownMenuItem(
                                value: "empleado",
                                child: Text("Empleado"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _rolSeleccionado = value!;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Rol',
                              prefixIcon: const Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          const SizedBox(height: 35),
                          // Botón Registrar
                          ElevatedButton(
                            onPressed: _registrarUsuario,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              side: const BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 70),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Registrar',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
