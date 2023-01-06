import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus?> permission(Permission permission) async {
  if (await permission.status.isDenied) {
    return await permission.request();
  }
  return null;
}
