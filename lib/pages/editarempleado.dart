import 'package:flutter/material.dart';
import './adminusers.dart';

class EditarEmpleadoPage extends StatelessWidget {
  const EditarEmpleadoPage({super.key});

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
                      const AdministrarUsuariosPage(), // Asegúrate de que LoginPage esté importado
                ),
              ); // Regresar a la página anterior
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
        // Esto permite que los elementos se desplacen
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Imagen centrada de "Empleado"
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
                    'assets/img/empleados.png', // Asegúrate de tener esta imagen en tu carpeta assets
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Campos de texto para editar el empleado
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  // Campo de texto para "Nombre"
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Nombre:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Aleo',
                        )),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8), // Reducido el tamaño
                    ),
                  ),
                  SizedBox(height: 20),

                  // Campo de texto para "Teléfono"
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Teléfono:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Aleo')),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8), // Reducido el tamaño
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20),

                  // Campo de texto para "Turno"
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Turno:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Aleo')),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8), // Reducido el tamaño
                    ),
                  ),
                  SizedBox(height: 20),

                  // Campo de texto para "Usuario"
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Usuario:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Aleo')),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8), // Reducido el tamaño
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50), // Agregado para espacio adicional
            // Botón para guardar (más largo)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Aquí va la lógica para guardar el empleado
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(237, 255, 225, 151),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 80), // Aumento el padding vertical
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
