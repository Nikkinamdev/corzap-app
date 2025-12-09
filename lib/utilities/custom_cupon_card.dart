import 'package:flutter/material.dart';

class NotchedCard extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;

  const NotchedCard({
    super.key,
    this.width = 300,
    this.height = 150,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Center(
      child: PhysicalShape(
        clipper: TicketClipper(),
        color: Colors.white,
        elevation: 6, // shadow intensity
        shadowColor: Colors.black.withOpacity(0.25),
        child: Container(
          width: w,
          height: height,
          child:
              child ??
              Center(
                child: Text(
                  "Ticket Style Card",
                  style: TextStyle(
                    fontSize: w * .03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
        ),
      ),
    );
  }
}

/// Clipper to create left & right half-circle notches
class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double notchRadius = 20;
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, (size.height / 2) - notchRadius);
    path.arcToPoint(
      Offset(size.width, (size.height / 2) + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, (size.height / 2) + notchRadius);
    path.arcToPoint(
      Offset(0, (size.height / 2) - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(TicketClipper oldClipper) => false;
}
// vertical dotted divider

class VerticalDottedDivider extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;

  const VerticalDottedDivider({
    super.key,
    this.height = 100.0,
    this.width = 1.0,
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.dashLength = 8.0,
    this.dashGap = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _DottedLinePainter(
          color: color,
          strokeWidth: strokeWidth,
          dashLength: dashLength,
          dashGap: dashGap,
          isVertical: true,
        ),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;
  final bool isVertical;

  _DottedLinePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashGap,
    this.isVertical = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double currentPosition = 0.0;
    final totalLength = isVertical ? size.height : size.width;
    final step = dashLength + dashGap;

    while (currentPosition < totalLength) {
      if (isVertical) {
        canvas.drawLine(
          Offset(size.width / 2, currentPosition),
          Offset(size.width / 2, currentPosition + dashLength),
          paint,
        );
      } else {
        canvas.drawLine(
          Offset(currentPosition, size.height / 2),
          Offset(currentPosition + dashLength, size.height / 2),
          paint,
        );
      }
      currentPosition += step;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Usage example:
// Row(
//   children: [
//     Container(width: 100, height: 200, color: Colors.blue),
//     VerticalDottedDivider(height: 200),
//     Container(width: 100, height: 200, color: Colors.green),
//   ],
// )
