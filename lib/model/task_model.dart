class TaskModel {
  String id;
  String title;
  String description;
  String date;
  String time;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.isCompleted = false,
  });

  // Chuyển đổi thành Map để gửi lên Firebase
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'createdAt': DateTime.now(),
    };
  }

  // Chuyển từ dữ liệu Firebase (Map) sang đối tượng TaskModel
  factory TaskModel.fromMap(Map<String, dynamic> map, String docId) {
    return TaskModel(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}
