import "package:blog_app/core/shared/cubits/app_user/app_user_cubit.dart";
import "package:blog_app/core/shared/network/network_connectivity.dart";
import "package:blog_app/features/auth/domain/usecases/get_current_user.dart";
import "package:blog_app/features/blog/data/sources/local/blog_local_data_source.dart";
import "package:blog_app/features/blog/data/sources/local/i_hive_blog_local_data_source.dart";
import "package:blog_app/features/blog/domain/usecases/sign_out_user.dart";
import "package:blog_app/features/blog/data/repo/i_blog_repo.dart";
import "package:blog_app/features/blog/data/sources/remote/blog_remote_data_source.dart";
import "package:blog_app/features/blog/data/sources/remote/i_supabase_blog_remote_data_source.dart";
import "package:blog_app/features/blog/domain/repo/blog_repo.dart";
import "package:blog_app/features/blog/domain/usecases/get_all_blogs.dart";
import "package:blog_app/features/blog/domain/usecases/publish_blog.dart";
import "package:blog_app/features/blog/presentation/bloc/blog_bloc.dart";
import "package:hive/hive.dart";
import "package:internet_connection_checker_plus/internet_connection_checker_plus.dart";

import "features/auth/data/repo/i_auth_repo.dart";
import "features/auth/data/sources/remote/auth_remote_data_source.dart";
import "features/auth/domain/repo/auth_repo.dart";
import "features/auth/domain/usecases/sign_in_user.dart";
import "features/auth/domain/usecases/sign_up_user.dart";
import "features/auth/presentation/bloc/auth_bloc.dart";
import "package:get_it/get_it.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "package:path_provider/path_provider.dart";
import "core/constants/app_secrets.dart";
import "features/auth/data/sources/remote/i_supabase_auth_remote_data_source.dart";

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.SUPABASE_PROJECT_URL,
    anonKey: AppSecrets.SUPABASE_ANON_KEY,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  // networn and connectivity
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
  sl.registerFactory<NetworkConnectivity>(
    () => INetworkConnectivity(
      connection: sl<InternetConnection>(),
    ),
  );

  // supabase client
  sl.registerLazySingleton<SupabaseClient>(() => supabase.client);

  // hive box
  sl.registerLazySingleton<Box>(() => Hive.box(name: "blogs"));

  // app user
  sl.registerLazySingleton<AppUserCubit>(() => AppUserCubit());

  _initAuthDependencies();
  _initBlogDependencies();
}

void _initAuthDependencies() {
  sl
    // remote data source
    ..registerFactory<AuthRemoteDataSource>(
      () => ISupabaseAuthRemoteDataSources(
        client: sl<SupabaseClient>(),
      ),
    )

    // repo
    ..registerFactory<AuthRepo>(
      () => IAuthRepo(
        authRemoteDataSource: sl<AuthRemoteDataSource>(),
        connectivity: sl<NetworkConnectivity>(),
      ),
    )

    // usecases
    ..registerFactory<SignUpUser>(
      () => SignUpUser(
        authRepo: sl<AuthRepo>(),
      ),
    )
    ..registerFactory<SignInUser>(
      () => SignInUser(
        authRepo: sl<AuthRepo>(),
      ),
    )
    ..registerFactory<GetCurrentUser>(
      () => GetCurrentUser(
        authRepo: sl<AuthRepo>(),
      ),
    )

    // bloc
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        signUpUserUsecase: sl<SignUpUser>(),
        signInUserUsecase: sl<SignInUser>(),
        getCurrentUserUsecase: sl<GetCurrentUser>(),
        appUserCubit: sl<AppUserCubit>(),
      ),
    );
}

void _initBlogDependencies() {
  sl
    // remote data source
    ..registerFactory<BlogRemoteDataSource>(
      () => ISupabaseBlogRemoteDataSource(
        client: sl<SupabaseClient>(),
      ),
    )
    // local data source
    ..registerFactory<BlogLocalDataSource>(
      () => IHiveBlogLocalDataSource(
        box: sl<Box>(),
      ),
    )

    // repo
    ..registerFactory<BlogRepo>(
      () => IBlogRepo(
        remoteDataSource: sl<BlogRemoteDataSource>(),
        localDataSource: sl<BlogLocalDataSource>(),
        connectivity: sl<NetworkConnectivity>(),
      ),
    )

    // usecases
    ..registerFactory<SignOutUser>(
      () => SignOutUser(
        repo: sl<BlogRepo>(),
      ),
    )
    ..registerFactory<PublishBlog>(
      () => PublishBlog(
        repo: sl<BlogRepo>(),
      ),
    )
    ..registerFactory<GetAllBlogs>(
      () => GetAllBlogs(
        repo: sl<BlogRepo>(),
      ),
    )

    // bloc
    ..registerLazySingleton<BlogBloc>(
      () => BlogBloc(
        signOutUserUsecase: sl<SignOutUser>(),
        appUserCubit: sl<AppUserCubit>(),
        publishBlogUsecase: sl<PublishBlog>(),
        getAllBlogsUsecase: sl<GetAllBlogs>(),
      ),
    );
}
