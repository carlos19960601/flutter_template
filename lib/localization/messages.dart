import 'package:flutter_template/localization/en.dart';
import 'package:flutter_template/localization/zh.dart';
import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": En().messages,
        "zh_CN": Zh().messages,
      };
}
