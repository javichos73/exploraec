import 'package:flutter/material.dart';

void main() {
  runApp(const ExploraEcApp());
}

class ExploraEcApp extends StatelessWidget {
  const ExploraEcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExploraEC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFBFBF9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D7A68),
          primary: const Color(0xFF0D7A68),
        ),
      ),
      home: const BienvenidaScreen(),
    );
  }
}

class BienvenidaScreen extends StatelessWidget {
  const BienvenidaScreen({super.key});

  static const Color primaryTeal = Color(0xFF0D7A68);
  static const Color lightTeal = Color(0xFF0E8388);
  static const Color warmAmber = Color(0xFFF59E0B);
  static const Color bgCream = Color(0xFFFBFBF9);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textMuted = Color(0xFF475569);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgCream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1. Barra superior: Oficial Ecuador / Idioma
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(radius: 4, backgroundColor: warmAmber),
                        SizedBox(width: 6),
                        Text(
                          'OFICIAL • ECUADOR',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: primaryTeal,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.language, size: 16, color: primaryTeal),
                        SizedBox(width: 4),
                        Text(
                          'ES',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // 2. Sección central: Ícono, Título, Subtítulo y Píldoras Bento
              Column(
                children: [
                  // Ícono / Emblema superior con halo decorativo
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryTeal.withOpacity(0.08),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: primaryTeal.withOpacity(0.18),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.landscape_rounded,
                          size: 50,
                          color: primaryTeal,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.wb_sunny_rounded, size: 12, color: warmAmber),
                              SizedBox(width: 3),
                              Text(
                                '0° LAT',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: textDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Chip de las 4 regiones
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      color: primaryTeal.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'CUATRO MUNDOS: COSTA • ANDES • AMAZONÍA • GALÁPAGOS',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: primaryTeal,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Título principal ExploraEC
                  RichText(
                    text: const TextSpan(
                      text: 'Explora',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                        letterSpacing: -0.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'EC',
                          style: TextStyle(color: primaryTeal),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtítulo breve
                  const Text(
                    'Descubre los rincones más fascinantes del Ecuador',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: textMuted,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 22),

                  // 3 Píldoras Bento de características
                  Row(
                    children: [
                      _buildBentoItem(Icons.route_outlined, 'Rutas', 'Patrimoniales', primaryTeal),
                      const SizedBox(width: 10),
                      _buildBentoItem(Icons.volcano_outlined, 'Volcanes', '& Reservas', warmAmber),
                      const SizedBox(width: 10),
                      _buildBentoItem(Icons.storefront_outlined, 'Experiencias', 'Locales', primaryTeal),
                    ],
                  ),
                ],
              ),

              // 3. Parte inferior: Botón 'Empezar' y enlaces secundarios
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [lightTeal, primaryTeal],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: primaryTeal.withOpacity(0.38),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Empezar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.4,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Ya tengo una cuenta',
                          style: TextStyle(fontSize: 12, color: textMuted, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Text('•', style: TextStyle(color: Colors.grey)),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Explorar como invitado',
                          style: TextStyle(fontSize: 12, color: textMuted, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildBentoItem(IconData icon, String title, String subtitle, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black.withOpacity(0.04)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: color.withOpacity(0.12),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textDark),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 9, color: textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
