import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:exploraec/controllers/auth_controller.dart';
import 'package:exploraec/controllers/gastos_controller.dart';
import 'package:exploraec/screens/gastos_screen.dart';
import 'package:exploraec/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

/// Backend falso para la prueba de widget de filtro de gastos.
class _BackendFalso implements HttpClientAdapter {
  final gastos = <Map<String, dynamic>>[
    {
      'id': 1,
      'descripcion': 'Almuerzo en Quito',
      'monto': 7.50,
      'categoria': 'comida',
      'fecha': '2026-10-14',
    },
    {
      'id': 2,
      'descripcion': 'Boleto de bus',
      'monto': 3.25,
      'categoria': 'transporte',
      'fecha': '2026-10-14',
    },
    {
      'id': 3,
      'descripcion': 'Cena marinera',
      'monto': 12.00,
      'categoria': 'comida',
      'fecha': '2026-10-14',
    },
    {
      'id': 4,
      'descripcion': 'Entrada a teleférico',
      'monto': 9.00,
      'categoria': 'entretenimiento',
      'fecha': '2026-10-14',
    },
  ];

  ResponseBody _json(Object? cuerpo, int codigo, [Map<String, List<String>> h = const {}]) =>
      ResponseBody.fromString(
        cuerpo == null ? '' : jsonEncode(cuerpo),
        codigo,
        headers: {
          Headers.contentTypeHeader: ['application/json'],
          ...h,
        },
      );

  @override
  Future<ResponseBody> fetch(RequestOptions o, Stream<Uint8List>? cuerpo, Future<void>? cancelar) async {
    final ruta = o.path;
    if (ruta == '/usuarios/token') {
      return _json({'access_token': 'tok-test@b.com', 'token_type': 'bearer'}, 200);
    }
    if (ruta == '/usuarios/me') {
      return _json({'id': 1, 'email': 'test@b.com'}, 200);
    }
    if (ruta == '/gastos/categorias') {
      return _json({
        'categorias': ['comida', 'transporte', 'entretenimiento', 'otros'],
        'limite_por_categoria': 500.0,
      }, 200);
    }
    if (ruta == '/gastos/' && o.method == 'GET') {
      return _json(gastos, 200, {'x-total-count': ['${gastos.length}']});
    }
    return _json({'detail': 'ruta no prevista: $ruta'}, 404);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  setUpAll(() => Hive.init(Directory.systemTemp.createTempSync('hive_filtro_test').path));

  Future<void> montar() async {
    Get.reset();
    Get.testMode = true;
    FlutterSecureStorage.setMockInitialValues({});
    final backend = _BackendFalso();
    Get.put(ApiClient(dio: Dio(BaseOptions(baseUrl: 'http://backend'))..httpClientAdapter = backend));
    final auth = Get.put(AuthController());
    await auth.iniciarSesion('test@b.com', 'clave-1234');
    final controller = Get.put(GastosController());
    for (var i = 0; i < 200 && controller.gastos.isEmpty; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }

  testWidgets('al elegir «comida» solo se ven los gastos de comida', (tester) async {
    await tester.runAsync(montar);
    await tester.pumpWidget(const GetMaterialApp(home: GastosScreen()));
    await tester.pumpAndSettle();

    // Verificamos que inicialmente se ven todos los gastos
    expect(find.text('Almuerzo en Quito'), findsOneWidget);
    expect(find.text('Boleto de bus'), findsOneWidget);
    expect(find.text('Cena marinera'), findsOneWidget);
    expect(find.text('Entrada a teleférico'), findsOneWidget);

    // Seleccionamos la categoría 'comida' tocando su chip
    await tester.tap(find.widgetWithText(ChoiceChip, 'comida'));
    await tester.pumpAndSettle();

    // Solo se deben mostrar los gastos de comida
    expect(find.text('Almuerzo en Quito'), findsOneWidget);
    expect(find.text('Cena marinera'), findsOneWidget);
    expect(find.text('Boleto de bus'), findsNothing);
    expect(find.text('Entrada a teleférico'), findsNothing);

    // Al tocar «Todas», se vuelven a mostrar todos los gastos
    await tester.tap(find.widgetWithText(ChoiceChip, 'Todas'));
    await tester.pumpAndSettle();

    expect(find.text('Almuerzo en Quito'), findsOneWidget);
    expect(find.text('Boleto de bus'), findsOneWidget);
    expect(find.text('Cena marinera'), findsOneWidget);
    expect(find.text('Entrada a teleférico'), findsOneWidget);
  });
}
