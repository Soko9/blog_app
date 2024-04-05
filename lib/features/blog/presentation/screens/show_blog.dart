import "package:blog_app/core/theme/app_palette.dart";
import "package:blog_app/core/theme/app_theme.dart";
import "package:blog_app/core/utils/helpers.dart";
import "package:flutter/material.dart";

import "../../domain/entities/blog.dart";

class ShowBlog extends StatelessWidget {
  final Blog blog;

  const ShowBlog({super.key, required this.blog});

  static route({required Blog blog}) => MaterialPageRoute(
        builder: (_) => ShowBlog(
          blog: blog,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.5,
                child: blog.imageUrl == null
                    ? Container(
                        width: size.width,
                        height: size.height * 0.5,
                        color: AppPalette.borderColor,
                        padding: EdgeInsets.all(size.width * 0.35),
                        child: const FittedBox(
                          child: Center(
                            child: Icon(
                              Icons.image_not_supported_rounded,
                              color: AppPalette.white,
                            ),
                          ),
                        ),
                      )
                    : Image.network(
                        blog.imageUrl!,
                        fit: BoxFit.cover,
                        width: size.width,
                        height: size.height * 0.5,
                      ),
              ),
              const SizedBox(height: 4.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: blog.tags
                          .map(
                            (e) => Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 8.0,
                              ),
                              decoration: BoxDecoration(
                                color: e.color,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                e.name,
                                style: const TextStyle(
                                  color: AppPalette.white,
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      blog.title,
                      style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.white,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "by ${blog.profileName!}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 12.0,
                            letterSpacing: 2.2,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "${formatDateForBlog(dateTime: blog.createdAt)} . ${calculateReadingTime(blogContent: blog.content)} min",
                          style: const TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 12.0,
                            letterSpacing: 2.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Divider(
                      height: 50.0,
                      thickness: 1.0,
                      color: AppPalette.borderColor,
                      indent: size.width * 0.1,
                      endIndent: size.width * 0.1,
                    ),
                    Text(
                      blog.content,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: AppTheme.fontMontserrat,
                        color: Colors.white70,
                        height: 2.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
