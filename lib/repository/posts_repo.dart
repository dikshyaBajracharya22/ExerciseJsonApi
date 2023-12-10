import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exercise_json/model/comments.dart';
import 'package:exercise_json/model/data_response.dart';
import 'package:exercise_json/model/todos.dart';
import 'package:exercise_json/model/users.dart';

import '../model/post_model.dart';

class NotesRepository {
  final _dio = Dio();

  List<Notes> _notes = [];
  List<Comments> _comments = [];
  List<Users> users = [];
  List<Todos> todos = [];

  List<Notes> get notes => _notes;
  // List<Users> get users => _users;
//Get Posts
  Future<DataResponse> fetchNotes() async {
    try {
      await Future.delayed(Duration(seconds: 1));

      final _response = await _dio.get(
        "https://jsonplaceholder.typicode.com/posts",
      );
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        final _temp = List.from(_response.data);
        final _data = _temp.map((e) => Map<String, dynamic>.from(e)).toList();
        //put this api json value to our model data
        _notes = _data.map((e) => Notes.jsonn(e)).toList();

        return DataResponse.success(_notes);
      } else {
        return DataResponse.error("Server Error");
      }
    } on SocketException catch (e) {
      return DataResponse.error("No Internet Connection");
    }
  }

//Fetch All Comments
  Future<DataResponse> fetchComments(post_id) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      final _response = await _dio
          .get("https://jsonplaceholder.typicode.com/posts/$post_id/comments");
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        final temp = List.from(_response.data);
        final _data = temp.map((e) => Map<String, dynamic>.from(e)).toList();
        _comments = _data.map((e) => Comments.jsonn(e)).toList();

        return DataResponse.success(_comments);
      } else {
        return DataResponse.error("Server Error");
      }
    } on SocketException catch (e) {
      return DataResponse.error("No Internet Connection");
    }
  }

  //Add/Post Comments

  Future<DataResponse> addComments(
      {required name, required email, required body, required postId}) async {
    try {
      final _body = [
        {"postId": postId, "name": name, "email": email, "body": body}
      ];
      await Future.delayed(Duration(seconds: 1));
      final _response = await _dio.post(
          "https://jsonplaceholder.typicode.com/posts/$postId/comments",
          data: _body);
      print(_response.statusCode);
      print(_response.data);

      if (_response.statusCode == 200 || _response.statusCode == 201) {
        return DataResponse.success([_response]);
      } else {
        return DataResponse.error("Unable to post comment");
      }
    } on SocketException catch (e) {
      return DataResponse.error("No Internet connection");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
  //Fetch Users

  Future<DataResponse> fetchUsers() async {
    try {
      final _response =
          await _dio.get("https://jsonplaceholder.typicode.com/users");
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        final _temp = List.from(_response.data);
        final _data = _temp.map((e) => Map<String, dynamic>.from(e)).toList();

        users = _data.map((e) => Users.jsoon(e)).toList();
        return DataResponse.success(users);
      } else {
        return DataResponse.error("Unable to Load Users");
      }
    } on SocketException catch (e) {
      return DataResponse.error("No Internet Connection");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  //Todos

  Future<DataResponse> loadTodos({required userId}) async {
    final _response = await _dio
        .get("https://jsonplaceholder.typicode.com/users/$userId/todos");
    try {
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        final _temp = List.from(_response.data);
        final _data = _temp.map((e) => Map<String, dynamic>.from(e)).toList();
        todos = _data.map((e) => Todos.jsoon(e)).toList();
        return DataResponse.success(todos);
      } else {
        return DataResponse.error("Unable to load Todos");
      }
    } on SocketException catch (e) {
      return DataResponse.error("NO Internet Connection");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  // add todos
  Future<DataResponse> addTodo(
      {required userId, required title, required completed}) async {
    try {
      final _body = [
        {"userId": userId, "title": title, "completed": completed}
      ];
      await Future.delayed(Duration(seconds: 1));
      final _response = await _dio.post(
          "https://jsonplaceholder.typicode.com/users/$userId/todos",
          data: _body);
      print(_response.data);
      print(_response.statusCode);
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        return DataResponse.success([_response]);
      } else {
        return DataResponse.error("Unable to add todo");
      }
    } on SocketException catch (e) {
      return DataResponse.error("No Internet Connection");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

//update todo
  Future<DataResponse> updateTodo(
      {required userId, required title, required completed}) async {
    final _body = [
      {
        "userId": userId,
        "title": title,
        "completed": completed,
      }
    ];
    final _response = await _dio
        .put("https://jsonplaceholder.typicode.com/todos/$userId", data: _body);
    print(_response.data);
    print(_response.statusCode);

    try {
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        return DataResponse.success([_response]);
      } else {
        return DataResponse.error("Unable to update");
      }
    } on SignalException catch (e) {
      return DataResponse.error("No Internet Connection");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
  //delete todo
  Future<DataResponse> deleteTodo({required id}) async {

    final _response = await _dio
        .delete("https://jsonplaceholder.typicode.com/todos/$id");
    print(_response.data);
    print(_response.statusCode);

    try {
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        return DataResponse.success([]);
      } else {
        return DataResponse.error("Unable to delete");
      }
    } on SignalException catch (e) {
      return DataResponse.error("No Internet Connection");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
