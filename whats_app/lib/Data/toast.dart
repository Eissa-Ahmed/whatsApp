import 'package:fluttertoast/fluttertoast.dart';
import 'package:whats_app/Presentation/Resources/colors_manager.dart';

Future<bool?> toast(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: ColorsManager.greyDark,
    textColor: ColorsManager.white,
    fontSize: 16.0,
  );
}
