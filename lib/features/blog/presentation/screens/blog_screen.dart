import "package:blog_app/core/shared/widgets/loader.dart";
import "package:blog_app/core/utils/helpers.dart";
import "package:blog_app/features/blog/domain/entities/blog.dart";
import "package:blog_app/features/blog/presentation/bloc/blog_bloc.dart";
import "package:blog_app/features/blog/presentation/screens/add_blog_screen.dart";
import "package:blog_app/features/blog/presentation/screens/show_blog.dart";
import "package:blog_app/features/blog/presentation/widgets/blog_tile.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../core/theme/app_palette.dart";

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  static route() => MaterialPageRoute(
        builder: (_) => const BlogScreen(),
      );

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(const BlogGetAllBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const FittedBox(
          child: Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text("welcome back 👋"),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                AddBlogScreen.route(),
              );
            },
            icon: const Icon(
              Icons.post_add_rounded,
            ),
          ),
          const SizedBox(width: 12.0),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                context.read<BlogBloc>().add(const BlogSignOutUserEvent());
              },
              icon: const Icon(
                Icons.logout_rounded,
                size: 22.0,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (_, state) {
          if (state is BlogFailure) {
            showErrorDialog(
              context: context,
              message: state.message,
            );
            // print(state.message);
          }
        },
        builder: (_, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogFetchSuccess) {
            if (state.blogs.isEmpty) {
              return const Center(
                child: Text(
                  "No blogs yet...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w300,
                    color: AppPalette.grey,
                  ),
                ),
              );
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.blogs.length,
              itemBuilder: (_, index) {
                final Blog blog = state.blogs[index];
                return BlogTile(
                  index: index,
                  blog: blog,
                  whenPress: () {
                    Navigator.push(
                      context,
                      ShowBlog.route(blog: state.blogs[index]),
                    );
                  },
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
