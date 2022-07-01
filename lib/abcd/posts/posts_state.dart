import 'package:equatable/equatable.dart';

import '../../models/post_model.dart';

//
// enum PostStatus { initial, success, failure}
//
// class PostsState extends Equatable {
//   final List<Post> posts;
//   final PostStatus status;
//   final bool hasReachedMax;
//
//   const PostsState(
//       {this.posts = const <Post>[],
//       this.status = PostStatus.initial,
//       this.hasReachedMax = false});
//
//   PostsState copyWith({PostStatus? status, List<Post>? posts, bool? hasReachedMax}) {
//     return PostsState(
//         posts: posts ?? this.posts,
//         status: status ?? this.status,
//         hasReachedMax: hasReachedMax ?? this.hasReachedMax);
//   }
//
//   @override
//   String toString(){
//     return '''PostState { status : $status , hasReachedMax : $hasReachedMax''';
//   }
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [posts, status, hasReachedMax];
// }


enum PostStatus{ initial, success, failure}

class PostsState extends Equatable{

  final List<Post> posts;
  final bool hasReachedMax;
  final PostStatus status;


  const PostsState(
      {this.posts = const <Post>[],
      this.hasReachedMax = false,
      this.status = PostStatus.initial});

  PostsState copyWith({
  List<Post>? posts, bool? hasReachedMax, PostStatus? status
}){
    return PostsState(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status
    );
}

  @override
  List<Object?> get props => [posts, status, hasReachedMax];

}