import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TaskState {}

//  Trạng thái khởi tạo
class TaskInitial extends TaskState {}

// Trạng thái đang tải dữ liệu từ Firebase
class TaskLoading extends TaskState {}

// Trạng thái đã tải dữ liệu thành công
class TaskLoaded extends TaskState {
  final List<QueryDocumentSnapshot> tasks;
  final String searchQuery;
  final String sortType;

  TaskLoaded({
    required this.tasks,
    this.searchQuery = '',
    this.sortType = 'Newest',
  });
  List<QueryDocumentSnapshot> get filteredTasks {
    // 1. Lọc theo Search
    List<QueryDocumentSnapshot> list = tasks.where((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final title = (data['title'] ?? "").toString().toLowerCase();
      return title.contains(searchQuery.toLowerCase());
    }).toList();
    // 2. Sắp xếp theo SortType
    if (sortType == 'Alpha') {
      list.sort(
        (a, b) => a['title'].toString().compareTo(b['title'].toString()),
      );
    } else if (sortType == 'Deadline') {
      list.sort((a, b) {
        // Hàm hỗ trợ chuyển đổi chuỗi "d/M/yyyy" và "H:m" thành đối tượng DateTime để so sánh
        DateTime parseDateTime(Map<String, dynamic> data) {
          try {
            List<String> dateParts = (data['date'] as String).split('/');
            List<String> timeParts = (data['time'] as String).split(':');
            return DateTime(
              int.parse(dateParts[2]), // Năm
              int.parse(dateParts[1]), // Tháng
              int.parse(dateParts[0]), // Ngày
              int.parse(timeParts[0]), // Giờ
              int.parse(timeParts[1]), // Phút
            );
          } catch (e) {
            return DateTime(2000); // Trả về ngày mặc định nếu dữ liệu lỗi
          }
        }

        DateTime dtA = parseDateTime(a.data() as Map<String, dynamic>);
        DateTime dtB = parseDateTime(b.data() as Map<String, dynamic>);

        // So sánh thời gian thực: Task nào cũ hơn sẽ xuống dưới, task sắp tới sẽ lên đầu
        return dtA.compareTo(dtB);
      });
    }
    return list;
  }
}

// Trạng thái xảy ra lỗi
class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
