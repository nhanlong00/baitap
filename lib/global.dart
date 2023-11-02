import 'package:bot_toast/bot_toast.dart';
import 'package:core/import.dart';

showMessage(
  message, {
  String? type,
  bool slow = true,
  int timeShow = 2,
}) {
  final type0 = (type != null) ? type.toUpperCase() : '';
  Color color;
  IconData iconData;
  String status;
  switch (type0.toUpperCase()) {
    case 'SUCCESS':
      color = Colors.green;
      iconData = Icons.check_outlined;
      status = 'Thành công';
      break;
    case 'FAIL':
      color = Colors.red;
      iconData = Icons.close_rounded;
      status = 'Thất bại';
      break;
    case 'ERROR':
      color = Colors.red;
      iconData = Icons.close_rounded;
      status = 'Lỗi';
      break;
    case 'WARNING':
      color = Colors.deepOrange;
      iconData = Icons.warning_amber_outlined;
      status = 'Chờ';
      break;
    default:
      color = Colors.red;
      iconData = Icons.cancel_outlined;
      status = 'Lỗi';
  }
  if (message != null && message.toString() != 'null') {
    BotToast.showCustomText(
      duration: Duration(seconds: timeShow),
      onlyOne: true,
      clickClose: true,
      crossPage: true,
      ignoreContentClick: true,
      backgroundColor: const Color(0x00000000),
      backButtonBehavior: BackButtonBehavior.none,
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),
      toastBuilder: (_) => Align(
        alignment: const Alignment(0.95, -0.85),
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(8.0)),
          width: 370,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Icon(
                iconData,
                color: Colors.white,
                size: 70,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      message.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
