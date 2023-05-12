import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class MyServerHandler {
  Handler get handler {
    final router = Router();

    router.get('/', (Request request) {
      return Response(200, body: 'Fist Route');
    });

    router.get('/hello/world/', (Request request) {
      return Response.ok('Hello World');
    });

    //http://localhost:8080/hello/user/felipe
    router.get('/hello/user/<userName>', (Request request, String username) {
      return Response.ok('Hello $username');
    });
    //http://localhost:8080/query?name=Felipe&last_name=Bellini
    router.get('/query', (Request request) {
      String? name = request.url.queryParameters['name'];
      String? lastName = request.url.queryParameters['last_name'];

      if (name != null && lastName != null && name.isNotEmpty && lastName.isNotEmpty)
        return Response.ok('Your name is $name $lastName');
      else
        return Response.badRequest(body: "Invalid request");
    });

    router.get('/bad/request', (Request request) {
      return Response.badRequest(body: "Bad Request 0_0");
    });

    router.post('/login', (Request request) async {
      var body = await request.readAsString();

      print(request.url);
      print(request.method);
      print(request.handlerPath);
      print(request.requestedUri);
      print(request.headers);
      print(jsonDecode(body));
      return Response(200, body: json.decoder);
    });

    return router;
  }
}
