import 'package:flutter/material.dart';

class VentasDelDiaPage extends StatelessWidget {
  const VentasDelDiaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100), // Ajusta la altura de la AppBar
        child: AppBar(
          backgroundColor: Colors.orange,
          elevation: 0, // Sin sombra
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Volver a la pantalla anterior
                    },
                  ),
                  Spacer(),
                  Image.asset(
                    'assets/img/logo.png', // Reemplaza con la ruta de tu logo
                    width: 100,
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo y título
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo.png', // Logo de la empresa
                    width: 150,
                    height: 100,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "El Rincón del Pan",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),

            // Fila con el botón "Hacer Corte" y la fecha alineada a la derecha
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Acción del botón Hacer Corte
                  },
                  icon: Icon(Icons.cut, color: Colors.white),
                  label: Text("Hacer Corte"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                Text(
                  DateTime.now()
                      .toLocal()
                      .toString()
                      .split(' ')[0], // Muestra la fecha actual
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Tabla con las ventas del día
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  // Encabezado de la tabla
                  Row(
                    children: const [
                      Icon(Icons.shopping_cart, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        "Ventas del Día",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  // Fila de los campos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("IMG",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Nombre del Pan",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Cantidad",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Total",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(),
                  // Ejemplo de fila con datos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/pan_icon.png',
                          width: 30,
                          height: 30), // Reemplaza con la imagen del pan
                      Text("Pan de Chocolate"),
                      Text("10"),
                      Text("\$100.00"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
