import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_examples/models/post_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import 'posts_event.dart';
import 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {

  PostsBloc({required this.httpClient}) : super(const PostsState()) {
    on<PostFetched>(_onPostFetched,
        transformer: throttleDroppable(throttleDuration));
  }

  final http.Client httpClient;
  final int _postLimit = 10;
  final throttleDuration = const Duration(milliseconds: 100);

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }

  Future<void> _onPostFetched(PostFetched event, Emitter<PostsState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPost();
        return emit(state.copyWith(
            posts: posts, status: PostStatus.success, hasReachedMax: false));
      }


      final posts = await _fetchPost(state.posts.length);

      posts.isEmpty ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: false));

    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
    print('isPostEmpty : ${state.hasReachedMax}');
  }

  Future<List<Post>> _fetchPost([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https('jsonplaceholder.typicode.com', '/posts',
          <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'}),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((json) {
        return Post(id: json['id'], title: json['title'], body: json['body']);
      }).toList();
    }
    throw Exception('Error fetching posts');
  }
}
