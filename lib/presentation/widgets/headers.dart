import 'package:flutter/material.dart';
import 'package:pets_app/config/config.dart';

class HeaderCuadrado extends StatelessWidget {
  
  const HeaderCuadrado({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.7,
      // height: 600,
      width: 600,
      color: AppTheme.primary,
    );

  }

}

class HeaderBordesRedondeados extends StatelessWidget {
  
  const HeaderBordesRedondeados({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: Color(0xFF615AAB),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(70), 
          bottomRight: Radius.circular(70)
        )
      ),
    );
  }

}

class HeaderDiagonal extends StatelessWidget {
  
  const HeaderDiagonal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      // color: const Color(0xFF615AAB),
      child: CustomPaint(
        painter: _HeaderDiagonalPainter(),
    
      ),
    );
  }

}

class _HeaderDiagonalPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final lapiz = Paint();

    // Propiedades
    lapiz.color = const Color(0xFF615AAB);
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 5;

    final path = Path();

    // Dibujar con el path y el lapiz
    path.moveTo( 0, size.height * 0.35 );
    path.lineTo( size.width, size.height * 0.30 );
    path.lineTo( size.width, 0 );
    path.lineTo( 0, 0 );

    canvas.drawPath(path, lapiz);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}




class HeaderTriangulo extends StatelessWidget {
  
  const HeaderTriangulo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      // color: const Color(0xFF615AAB),
      child: CustomPaint(
        painter: _HeaderTriangularPainter(),
    
      ),
    );
  }

}

class _HeaderTriangularPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final lapiz = Paint();

    // Propiedades
    lapiz.color = const Color(0xFF615AAB);
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 5;

    final path = Path();

    // Dibujar con el path y el lapiz
    path.lineTo( size.width, size.height );
    path.lineTo( size.width, 0 );
    path.lineTo( 0, 0 );

    canvas.drawPath(path, lapiz);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}


class HeaderPico extends StatelessWidget {
  
  const HeaderPico({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      // color: const Color(0xFF615AAB),
      child: CustomPaint(
        painter: _HeaderPicoPainter(),
    
      ),
    );
  }

}

class _HeaderPicoPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final lapiz = Paint();

    // Propiedades
    // lapiz.color = const Color(0xFF615AAB);
    lapiz.color = AppTheme.primary;
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 20;

    final path = Path();

    // Dibujar con el path y el lapiz
    path.moveTo( 0, size.height );
    path.lineTo( 0, size.height * 0.25 );
    path.lineTo( size.width * 0.50, size.height * 0.35 );
    path.lineTo( size.width, size.height * 0.25 );
    path.lineTo( 0, size.height );

    canvas.drawPath(path, lapiz);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}


class HeaderCurvo extends StatelessWidget {
  
  const HeaderCurvo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      // color: const Color(0xFF615AAB),
      child: CustomPaint(
        painter: _HeaderCurvoPainter(),
    
      ),
    );
  }

}

class _HeaderCurvoPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final lapiz = Paint();

    // Propiedades
    lapiz.color = const Color(0xFF615AAB);
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 20;

    final path = Path();

    // Dibujar con el path y el lapiz
    path.lineTo( 0, size.height * 0.25 );
    path.quadraticBezierTo( size.width * 0.5, size.height * 0.40, size.width, size.height * 0.25 );
    path.lineTo( size.width, 0 );
 

    canvas.drawPath(path, lapiz);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}


class HeaderWave extends StatelessWidget {
  
  const HeaderWave({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      // color: const Color(0xFF615AAB),
      child: CustomPaint(
        painter: _HeaderWavePainter(),
    
      ),
    );
  }

}

class _HeaderWavePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final lapiz = Paint();

    // Propiedades
    // lapiz.color = const Color(0xFF615AAB);
    lapiz.color = AppTheme.primary;
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 20;

    final path = Path();

    // Dibujar con el path y el lapiz
    path.lineTo( 0, size.height * 0.25 );
    path.quadraticBezierTo( size.width * 0.25, size.height * 0.30, size.width * 0.50, size.height * 0.25 );
    path.quadraticBezierTo( size.width * 0.75, size.height * 0.20, size.width, size.height * 0.25 );
    path.lineTo( size.width, 0 );
    canvas.drawPath(path, lapiz);

    final lapiz2 = Paint();

    lapiz2.color = const Color(0x8D086474);
    lapiz2.style = PaintingStyle.fill;
    lapiz2.strokeWidth = 20;

    final path2 = Path();

    // Dibujar con el path y el lapiz
    path2.lineTo( 0, size.height * 0.25 );
    path2.quadraticBezierTo( size.width * 0.30, size.height * 0.35, size.width * 0.50, size.height * 0.30 );
    path2.quadraticBezierTo( size.width * 0.70, size.height * 0.25, size.width, size.height * 0.25 );
    path2.lineTo( size.width, 0 );
    canvas.drawPath(path2, lapiz2);



  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}


class HeaderWaveBottom extends StatelessWidget {

  final Color color;
  
  const HeaderWaveBottom({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderWaveBottomPainter( color ),
      ),
    );
  }

}

class _HeaderWaveBottomPainter extends CustomPainter {

  final Color color;

  _HeaderWaveBottomPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {

    final lapiz = Paint();

    lapiz.color = color;
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 20;

    final path = Path();
    
    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo( size.width * 0.50, size.height * 0.50, size.width, size.height * 0.1 );
    path.lineTo( size.width, size.height );
    path.lineTo( 0, size.height );

    canvas.drawPath(path, lapiz);


    final lapiz2 = Paint();

    lapiz2.color = const Color(0x8D086474);
    lapiz2.style = PaintingStyle.fill;
    lapiz2.strokeWidth = 20;

    final path2 = Path();

    path2.moveTo(0, size.height * 0.25);
    path2.quadraticBezierTo( size.width * 0.50, size.height * 0.40, size.width, size.height * 0.05 );
    path2.lineTo( size.width, size.height );
    path2.lineTo( 0, size.height );
    
    canvas.drawPath(path2, lapiz2);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}


class HeaderWaveBottomGradient extends StatelessWidget {
  
  const HeaderWaveBottomGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      // color: const Color(0xFF615AAB),
      child: CustomPaint(
        painter: _HeaderWaveBottomGradientPainter(),
    
      ),
    );
  }

}

class _HeaderWaveBottomGradientPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    
    final Rect rect = Rect.fromCircle(
      // center: const Offset(0.0, 55.0),
      center: const Offset(0.0, 600),
      radius: 180
    );

    const Gradient gradiente = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xff6d05fa),
        Color(0xffc012ff),
        Color(0xff6d05e8),
      ],
      stops: [
        0.0,
        0.5,
        1.0
      ]
    );



    final lapiz = Paint()..shader = gradiente.createShader(rect);

    // Propiedades
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 20;

    final path = Path();

    // Dibujar con el path y el lapiz
    path.moveTo( 0, size.height );
    path.lineTo( 0, size.height * 0.75);
    path.quadraticBezierTo( size.width * 0.25, size.height * 0.70, size.width * 0.50, size.height * 0.75 );
    path.quadraticBezierTo( size.width * 0.75, size.height * 0.80, size.width, size.height * 0.75 );
    path.lineTo( size.width, size.height );
 

    canvas.drawPath(path, lapiz);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

























class BackgroundWaves extends StatelessWidget {
  
  const BackgroundWaves({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _BackgroundWavesPainter(),
      ),
    );
  }

}

class _BackgroundWavesPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    
    final lapiz = Paint();
    final lapiz2 = Paint();

    // Propiedades
    // lapiz.color = const Color(0xFF615AAB);
    lapiz.color = AppTheme.primary;
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 20;

    lapiz2.color = const Color.fromARGB(141, 8, 100, 116);
    lapiz2.style = PaintingStyle.fill;
    lapiz2.strokeWidth = 20;

    final path = Path();

    path.moveTo( size.width, size.height * 0.12 );
    path.cubicTo( 0, size.height * 0.30,    size.width * 0.35, size.height * 0.30,     0, size.height * 0.40 );
    path.lineTo( 0, 0 );
    path.lineTo( size.width, 0);

    final path2 = Path();
    path2.moveTo( size.width, size.height * 0.14 );
    path2.cubicTo( size.width * 0.20, size.height * 0.40,    size.width * 0.17, size.height * 0.12,     0, size.height * 0.45 );
    path2.lineTo( 0, 0 );
    path2.lineTo( size.width, 0);


    canvas.drawPath(path, lapiz);
    canvas.drawPath(path2, lapiz2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}



class BackgroundWavesLeft extends StatelessWidget {
  
  const BackgroundWavesLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _BackgroundWavesLeftPainter(),
      ),
    );
  }

}

class _BackgroundWavesLeftPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    
    final lapiz = Paint();
    final lapiz2 = Paint();

    lapiz.color = AppTheme.primary;
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 20;

    lapiz2.color = const Color(0x8D086474);
    lapiz2.style = PaintingStyle.fill;
    lapiz2.strokeWidth = 20;

    final path = Path();
    // final path2 = Path();


    // path.moveTo( 0, size.height * 0.4 );
    // path.quadraticBezierTo( size.width * 0.30, size.height * 0.85, 0, size.height );
    // path.lineTo( 0, size.height);

    // path2.moveTo( 0, size.height * 0.4 );
    // path2.quadraticBezierTo( size.width * 0.40, size.height * 0.8, 0, size.height );
    // path2.lineTo( 0, size.height);


    // esquina superior derecha
    path.moveTo( size.width * 0.80, 0 );
    path.quadraticBezierTo( size.width * 0.75, size.height * 0.15, size.width, size.height * 0.13 );
    path.lineTo( size.width, 0 );

    canvas.drawPath(path, lapiz);
    // canvas.drawPath(path2, lapiz2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}