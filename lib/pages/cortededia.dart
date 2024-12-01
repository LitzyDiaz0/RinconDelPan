import 'package:flutter/material.dart';

class CorteDelDiaPage extends StatelessWidget {
  final String cantidadPanesVendidos =
      "100"; // Ejemplo de cantidad de panes vendidos
  final String dineroObtenido = "\$500.00";
  const CorteDelDiaPage({super.key}); // Ejemplo de dinero obtenido

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
            // Fecha y cantidad de panes vendidos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Fecha: ${DateTime.now().toLocal().toString().split(' ')[0]}",
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Text(
                      "Cantidad de panes vendidos: ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        cantidadPanesVendidos,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            // Dinero obtenido
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dinero obtenido: ",
                  style: TextStyle(fontSize: 16),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.green, // Fondo verde
                  ),
                  child: Text(
                    dineroObtenido,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors
                          .white, // Color del texto blanco para contrastar con el verde
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
