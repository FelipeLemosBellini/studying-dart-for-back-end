import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'models/login_model.dart';
import 'models/response_success_login_model.dart';

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

      if (name != null && lastName != null && name.isNotEmpty && lastName.isNotEmpty) {
        return Response.ok('Your name is $name $lastName');
      } else {
        return Response.badRequest(body: "Invalid request");
      }
    });

    router.get('/bad/request', (Request request) {
      return Response.badRequest(body: "Bad Request 0_0");
    });

    //passar no body -> raw -> json
    //
    // {
    //     "email": "email",
    //     "password": "password"
    // }

    router.post('/login', (Request request) async {
      var body = await request.readAsString();
      Map<String, dynamic> jsonMap = jsonDecode(body);
      LoginModel login = LoginModel.fromMap(jsonMap);

      if (login.email == "email" && login.password == "password")
        return Response(200);
      else
        return Response.badRequest(body: 'Invalid login');
    });

    //outra opção sem o model
    router.post('/other/login', (Request request) async {
      var body = await request.readAsString();
      Map<String, dynamic> jsonMap = jsonDecode(body);
      var email = jsonMap['email'];
      var password = jsonMap['password'];

      if (email == "email" && password == "password") {
        return Response(200);
      } else {
        return Response.badRequest(body: 'Invalid login');
      }
    });

    //return a json
    router.post('/login/with/token', (Request request) async {
      var body = await request.readAsString();
      Map<String, dynamic> jsonMap = jsonDecode(body);
      LoginModel login = LoginModel.fromMap(jsonMap);
      if (login.email == "email" && login.password == "password") {
        ResponseSuccessLoginModel successLoginModel = ResponseSuccessLoginModel(token: 'token123', username: 'Felipe');
        return Response(200, body: successLoginModel.toJson(), headers: {'content-type': 'application/json'});
      } else {
        return Response.badRequest(body: 'Invalid login');
      }
    });

    return router;
  }
}
