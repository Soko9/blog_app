import "dart:async";
import "dart:io";

import "package:blog_app/core/resources/usecase.dart";
import "package:blog_app/core/utils/enums.dart";
import "package:blog_app/features/blog/domain/usecases/get_all_blogs.dart";
import "package:blog_app/features/blog/domain/usecases/publish_blog.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../core/shared/cubits/app_user/app_user_cubit.dart";
import "../../domain/entities/blog.dart";
import "../../domain/usecases/sign_out_user.dart";

part "blog_event.dart";
part "blog_state.dart";

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final SignOutUser _signOutUser;
  final AppUserCubit _appUserCubit;
  final PublishBlog _publishBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({
    required SignOutUser signOutUserUsecase,
    required AppUserCubit appUserCubit,
    required PublishBlog publishBlogUsecase,
    required GetAllBlogs getAllBlogsUsecase,
  })  : _signOutUser = signOutUserUsecase,
        _appUserCubit = appUserCubit,
        _publishBlog = publishBlogUsecase,
        _getAllBlogs = getAllBlogsUsecase,
        super(const BlogInitial()) {
    on<BlogEvent>((_, emit) => emit(const BlogLoading()));
    on<BlogSignOutUserEvent>(_signOutEvent);
    on<BlogPublishEvent>(_publishEvent);
    on<BlogGetAllBlogsEvent>(_getAllBlogsEvent);
  }

  void _signOutEvent(
    BlogSignOutUserEvent event,
    Emitter<BlogState> emit,
  ) {
    _signOutUser(params: NoParams());
    _appUserCubit.updateUserState(profile: null);
  }

  FutureOr<void> _publishEvent(
    BlogPublishEvent event,
    Emitter<BlogState> emit,
  ) async {
    final result = await _publishBlog(
      params: PublishBlogParams(
        title: event.title,
        content: event.content,
        tags: event.tags,
        image: event.image,
        profileId: event.profileId,
      ),
    );

    result.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(const BlogPublishSuccess()),
    );

    await _getAllBlogsEvent(
      const BlogGetAllBlogsEvent(),
      emit,
    );
  }

  FutureOr<void> _getAllBlogsEvent(
    BlogGetAllBlogsEvent event,
    Emitter<BlogState> emit,
  ) async {
    final result = await _getAllBlogs(params: NoParams());

    result.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogFetchSuccess(blogs: r)),
    );
  }
}
