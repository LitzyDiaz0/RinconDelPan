import 'package:flutter/material.dart';
import './cortededia.dart';
import './puntoventa.dart';

class Ventas extends StatelessWidget {
  const Ventas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 237, 199),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: const Color.fromARGB(255, 99, 43, 9)),
          iconSize: 40,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PuntoDeVentaPage(
                  rol: '',
                ),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "El Rincon del Pan",
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Italianno',
                  color: const Color.fromARGB(255, 110, 48, 3),
                ),
              ),
            ),
            // Imagen del logo
            Center(
              child: Image.asset(
                'assets/img/logo.png', // Asegúrate de que esta ruta sea correcta
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 16),

            // Botón Hacer Corte con borde negro y redondeado
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.black, width: 1.5),
                    backgroundColor: Colors.white, // Borde negro
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Bordes redondeados
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8), // Fondo blanco
                  ),
                  onPressed: () {
                    // Acción para hacer corte
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CorteDelDiaPage(),
                      ),
                    );
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.cut, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        "Hacer corte",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Fecha del día alineada a la derecha
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Fecha: ${DateTime.now().toLocal().toString().split(' ')[0]}",
                  style: TextStyle(fontSize: 15, fontFamily: 'Aleo'),
                ),
              ],
            ),
            SizedBox(height: 32),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.monetization_on,
                    size: 30,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Ventas del Día",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Aleo',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),
            // Tabla con los encabezados y datos
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 255, 255, 255), // Fondo para toda la tabla
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(
                      10), // Bordes redondeados si se desea
                ),
                child: DataTable(
                  columnSpacing: 15,
                  // ignore: deprecated_member_use
                  dataRowHeight: 65,
                  columns: [
                    DataColumn(
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Img',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontFamily: 'Aleo'),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Nombre del Pan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontFamily: 'Aleo'),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'pza',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontFamily: 'Aleo'),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'Total',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontFamily: 'Aleo'),
                        ),
                      ),
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Image.asset('assets/img/logo.png', width: 50)),
                      DataCell(Text('Pan de Chocolate')),
                      DataCell(Text('10')),
                      DataCell(Text('\$100')),
                    ]),
                    DataRow(cells: [
                      DataCell(Image.asset('assets/img/logo.png', width: 50)),
                      DataCell(Text('Pan de Vainilla')),
                      DataCell(Text('15')),
                      DataCell(Text('\$150')),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
