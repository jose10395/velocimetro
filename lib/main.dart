import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:ui';
import 'dart:math' as pi;

import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Page());
  }
}

class Page extends StatefulWidget {
  Page({Key? key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation animation;
  final velocidad = ValueNotifier<double>(0.0);
  final double limiteVelocimetro = 400;
  Timer? mytymer;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    animation =
        CurvedAnimation(curve: Curves.ease, parent: animationController);
    super.initState();
  }

  @override
  void dispose() {
    mytymer?.cancel();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            '10:28 PM',
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Image.asset(
            'assets/car_icon.png',
          ),
        ),
        leadingWidth: 55,
        actions: [
          Row(
            children: [
              Container(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://pbs.twimg.com/profile_images/541828089978703872/my-B7DV5_400x400.jpeg'),
                ),
                margin: EdgeInsets.only(right: 10.0),
              ),
              Text('ch1ch1c0'),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_drop_down),
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                AnimatedBuilder(
                  animation: animationController,
                  // valueListenable: velocidad,
                  builder: (_, value) {
                    return Container(
                      width: 500,
                      height: 500,
                      // color: Colors.red,
                      child: CustomPaint(
                        painter: VelocimetroPainting(
                          limiteVelocimetro * animation.value,
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -140.0, 0.0),
                  child: Image.asset(
                    'assets/car1.png',
                    height: 200,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              // color: Colors.white70,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.blue,
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                      offset: Offset(3.0, 6.0)),
                ],
              ),
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text('Aqui va la gasolina'),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/station.svg',
                        color: Colors.blue,
                        height: 50,
                        matchTextDirection: true,
                      ),
                      SvgPicture.asset(
                        'assets/dropfill.svg',
                        color: Colors.blue,
                        height: 20,
                        matchTextDirection: true,
                      ),
                      SvgPicture.asset(
                        'assets/dropfill.svg',
                        color: Colors.blue,
                        height: 20,
                        matchTextDirection: true,
                      ),
                      SvgPicture.asset(
                        'assets/dropfill.svg',
                        color: Colors.blue,
                        height: 20,
                        matchTextDirection: true,
                      ),
                      SvgPicture.asset(
                        'assets/dropfill.svg',
                        color: Colors.blue,
                        height: 20,
                        matchTextDirection: true,
                      ),
                      SvgPicture.asset(
                        'assets/drop.svg',
                        color: Colors.blue,
                        height: 20,
                        matchTextDirection: true,
                      ),
                      SvgPicture.asset(
                        'assets/drop.svg',
                        color: Colors.blue,
                        height: 20,
                        matchTextDirection: true,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: animationController,
                        // valueListenable: velocidad,
                        builder: (_, value) {
                          return Text(
                            (limiteVelocimetro * animation.value)
                                .toStringAsFixed(0),
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          );
                        },
                      ),
                      Text(
                        'km/h',
                        style: TextStyle(fontSize: 25, color: Colors.blue),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onVerticalDragStart: _acelerar,
                        onVerticalDragEnd: _soltarAcelerador,
                        child: Container(
                          height: 80.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Divider(),
                      Text('Acelerame')
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _acelerar1() {
    // mytymer?.cancel();
    // mytymer = Timer.periodic(Duration(milliseconds: 100), (timer) {
    //   velocidad.value += 5;
    //   if (velocidad.value >= limiteVelocimetro) {
    //     mytymer?.cancel();
    //     return;
    //   }
    // });
    animationController.forward(from: animationController.value);
  }

  void _soltarAcelerador1(_) {
    // mytymer?.cancel();
    // mytymer = Timer.periodic(Duration(milliseconds: 100), (timer) {
    //   velocidad.value -= 5;
    //   if (velocidad.value <= 0) {
    //     mytymer?.cancel();
    //     return;
    //   }
    // });
    animationController.reverse(from: animationController.value);
  }

  void _acelerar(_) {
    if (animationController.status != AnimationStatus.forward) {
      animationController.forward(from: animationController.value);
    }
  }

  void _soltarAcelerador(_) {
    animationController.reverse(from: animationController.value);
  }
}

class VelocimetroPainting extends CustomPainter {
  final double velocidad;
  VelocimetroPainting(this.velocidad);

  @override
  void paint(Canvas canvas, Size size) {
    final middleWidth = size.width / 2;
    final middleHeight = size.height / 2;
    final tamanio = middleHeight * 0.9;
    final poquito = 5;

    /** dibujar lineas de velocidad */
    canvas.save();
    canvas.translate(middleWidth, middleHeight);
    canvas.rotate(-_gradosARadianes(110));

    final paint = Paint();
    paint.color = Colors.grey;

    // final double velocidad = 120;
    final giroCanvas = -220 / 80;
    final maximaVelocidad = 400;

    double counter = 0;
    final velocidadKmAgrados = ((velocidad + 1) * 220 / maximaVelocidad);

    for (var i = 0; i <= 80; i++) {
      final double mod = i % 10 == 0 ? 3 : 1.5;
      final porc = i / 80;

      final gradosActual = -_gradosARadianes(giroCanvas);

      final velocidadGrados = _gradosARadianes(velocidadKmAgrados);

      final double alto =
          i % 10 == 0 ? -(middleHeight) : -(middleHeight - poquito);
      RRect myrect = RRect.fromLTRBXY(-mod, -tamanio, mod, alto, 25, 25);

      paint.color =
          (velocidadGrados < counter) ? Colors.grey : _getColorDegradado(porc);
      canvas.drawRRect(myrect, paint);
      canvas.rotate(gradosActual);

      counter += gradosActual;
    }

    canvas.restore();
    /** dibujar lineas de velocidad */

    /** degradado */
    canvas.save();
    final paintVelocidad = Paint();

    paintVelocidad.color = Colors.blue.withOpacity(0.5);

    paintVelocidad.shader = RadialGradient(
            colors: [Colors.blue.withOpacity(0.2), Colors.white],
            stops: [0.1, 0.9],
            focal: Alignment.center,
            center: Alignment.center)
        .createShader(
      Rect.fromCircle(
          center: Offset(middleWidth, middleWidth), radius: middleWidth),
    );

    final gradosInicio = -_gradosARadianes(200);
    final gradosvelocidad = _gradosARadianes(velocidadKmAgrados);
    canvas.drawArc(
      Rect.fromLTWH(0.0, 0.0, size.width, size.width),
      gradosInicio,
      gradosvelocidad,
      true,
      paintVelocidad,
    );

    canvas.restore();
    /** degradado */

    /** plumita */
    canvas.save();
    canvas.translate(middleWidth, middleHeight);
    canvas.rotate(-_gradosARadianes(110));

    canvas.rotate(_gradosARadianes(velocidadKmAgrados));
    final paintPluma = Paint();
    RRect rectPlumita = RRect.fromLTRBXY(-5, -tamanio, 5, 10, 25, 25);
    canvas.drawRRect(rectPlumita, paintPluma);

    canvas.restore();
    /** plumita */
  }

  double _gradosARadianes(double grados) {
    return (grados * pi.pi) / 180;
  }

  Color _getColorDegradado(double value) {
    final double hue = ((1 - value) * 200);
    return HSLColor.fromAHSL(1, hue, 1, 0.40).toColor();
  }

  @override
  bool shouldRepaint(VelocimetroPainting oldDelegate) =>
      oldDelegate.velocidad != this.velocidad;

  @override
  bool shouldRebuildSemantics(VelocimetroPainting oldDelegate) =>
      oldDelegate.velocidad != this.velocidad;
}
