class Venta {
  int? idVenta; // Llave primaria
  int idProducto; // Llave foránea de la tabla productos
  double precio;
  int cantidad;
  double total;

  Venta({
    this.idVenta,
    required this.idProducto,
    required this.precio,
    required this.cantidad,
    required this.total,
  });

  // Convertir la Venta a un Map para almacenarlo en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id_venta': idVenta,
      'id_producto': idProducto,
      'precio': precio,
      'cantidad': cantidad,
      'total': total,
    };
  }

  // Crear una Venta desde un Map
  factory Venta.fromMap(Map<String, dynamic> map) {
    return Venta(
      idVenta: map['id_venta'],
      idProducto: map['id_producto'],
      precio: map['precio'],
      cantidad: map['cantidad'],
      total: map['total'],
    );
  }
}
