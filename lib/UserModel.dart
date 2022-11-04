class UserModel {
  String? username;

  UserModel({this.username});
  factory UserModel.fromMap(map) {
    return UserModel(
      username: map["username"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "username": username,
    };
  }
}

class TodoModel {
  String? todo;
  bool? status;
  String? id;

  TodoModel({this.todo, this.status, this.id});
  factory TodoModel.fromMap(map) {
    return TodoModel(todo: map["todo"], status: map["status"], id: map['id']);
  }
  Map<String, dynamic> toMap() {
    return {"todo": todo, "status": status, "id": id};
  }
}
