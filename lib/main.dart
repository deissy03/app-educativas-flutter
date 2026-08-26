import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const AprendeJugandoApp());
}

class AprendeJugandoApp extends StatelessWidget {
  const AprendeJugandoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aprende Jugando',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController nombreController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4FC3F7),
              Color(0xFF7E57C2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
              Image.asset(
  'assets/bueno.png',
  height: 130,
),
                const SizedBox(height: 20),
                const Text(
                  "Aprende Jugando",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "¿Cómo te llamas?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nombreController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Escribe tu nombre",
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (nombreController.text
                        .trim()
                        .isEmpty) {
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomePage(
                          nombre:
                              nombreController.text
                                  .trim(),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "🚀 Comenzar",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String nombre;

  const HomePage({
    super.key,
    required this.nombre,
  });

  Widget boton(
    BuildContext context,
    String texto,
    Color color,
    Widget pantalla,
  ) {
    return SizedBox(
      width: 340,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => pantalla,
            ),
          );
        },
        child: Text(
          texto,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4FC3F7),
              Color(0xFF7E57C2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              Text(
                "👋 Hola $nombre",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              TweenAnimationBuilder(
  tween: Tween(begin: -30.0, end: 30.0),
  duration: const Duration(seconds: 4),
  curve: Curves.easeInOut,
  builder: (context, value, child) {
    return Transform.translate(
      offset: Offset(0, value),
      child: child,
    );
  },
  child: Image.asset(
    'assets/bueno.png',
    height: 150,
  ),
),

              const Text(
                "Selecciona una aventura",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  
                ),
              ),

              const SizedBox(height: 30),

              boton(
                context,
                "➕ SUMAS",
                Colors.green,
               JuegoPage(
               titulo: "Sumas",
               operacion: "+",
               nombre: nombre,
              ),
              ),

              const SizedBox(height: 30),

              boton(
                context,
                "➖ RESTAS",
                Colors.orange,
                JuegoPage(
                 titulo: "Restas",
                 operacion: "-",
                 nombre: nombre,
                ),
              ),

              const SizedBox(height: 30),

              boton(
                context,
                "✖️ MULTIPLICACIONES",
                Colors.purple,
                JuegoPage(
               titulo: "Multiplicaciones",
                operacion: "*",
                nombre: nombre,
               ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JuegoPage extends StatefulWidget {
  final String titulo;
  final String operacion;
  final String nombre;

  const JuegoPage({
    super.key,
    required this.titulo,
    required this.operacion,
    required this.nombre,
  });

  @override
  State<JuegoPage> createState() =>
      _JuegoPageState();
}

class _JuegoPageState extends State<JuegoPage> {
  final Random random = Random();

  int pregunta = 1;
  int correctas = 0;
  int incorrectas = 0;
  int nivel = 1;
  int estrellas = 0;

  int a = 0;
  int b = 0;

  List<int> opciones = [];

  @override
  void initState() {
    super.initState();
    generarPregunta();
  }

  int resultadoCorrecto() {
    if (widget.operacion == "+") {
      return a + b;
    }

    if (widget.operacion == "-") {
      return a - b;
    }

    return a * b;
  }

  void generarPregunta() {
  if (widget.operacion == "+") {

    if (nivel == 1) {
      a = random.nextInt(10) + 1;
      b = random.nextInt(10) + 1;
    } else if (nivel == 2) {
      a = random.nextInt(90) + 10;
      b = random.nextInt(90) + 10;
    } else {
      a = random.nextInt(900) + 100;
      b = random.nextInt(900) + 100;
    }

  } else if (widget.operacion == "-") {

    if (nivel == 1) {
      a = random.nextInt(20) + 10;
      b = random.nextInt(a);
    } else if (nivel == 2) {
      a = random.nextInt(90) + 10;
      b = random.nextInt(a);
    } else {
      a = random.nextInt(900) + 100;
      b = random.nextInt(a);
    }

  } else {

    if (nivel == 1) {
      a = random.nextInt(10) + 1;
      b = random.nextInt(10) + 1;
    } else if (nivel == 2) {
      a = random.nextInt(20) + 10;
      b = random.nextInt(10) + 2;
    } else {
      a = random.nextInt(50) + 20;
      b = random.nextInt(20) + 5;
    }
  }
    int correcta = resultadoCorrecto();

    opciones = [
      correcta,
      correcta + 1,
      correcta + 2,
    ];

    opciones.shuffle();

    setState(() {});
  }

  void responder(int valor) {
    if (valor == resultadoCorrecto()) {
  correctas++;
  estrellas++;
} else {
  incorrectas++;
}

    if (pregunta == 10) {
      mostrarResultado();
      return;
    }

    pregunta++;
    generarPregunta();
  }

  void mostrarResultado() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        bool aprobado = correctas >= 8;

        return AlertDialog(
         title: Text(
  aprobado
      ? "🎉 Nivel $nivel Superado"
      : "😢 Repite el Nivel $nivel",
),
         content: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Image.asset(
      correctas == 10
          ? 'assets/feliz.png'
          : (correctas >= 8
              ? 'assets/bueno.png'
              : 'assets/triste.png'),
      height: 150,
    ),
    const SizedBox(height: 15),

Text(
  "⭐ $estrellas / 10",
  style: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.orange,
  ),
),

const SizedBox(height: 10),

Text(
      "Correctas: $correctas\n"
      "Incorrectas: $incorrectas\n\n"
      "${aprobado ? 'Has pasado al siguiente nivel.' : 'Necesitas 8 respuestas correctas.'}",
      textAlign: TextAlign.center,
    ),
  ],
),
         actions: [
  ElevatedButton(
    onPressed: () {
      Navigator.pop(context);   
       

     if (aprobado && nivel < 3) {
  setState(() {
    nivel++;
    pregunta = 1;
    correctas = 0;
    incorrectas = 0;
    estrellas = 0;
  });

  generarPregunta();

} else if (!aprobado) {

  setState(() {
    pregunta = 1;
    correctas = 0;
    incorrectas = 0;
    estrellas = 0;
  });

  generarPregunta();

} else {

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(
  "🏆 ¡FELICIDADES ${widget.nombre}!",
),
content: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Image.asset(
      'assets/feliz.png',
      height: 120,
    ),
    const SizedBox(height: 10),
    Text(
      "Has completado los 3 niveles de ${widget.titulo}.",
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 10),
    Text(
      "⭐ Obtuviste $estrellas estrellas",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),
      actions: [
  ElevatedButton(
    onPressed: () {
      Navigator.pop(context);
      Navigator.pop(context);
    },
    child: const Text("🔄 Volver a jugar"),
  ),
],
    ),
  );
}
    },
    child: Text(
      aprobado && nivel < 3
          ? "Siguiente Nivel"
          : "Aceptar",
    ),
  )
],
        );
      },
    );
  }

  Widget botonRespuesta(int valor) {
    return SizedBox(
      width: 250,
      height: 70,
      child: ElevatedButton(
        onPressed: () => responder(valor),
        child: Text(
          "$valor",
          style: const TextStyle(
            fontSize: 28,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String simbolo;

if (widget.operacion == "*") {
  simbolo = "×";
} else {
  simbolo = widget.operacion;
}
    return Scaffold(
      appBar: AppBar(
      title: Text(
     "${widget.titulo} N$nivel",
       ),
      ),
      body: Center(
        child: Column(
          
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Text(
    "⭐ $estrellas",
    style: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.orange,
    ),
  ),

  const SizedBox(height: 20),
Image.asset(
  'assets/bueno.png',
  height: 120,
),

const SizedBox(height: 10),

Text(
  "Nivel $nivel - Pregunta $pregunta/10",
  style: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
),

const SizedBox(height: 10),

Text(
  "$a $simbolo $b = ?",
  style: const TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.bold,
  ),
),
            const SizedBox(height: 40),
            botonRespuesta(opciones[0]),
            const SizedBox(height: 15),
            botonRespuesta(opciones[1]),
            const SizedBox(height: 15),
            botonRespuesta(opciones[2]),
          ],
        ),
      ),
    );
  }
}