<h1>Blog Flutter App made Clean with Supabase, Hive, BLoC, and DI

### Tech and services used in the project:
1. **Supabase (authentication, online database, and storage)**
2. **Hive (local storage and caching)**
3. **BLoC (state management)**

### Packages and dependencies used in project:
1. **[flutter_bloc: ^8.1.5](https:www.pub.dev/packages/flutter_bloc) (state management)**  
2. **[fpdart: ^1.1.0](https:www.pub.dev/packages/fpdart) (functional programming)**  
3. **[get_it: ^7.6.7](https:www.pub.dev/packages/get_it) (dependency injection)**  
4. **(local storage)**  
    i. [**hive: ^4.0.0-dev.2**](https:www.pub.dev/packages/hive)  
    ii. [**path_provider: ^2.1.0**](https:www.pub.dev/packages/path_provider)  
5. **[image_picker: ^1.0.7](https:www.pub.dev/packages/image_picker) (image picker)**  
6. **[internet_connection_checker_plus: 2.2.0](https:www.pub.dev/packages/internet_connection_checker_plus) (network and connectivity)**  
7. **[supabase_flutter: ^2.3.4](https:www.pub.dev/packages/supabase_flutter) (supabase)**  
8. **[intl: ^0.19.0](https:www.pub.dev/packages/intl) (date formatting)**  
9. **[uuid: ^4.3.3](https:www.pub.dev/packages/uuid) (unique ids)**  

### Folder structure used in project:
```
└── lib
  └── core
    └── constants
      └── app_secrets.dart
    └── resources
      └── exceptions.dart
      └── failure.dart
      └── usecase.dart
    └── shared
      └── cubits
        └── app_user
          └── app_user_cubit.dart
          └── app_user_state.dart
      └── entities
        └── profile.dart
      └── network
        └── network_connectivity.dart
      └── widgets
        └── gradient_button.dart
        └── input_field.dart
        └── loader.dart
    └── theme
      └── app_palette.dart
      └── app_theme.dart
    └── utils
      └── enums.dart
      └── helpers.dart
  └── features
    └── auth
      └── data
        └── models
          └── profile_model.dart
        └── repo
          └── i_auth_repo.dart
        └── sources
          └── remote
            └── auth_remote_data_source.dart
            └── i_supabase_auth_remote_data_source.dart
      └── domain
        └── repo
          └── auth_repo.dart
        └── usecases
          └── get_current_user.dart
          └── sign_in_user.dart
          └── sign_up_user.dart
      └── presentation
        └── bloc
          └── auth_bloc.dart
          └── auth_event.dart
          └── auth_state.dart
        └── screens
          └── signin_screen.dart
          └── signup_screen.dart
    └── blog
      └── data
        └── models
          └── blog_model.dart
        └── repo
          └── i_blog_repo.dart
        └── sources
          └── local
            └── blog_local_data_source.dart
            └── i_hive_blog_local_data_source.dart
          └── remote
            └── blog_remote_data_source.dart
            └── i_supabase_blog_remote_data_source.dart
      └── domain
        └── entities
          └── blog.dart
        └── repo
          └── blog_repo.dart
        └── usecases
          └── get_all_blogs.dart
          └── publish_blog.dart
          └── sign_out_user.dart
      └── presentation
        └── bloc
          └── blog_bloc.dart
          └── blog_event.dart
          └── blog_state.dart
        └── screens
          └── add_blog_screen.dart
          └── blog_screen.dart
          └── show_blog.dart
        └── widgets
          └── blog_tile.dart
  └── dependency_injection.dart
  └── main.dart
```