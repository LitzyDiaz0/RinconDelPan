import 'package:flutter/material.dart';
import 'package:rincondelpan/pages/cortededia.dart';
import './puntoventa.dart';
import '../database/db_helper.dart';
import '../models/ventas.dart';

class Ventas extends StatelessWidget {
  const Ventas({super.key});

  Future<List<Venta>> _fetchVentas() async {
    final dbHelper = DatabaseHelper(); // Instancia de tu DBHelper
    final db = await dbHelper.database;
    return dbHelper.obtenerVentas(db);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 237, 199),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 99, 43, 9)),
          iconSize: 40,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const PuntoDeVentaPage(rol: '')),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              Center(
                child: Image.asset(
                  'assets/img/logo.png',
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.black, width: 1.5),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    onPressed: () {
                      // Acción para hacer corte
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CorteDelDiaPage(
                            panesVendidos: _totalCantidad,
                            dineroObtenido: _totalTotal,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.cut, color: Colors.black),
                        SizedBox(width: 8),
                        Text("Hacer corte",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Fecha: ${DateTime.now().toLocal().toString().split(' ')[0]}",
                    style: const TextStyle(fontSize: 15, fontFamily: 'Aleo'),
                  ),
                ],
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 16),
              FutureBuilder<List<Venta>>(
                future: _fetchVentas(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error al cargar datos'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No hay ventas registradas'));
                  }

                  final ventas = snapshot.data!;

                  double totalCantidad = 0;
                  double totalTotal = 0;

                  // Sumar las cantidades y los totales
                  for (var venta in ventas) {
                    totalCantidad += venta.cantidad;
                    totalTotal += venta.total;
                  }

                  // Guardar el totalCantidad y totalTotal
                  _totalCantidad = totalCantidad;
                  _totalTotal = totalTotal;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                      ),
                      child: DataTable(
                        headingRowColor: WidgetStateColor.resolveWith(
                            (states) =>
                                const Color.fromARGB(255, 240, 230, 140)),
                        columnSpacing: MediaQuery.of(context).size.width * 0.17,
                        // ignore: deprecated_member_use
                        dataRowHeight: 65,
                        columns: const [
                          DataColumn(
                            label: Center(
                              child: Text('# Venta',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Aleo')),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text('Cantidad',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Aleo')),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text('Total',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Aleo')),
                            ),
                          ),
                        ],
                        rows: ventas.map((venta) {
                          return DataRow(cells: [
                            DataCell(
                                Center(child: Text(venta.idVenta.toString()))),
                            DataCell(Center(
                                child:
                                    Text('${venta.cantidad.toString()} Pzas'))),
                            DataCell(Center(
                                child: Text(
                                    '\$${venta.total.toStringAsFixed(2)}'))),
                          ]);
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Variables para almacenar el total de cantidades y totales
  static double _totalCantidad = 0;
  static double _totalTotal = 0;
}
