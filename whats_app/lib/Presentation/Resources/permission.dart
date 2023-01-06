import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus> permission(Permission permission) async {
  await permission.request();
  return permission.status;
}
