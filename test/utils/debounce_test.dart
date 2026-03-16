import 'package:flutter_test/flutter_test.dart';
import 'package:app_todo_application/utils/debounce.dart';

void main() {
  group("Debounce Tests", () {
    test("sau 500ms có thực chạy đc không ", () async {
      int count = 0;

      final debounce = Debounce(delay: Duration(milliseconds: 1000));

      debounce.run(() {
        count++;
      });
      await Future.delayed(Duration(seconds: 2));

      debounce.run(() {
        count++;
      });
      await Future.delayed(Duration(seconds: 2));

      debounce.run(() {
        count++;
      });

      await Future.delayed(Duration(seconds: 2));
      expect(count, 3);
    });

    test("thực hiện nhiều lần nhưng lấy giá trị cuối", () async {
      int count = 0;

      final debounce = Debounce(delay: Duration(milliseconds: 200));

      debounce.run(() {
        count++;
      });

      debounce.run(() {
        count++;
      });

      debounce.run(() {
        count--;
      });

      await Future.delayed(Duration(milliseconds: 250));

      expect(count, -1);
    });
    test("dispose  rồi nhưng vẫn muốn chạy", () async {
      int count = 0;

      final debounce = Debounce(delay: Duration(milliseconds: 200));

      debounce.run(() {
        count++;
      });
      debounce.dispose();
      try {
        debounce.run(() {
          count++;
        });
      } catch (e) {
        print("ABCD $e");
      }

      await Future.delayed(Duration(milliseconds: 250));

      expect(count, 1);
    });
  });
}
