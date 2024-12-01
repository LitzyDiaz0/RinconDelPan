import 'package:flutter/material.dart';
import 'package:rincondelpan/models/producto.dart';
import 'package:rincondelpan/pages/inventario.dart';
// Asegúrate de importar el helper de la base de datos

class EditarPanPage extends StatelessWidget {
  final Producto producto; //

  const EditarPanPage({super.key, required this.producto});

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const InventarioPage(), // Regresar a InventarioPage
                      ),
                    ); // Navegar hacia atrás
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  "Editar Pan",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Aleo',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Image.asset(
                  'assets/img/panico.png',
                  width: 100,
                  height: 50,
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
          // Campos de entrada con padding horizontal
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Nombre"),
                const SizedBox(height: 8),
                TextField(
                  controller: TextEditingController(text: producto.nombre),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ingrese el nombre del pan",
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Sabor"),
                const SizedBox(height: 8),
                TextField(
                  controller: TextEditingController(text: producto.sabor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ingrese el sabor del pan",
                  ),
                ),
                SizedBox(height: 16),
                Text("Precio"),
                SizedBox(height: 8),
                TextField(
                  controller:
                      TextEditingController(text: producto.precio.toString()),
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
                  controller:
                      TextEditingController(text: producto.stock.toString()),
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
