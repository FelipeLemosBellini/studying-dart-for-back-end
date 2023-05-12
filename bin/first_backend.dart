import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'server_handler.dart';

void main() async {
  var myServerHandler = MyServerHandler();

  var server = await shelf_io.serve(myServerHandler.handler, 'localhost', 8080);

  server.autoCompress = true;

  print('Serving at http: ${server.address.host}:${server.port}');
}
