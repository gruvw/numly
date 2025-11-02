import "package:hooks_riverpod/hooks_riverpod.dart";

// see https://github.com/rrousselGit/riverpod/issues/67

extension MapData<T> on AsyncValue<T> {
  AsyncValue<E> mapData<E>(AsyncValue<E> Function(T value) data) {
    return when(
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      skipError: false,
      data: data,
      error: (error, stackTrace) => AsyncError(error, stackTrace),
      loading: () => AsyncLoading(),
    );
  }
}

// unwrap: throwing loading states and errors
class LoadingState {}

extension Unwrap<T> on AsyncValue<T> {
  T unwrap() => when(
    data: (d) => d,
    error: (e, s) => Error.throwWithStackTrace(e, s),
    loading: () => throw LoadingState(),
  );
}

Provider<AsyncValue<StateT>> asyncValueProvider<StateT>(
  StateT Function(Ref) create,
) => Provider((ref) {
  try {
    return AsyncData(create(ref));
  } on LoadingState {
    return AsyncLoading();
  } catch (e, s) {
    return AsyncError(e, s);
  }
});

abstract class AsyncValueNotifier<StateT> extends Notifier<AsyncValue<StateT>> {
  @override
  AsyncValue<StateT> build() {
    try {
      return AsyncData(create());
    } on LoadingState {
      return const AsyncLoading();
    } catch (e, s) {
      return AsyncError(e, s);
    }
  }

  // Override this instead of build()
  StateT create();
}
