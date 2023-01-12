main() {
  // List list = [
  //   Offset(12.3, 357.0),
  //   Offset(192.3, 396.3),
  //   Offset(26.0, 529.3),
  //   Offset(196.7, 555.0),
  //   Offset(192.0, 469.3)
  // ];

  List list = [Offset(11.7, 533.7), Offset(345.3, 644.7), Offset(157.3, 777.3), Offset(335.3, 794.3), Offset(347.7, 734.3)];
  for (var it in list) {
    print('${it.dx / list[4].dx}        ${it.dy / list[4].dy}');
  }
}

class Offset {
  double dx;
  double dy;

  Offset(this.dx, this.dy);
}
