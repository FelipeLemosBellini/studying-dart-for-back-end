import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'server_handler.dart';

void main() async {
  var myServerHandler = MyServerHandler();

  await shelf_io.serve(myServerHandler.handler, 'localhost', 8080);
}
