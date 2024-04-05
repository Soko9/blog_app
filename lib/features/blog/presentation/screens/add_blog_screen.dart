import "dart:io";

import "package:blog_app/core/shared/cubits/app_user/app_user_cubit.dart";
import "package:blog_app/core/shared/widgets/gradient_button.dart";
import "package:blog_app/core/shared/widgets/input_field.dart";
import "package:blog_app/core/shared/widgets/loader.dart";
import "package:blog_app/core/theme/app_palette.dart";
import "package:blog_app/core/utils/helpers.dart";
import "package:blog_app/features/blog/presentation/bloc/blog_bloc.dart";
import "package:dotted_border/dotted_border.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../core/utils/enums.dart";

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  static route() => MaterialPageRoute(
        builder: (_) => const AddBlogScreen(),
      );

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final List<TAG> _tags = List.empty(growable: true);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _image;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _tagPressed({required TAG tag}) {
    if (_tags.contains(tag)) {
      setState(() {
        _tags.remove(tag);
      });
    } else {
      setState(() {
        _tags.add(tag);
      });
    }
  }

  void selectImage() async {
    final image = await pickImageFromGallery();
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void _publishBlog() {
    if (_formKey.currentState!.validate() && _tags.isNotEmpty) {
      final event = BlogPublishEvent(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        tags: _tags,
        image: _image,
        profileId:
            (context.read<AppUserCubit>().state as AppUserLoggedIn).profile.id,
      );
      context.read<BlogBloc>().add(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Opacity(
              opacity: _tags.isNotEmpty ? 1.0 : 0.3,
              child: GradientButton(
                label: "publish",
                onPress: _tags.isNotEmpty ? _publishBlog : null,
                color: AppPalette.purple,
                radius: 2.0,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) async {
            if (state is BlogFailure) {
              showErrorDialog(
                context: context,
                message: state.message,
              );
            }
            if (state is BlogPublishSuccess) {
              setState(() {
                _tags.clear();
                _titleController.clear();
                _contentController.clear();
                _image = null;
              });
              showSuccessDialog(
                context: context,
                message: "Way to go!",
              );
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            }
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: selectImage,
                          child: DottedBorder(
                            color: AppPalette.borderColor,
                            dashPattern: const [10, 4],
                            radius: const Radius.circular(8.0),
                            borderType: BorderType.RRect,
                            strokeCap: StrokeCap.round,
                            child: SizedBox(
                              width: size.width,
                              height: size.height * 0.3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: _image == null
                                    ? const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.folder_open_rounded,
                                              size: 48.0),
                                          SizedBox(height: 24.0),
                                          Text("add your image"),
                                        ],
                                      )
                                    : Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        if (_image != null)
                          Positioned(
                            top: -12.0,
                            right: -12.0,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                              icon: Icon(
                                Icons.cancel,
                                size: 24.0,
                                color: AppPalette.error.withOpacity(0.7),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: TAG.values
                            .map(
                              (tag) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () => _tagPressed(tag: tag),
                                  child: Chip(
                                    label: Text(
                                      tag.name,
                                      style: const TextStyle(fontSize: 12.0),
                                    ),
                                    elevation: 12.0,
                                    padding: const EdgeInsets.all(6.0),
                                    backgroundColor: _tags.contains(tag)
                                        ? tag.color
                                        : AppPalette.background,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    side: _tags.contains(tag)
                                        ? BorderSide.none
                                        : const BorderSide(
                                            width: 0.5,
                                            color: AppPalette.borderColor,
                                          ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    InputField(
                      controller: _titleController,
                      hint: "title",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "title is missing";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    InputField(
                      controller: _contentController,
                      hint: "content",
                      lines: null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "content is missing";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
