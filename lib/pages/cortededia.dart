import 'package:flutter/material.dart';

class CorteDelDiaPage extends StatelessWidget {
  const CorteDelDiaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 107, 59, 4),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading:
            false, // Evita que el título de la appBar se coloque
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen debajo de la barra naranja
            Center(
              child: Image.asset(
                'assets/img/logo.png', // Asegúrate de que esta ruta sea correcta
                width: 170,
                height: 170,
              ),
            ),
            SizedBox(height: 26),

            // Título Corte del Día
            Center(
              child: Text(
                "Corte del día",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Aleo',
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 118, 74, 8),
                ),
              ),
            ),
            SizedBox(height: 32),

            // Fila con solo la Fecha
            Padding(
              padding: const EdgeInsets.only(bottom: 36.0),
              child: Text(
                "Fecha: ${DateTime.now().toLocal().toString().split(' ')[0]}",
                style: TextStyle(fontSize: 18, fontFamily: 'Aleo'),
              ),
            ),

            // Fila con Cantidad de Panes Vendidos y su valor
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: const Color.fromARGB(
                        255, 255, 255, 255), // Fondo blanco
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Numero de panes vendidos: ",
                    style: TextStyle(fontSize: 18, fontFamily: 'Aleo'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "3", // Valor de cantidad de panes vendidos
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Aleo',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
                height:
                    36), // Espacio entre "Cantidad de panes vendidos" y "Dinero obtenido"

            // Fila con Dinero Obtenido y su valor
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: const Color.fromARGB(
                        255, 255, 255, 255), // Fondo blanco
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Dinero obtenido: ",
                    style: TextStyle(fontSize: 18, fontFamily: 'Aleo'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color:
                        const Color.fromARGB(255, 198, 255, 200), // Fondo verde
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "\$600.00", // Valor de dinero obtenido
                    style: TextStyle(
                      fontSize: 18, fontFamily: 'Aleo',
                      color: const Color.fromARGB(
                          255, 0, 0, 0), // Texto blanco para contraste
                      fontWeight: FontWeight.bold,
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