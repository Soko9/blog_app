import "package:blog_app/core/theme/app_palette.dart";
import "package:blog_app/core/utils/helpers.dart";
import "package:blog_app/features/blog/domain/entities/blog.dart";
import "package:flutter/material.dart";

class BlogTile extends StatelessWidget {
  final int index;
  final Blog blog;
  final VoidCallback whenPress;

  const BlogTile({
    super.key,
    required this.index,
    required this.blog,
    required this.whenPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: whenPress,
      child: Container(
        margin: const EdgeInsets.all(12.0),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 8.0,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: index % 2 == 0
                ? [AppPalette.background, AppPalette.borderColor]
                : [AppPalette.borderColor, AppPalette.background],
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: AppPalette.white,
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      blog.createdAt.toIso8601String().substring(0, 10),
                      style: const TextStyle(
                        color: AppPalette.white,
                        letterSpacing: 2.2,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "${calculateReadingTime(blogContent: blog.content)} min read",
                      style: const TextStyle(
                        color: AppPalette.white,
                        letterSpacing: 2.2,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: AppPalette.white),
                          right:
                              BorderSide(width: 1.0, color: AppPalette.white),
                          left: BorderSide(width: 1.0, color: AppPalette.white),
                          bottom: BorderSide.none,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      child: const Text(
                        "by",
                        style: TextStyle(
                          color: AppPalette.white,
                          letterSpacing: 2.2,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 4.0),
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(width: 1.0, color: AppPalette.white),
                          right:
                              BorderSide(width: 1.0, color: AppPalette.white),
                          left: BorderSide(width: 1.0, color: AppPalette.white),
                          top: BorderSide(width: 1.0, color: AppPalette.white),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4.0),
                          bottomRight: Radius.circular(4.0),
                          topLeft: Radius.circular(4.0),
                        ),
                      ),
                      child: Text(
                        blog.profileName!,
                        style: const TextStyle(
                          color: AppPalette.white,
                          letterSpacing: 2.2,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
