import 'package:flutter_test/flutter_test.dart';
import 'package:app_todo_application/utils/throttle.dart';

void main() {
  group("Throttle Tests", () {
    test("lần trigger đầu tiên có chạy ngay lập tức không", () {
      int count = 0;

      final throttle = Throttle(delay: Duration(milliseconds: 1000));

      throttle.trigger(() {
        count++;
      });

      expect(count, 1);
    });

    test("spam nhiều lần trong thời gian delay chỉ lấy 1 ", () {
      int count = 0;

      final throttle = Throttle(delay: Duration(milliseconds: 200));

      throttle.trigger(() => count++);
      throttle.trigger(() => count++);
      throttle.trigger(() => count++);
      throttle.trigger(() => count++);

      expect(count, 1);
    });

    test("sau khi hết thời gian delay có thể trigger lại ", () async {
      int count = 0;

      final throttle = Throttle(delay: Duration(milliseconds: 200));

      throttle.trigger(() {
        count++;
      });

      await Future.delayed(Duration(milliseconds: 250));

      throttle.trigger(() {
        count++;
      });

      expect(count, 2);
    });
  });
}
