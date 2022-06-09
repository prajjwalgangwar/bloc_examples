import 'package:bloc_examples/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'posts_bloc.dart';
import 'posts_event.dart';
import 'posts_state.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
            create: (_) =>
                PostsBloc(httpClient: http.Client())..add(PostFetched()),
            child: const PostList()),
      ),
    );
  }
}

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
      switch (state.status) {
        //-----------------       PostStatus.failure       -----------------
        case PostStatus.failure:
          return const Center(child: Text('Error in fetching posts'));

        //-----------------       PostStatus.success       -----------------
        case PostStatus.success:

          return state.posts.isNotEmpty
              ? ListView.builder(
                  itemCount: state.hasReachedMax
                      ? state.posts.length
                      : state.posts.length + 1,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return index >= state.posts.length
                        ? const BottomLoader()
                        : PostListItem(post: state.posts[index]);
                  })
              : const Center(
                  child: Text('No Posts'),
                );

        default:
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
    });
  }

  @override
  void ondispose() {
    super.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
  }

  void _onScroll() {
    if (isBottom) context.read<PostsBloc>().add(PostFetched());
  }

  bool get isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}

class PostListItem extends StatelessWidget {
  final Post post;

  const PostListItem({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListTile(
        tileColor: Colors.red.shade100,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            post.title,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            post.id.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            post.body,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
