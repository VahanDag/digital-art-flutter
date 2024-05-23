
import 'package:flutter/material.dart';

class ContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double w = size.width;
    final double h = size.height;
    var path = Path();

    // Başlangıç noktası
    path.moveTo(0, 0);

    // Üst kenar
    path.lineTo(w, 0);

    // Sağ kenar
    path.lineTo(w, h - 50); // h-50, kıvrımın başlayacağı yükseklik

    // Alt kıvrımlı kısım
    var firstControlPoint = Offset(w * 0.75, h);
    var firstEndPoint = Offset(w / 2, h - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(w * 0.25, h - 100); // h-100, kıvrımın derinliği
    var secondEndPoint = Offset(0, h - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    // Sol kenar ve kapatma
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CornerFramePainter extends CustomPainter {
  final double strokeWidth;
  final double edgeLength;
  final Color? color;

  CornerFramePainter({this.strokeWidth = 3.0, this.edgeLength = 20.0,this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color  ??Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Sol üst köşe
    canvas.drawLine(Offset(0, edgeLength), const Offset(0, 0), paint);
    canvas.drawLine(const Offset(0, 0), Offset(edgeLength, 0), paint);

    // Sağ üst köşe
    canvas.drawLine(Offset(size.width - edgeLength, 0), Offset(size.width, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, edgeLength), paint);

    // Sol alt köşe
    canvas.drawLine(Offset(0, size.height - edgeLength), Offset(0, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(edgeLength, size.height), paint);

    // Sağ alt köşe
    canvas.drawLine(Offset(size.width - edgeLength, size.height), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height - edgeLength), Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



class ExtendedCornerPainter extends CustomPainter {
  final double strokeWidth;
  final double horizontalLineLength;
  final double verticalLineLength;

  ExtendedCornerPainter({
    this.strokeWidth = 3.0,
    this.horizontalLineLength = 50.0, // Yatay çizginin uzunluğunu belirler
    this.verticalLineLength = 20.0, // Dikey çizginin uzunluğunu belirler
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Sağ üst köşe - Yatay çizgi
    canvas.drawLine(
      Offset(size.width - horizontalLineLength, strokeWidth / 2),
      Offset(size.width, strokeWidth / 2),
      paint,
    );
    // Sağ üst köşe - Dikey çizgi
    canvas.drawLine(
      Offset(size.width - strokeWidth / 2, 0),
      Offset(size.width - strokeWidth / 2, verticalLineLength),
      paint,
    );

    // Sol alt köşe - Yatay çizgi
    canvas.drawLine(
      Offset(0, size.height - strokeWidth / 2),
      Offset(horizontalLineLength, size.height - strokeWidth / 2),
      paint,
    );
    // Sol alt köşe - Dikey çizgi
    canvas.drawLine(
      Offset(strokeWidth / 2, size.height - verticalLineLength),
      Offset(strokeWidth / 2, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
