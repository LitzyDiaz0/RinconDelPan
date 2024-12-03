class Venta {
  int? idVenta; // Llave primaria
  int idProducto; // Llave foránea de la tabla productos
  int cantidad;
  double total;

  Venta({
    this.idVenta,
    required this.idProducto,
    required this.cantidad,
    required this.total,
  });

  // Convertir la Venta a un Map para almacenarlo en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id_venta': idVenta,
      'id_producto': idProducto,
      'cantidad': cantidad,
      'total': total,
    };
  }

  // Crear una Venta desde un Map
  factory Venta.fromMap(Map<String, dynamic> map) {
    return Venta(
      idVenta: map['id_venta'],
      idProducto: map['id_producto'],
      cantidad: map['cantidad'],
      total: map['total'],
    );
  }
}
