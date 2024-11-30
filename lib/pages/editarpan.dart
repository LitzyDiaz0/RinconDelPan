import 'package:flutter/material.dart';

class EditarPanPage extends StatelessWidget {
  const EditarPanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barra superior
          Container(
            height: 80,
            color: Colors.orange,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // Navegar hacia atrás
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  "Editar Pan",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Image.asset(
                  'assets/panico.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Contenedor para imagen seleccionable
          Center(
            child: GestureDetector(
              onTap: () {
                // Aquí se puede agregar la funcionalidad de seleccionar una nueva imagen
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Imagen del pan",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Campos de entrada
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nombre"),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ingrese el nombre del pan",
                  ),
                ),
                SizedBox(height: 16),
                Text("Sabor"),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ingrese el sabor del pan",
                  ),
                ),
                SizedBox(height: 16),
                Text("Precio"),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ingrese el precio del pan",
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                Text("Stock"),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ingrese el stock del pan",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          const Spacer(),
          // Botón "Guardar"
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Aquí se puede agregar la funcionalidad de guardar
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                side: const BorderSide(color: Colors.black, width: 2),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              child: const Text(
                "Guardar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
