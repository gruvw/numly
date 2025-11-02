// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TestState {

 DateTime get startTime; DateTime? get endTime; Duration get targetDuration; int get length; bool get isEndless; int get doneQuestionsCount; int get mistakesCount; int get mistakeStreak; int get maxMistakeStreak; int get failedQuestionsCount; String? get lastSubmittedAnswer; Question get currentQuestion; Question? get nextQuestion;
/// Create a copy of TestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestStateCopyWith<TestState> get copyWith => _$TestStateCopyWithImpl<TestState>(this as TestState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestState&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.targetDuration, targetDuration) || other.targetDuration == targetDuration)&&(identical(other.length, length) || other.length == length)&&(identical(other.isEndless, isEndless) || other.isEndless == isEndless)&&(identical(other.doneQuestionsCount, doneQuestionsCount) || other.doneQuestionsCount == doneQuestionsCount)&&(identical(other.mistakesCount, mistakesCount) || other.mistakesCount == mistakesCount)&&(identical(other.mistakeStreak, mistakeStreak) || other.mistakeStreak == mistakeStreak)&&(identical(other.maxMistakeStreak, maxMistakeStreak) || other.maxMistakeStreak == maxMistakeStreak)&&(identical(other.failedQuestionsCount, failedQuestionsCount) || other.failedQuestionsCount == failedQuestionsCount)&&(identical(other.lastSubmittedAnswer, lastSubmittedAnswer) || other.lastSubmittedAnswer == lastSubmittedAnswer)&&(identical(other.currentQuestion, currentQuestion) || other.currentQuestion == currentQuestion)&&(identical(other.nextQuestion, nextQuestion) || other.nextQuestion == nextQuestion));
}


@override
int get hashCode => Object.hash(runtimeType,startTime,endTime,targetDuration,length,isEndless,doneQuestionsCount,mistakesCount,mistakeStreak,maxMistakeStreak,failedQuestionsCount,lastSubmittedAnswer,currentQuestion,nextQuestion);

@override
String toString() {
  return 'TestState(startTime: $startTime, endTime: $endTime, targetDuration: $targetDuration, length: $length, isEndless: $isEndless, doneQuestionsCount: $doneQuestionsCount, mistakesCount: $mistakesCount, mistakeStreak: $mistakeStreak, maxMistakeStreak: $maxMistakeStreak, failedQuestionsCount: $failedQuestionsCount, lastSubmittedAnswer: $lastSubmittedAnswer, currentQuestion: $currentQuestion, nextQuestion: $nextQuestion)';
}


}

/// @nodoc
abstract mixin class $TestStateCopyWith<$Res>  {
  factory $TestStateCopyWith(TestState value, $Res Function(TestState) _then) = _$TestStateCopyWithImpl;
@useResult
$Res call({
 DateTime startTime, DateTime? endTime, Duration targetDuration, int length, bool isEndless, int doneQuestionsCount, int mistakesCount, int mistakeStreak, int maxMistakeStreak, int failedQuestionsCount, String? lastSubmittedAnswer, Question currentQuestion, Question? nextQuestion
});




}
/// @nodoc
class _$TestStateCopyWithImpl<$Res>
    implements $TestStateCopyWith<$Res> {
  _$TestStateCopyWithImpl(this._self, this._then);

  final TestState _self;
  final $Res Function(TestState) _then;

/// Create a copy of TestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startTime = null,Object? endTime = freezed,Object? targetDuration = null,Object? length = null,Object? isEndless = null,Object? doneQuestionsCount = null,Object? mistakesCount = null,Object? mistakeStreak = null,Object? maxMistakeStreak = null,Object? failedQuestionsCount = null,Object? lastSubmittedAnswer = freezed,Object? currentQuestion = null,Object? nextQuestion = freezed,}) {
  return _then(_self.copyWith(
startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,targetDuration: null == targetDuration ? _self.targetDuration : targetDuration // ignore: cast_nullable_to_non_nullable
as Duration,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,isEndless: null == isEndless ? _self.isEndless : isEndless // ignore: cast_nullable_to_non_nullable
as bool,doneQuestionsCount: null == doneQuestionsCount ? _self.doneQuestionsCount : doneQuestionsCount // ignore: cast_nullable_to_non_nullable
as int,mistakesCount: null == mistakesCount ? _self.mistakesCount : mistakesCount // ignore: cast_nullable_to_non_nullable
as int,mistakeStreak: null == mistakeStreak ? _self.mistakeStreak : mistakeStreak // ignore: cast_nullable_to_non_nullable
as int,maxMistakeStreak: null == maxMistakeStreak ? _self.maxMistakeStreak : maxMistakeStreak // ignore: cast_nullable_to_non_nullable
as int,failedQuestionsCount: null == failedQuestionsCount ? _self.failedQuestionsCount : failedQuestionsCount // ignore: cast_nullable_to_non_nullable
as int,lastSubmittedAnswer: freezed == lastSubmittedAnswer ? _self.lastSubmittedAnswer : lastSubmittedAnswer // ignore: cast_nullable_to_non_nullable
as String?,currentQuestion: null == currentQuestion ? _self.currentQuestion : currentQuestion // ignore: cast_nullable_to_non_nullable
as Question,nextQuestion: freezed == nextQuestion ? _self.nextQuestion : nextQuestion // ignore: cast_nullable_to_non_nullable
as Question?,
  ));
}

}


/// Adds pattern-matching-related methods to [TestState].
extension TestStatePatterns on TestState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestState value)  $default,){
final _that = this;
switch (_that) {
case _TestState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestState value)?  $default,){
final _that = this;
switch (_that) {
case _TestState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime startTime,  DateTime? endTime,  Duration targetDuration,  int length,  bool isEndless,  int doneQuestionsCount,  int mistakesCount,  int mistakeStreak,  int maxMistakeStreak,  int failedQuestionsCount,  String? lastSubmittedAnswer,  Question currentQuestion,  Question? nextQuestion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestState() when $default != null:
return $default(_that.startTime,_that.endTime,_that.targetDuration,_that.length,_that.isEndless,_that.doneQuestionsCount,_that.mistakesCount,_that.mistakeStreak,_that.maxMistakeStreak,_that.failedQuestionsCount,_that.lastSubmittedAnswer,_that.currentQuestion,_that.nextQuestion);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime startTime,  DateTime? endTime,  Duration targetDuration,  int length,  bool isEndless,  int doneQuestionsCount,  int mistakesCount,  int mistakeStreak,  int maxMistakeStreak,  int failedQuestionsCount,  String? lastSubmittedAnswer,  Question currentQuestion,  Question? nextQuestion)  $default,) {final _that = this;
switch (_that) {
case _TestState():
return $default(_that.startTime,_that.endTime,_that.targetDuration,_that.length,_that.isEndless,_that.doneQuestionsCount,_that.mistakesCount,_that.mistakeStreak,_that.maxMistakeStreak,_that.failedQuestionsCount,_that.lastSubmittedAnswer,_that.currentQuestion,_that.nextQuestion);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime startTime,  DateTime? endTime,  Duration targetDuration,  int length,  bool isEndless,  int doneQuestionsCount,  int mistakesCount,  int mistakeStreak,  int maxMistakeStreak,  int failedQuestionsCount,  String? lastSubmittedAnswer,  Question currentQuestion,  Question? nextQuestion)?  $default,) {final _that = this;
switch (_that) {
case _TestState() when $default != null:
return $default(_that.startTime,_that.endTime,_that.targetDuration,_that.length,_that.isEndless,_that.doneQuestionsCount,_that.mistakesCount,_that.mistakeStreak,_that.maxMistakeStreak,_that.failedQuestionsCount,_that.lastSubmittedAnswer,_that.currentQuestion,_that.nextQuestion);case _:
  return null;

}
}

}

/// @nodoc


class _TestState extends TestState {
  const _TestState({required this.startTime, required this.endTime, required this.targetDuration, required this.length, required this.isEndless, required this.doneQuestionsCount, required this.mistakesCount, required this.mistakeStreak, required this.maxMistakeStreak, required this.failedQuestionsCount, required this.lastSubmittedAnswer, required this.currentQuestion, required this.nextQuestion}): super._();
  

@override final  DateTime startTime;
@override final  DateTime? endTime;
@override final  Duration targetDuration;
@override final  int length;
@override final  bool isEndless;
@override final  int doneQuestionsCount;
@override final  int mistakesCount;
@override final  int mistakeStreak;
@override final  int maxMistakeStreak;
@override final  int failedQuestionsCount;
@override final  String? lastSubmittedAnswer;
@override final  Question currentQuestion;
@override final  Question? nextQuestion;

/// Create a copy of TestState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestStateCopyWith<_TestState> get copyWith => __$TestStateCopyWithImpl<_TestState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestState&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.targetDuration, targetDuration) || other.targetDuration == targetDuration)&&(identical(other.length, length) || other.length == length)&&(identical(other.isEndless, isEndless) || other.isEndless == isEndless)&&(identical(other.doneQuestionsCount, doneQuestionsCount) || other.doneQuestionsCount == doneQuestionsCount)&&(identical(other.mistakesCount, mistakesCount) || other.mistakesCount == mistakesCount)&&(identical(other.mistakeStreak, mistakeStreak) || other.mistakeStreak == mistakeStreak)&&(identical(other.maxMistakeStreak, maxMistakeStreak) || other.maxMistakeStreak == maxMistakeStreak)&&(identical(other.failedQuestionsCount, failedQuestionsCount) || other.failedQuestionsCount == failedQuestionsCount)&&(identical(other.lastSubmittedAnswer, lastSubmittedAnswer) || other.lastSubmittedAnswer == lastSubmittedAnswer)&&(identical(other.currentQuestion, currentQuestion) || other.currentQuestion == currentQuestion)&&(identical(other.nextQuestion, nextQuestion) || other.nextQuestion == nextQuestion));
}


@override
int get hashCode => Object.hash(runtimeType,startTime,endTime,targetDuration,length,isEndless,doneQuestionsCount,mistakesCount,mistakeStreak,maxMistakeStreak,failedQuestionsCount,lastSubmittedAnswer,currentQuestion,nextQuestion);

@override
String toString() {
  return 'TestState(startTime: $startTime, endTime: $endTime, targetDuration: $targetDuration, length: $length, isEndless: $isEndless, doneQuestionsCount: $doneQuestionsCount, mistakesCount: $mistakesCount, mistakeStreak: $mistakeStreak, maxMistakeStreak: $maxMistakeStreak, failedQuestionsCount: $failedQuestionsCount, lastSubmittedAnswer: $lastSubmittedAnswer, currentQuestion: $currentQuestion, nextQuestion: $nextQuestion)';
}


}

/// @nodoc
abstract mixin class _$TestStateCopyWith<$Res> implements $TestStateCopyWith<$Res> {
  factory _$TestStateCopyWith(_TestState value, $Res Function(_TestState) _then) = __$TestStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime startTime, DateTime? endTime, Duration targetDuration, int length, bool isEndless, int doneQuestionsCount, int mistakesCount, int mistakeStreak, int maxMistakeStreak, int failedQuestionsCount, String? lastSubmittedAnswer, Question currentQuestion, Question? nextQuestion
});




}
/// @nodoc
class __$TestStateCopyWithImpl<$Res>
    implements _$TestStateCopyWith<$Res> {
  __$TestStateCopyWithImpl(this._self, this._then);

  final _TestState _self;
  final $Res Function(_TestState) _then;

/// Create a copy of TestState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startTime = null,Object? endTime = freezed,Object? targetDuration = null,Object? length = null,Object? isEndless = null,Object? doneQuestionsCount = null,Object? mistakesCount = null,Object? mistakeStreak = null,Object? maxMistakeStreak = null,Object? failedQuestionsCount = null,Object? lastSubmittedAnswer = freezed,Object? currentQuestion = null,Object? nextQuestion = freezed,}) {
  return _then(_TestState(
startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,targetDuration: null == targetDuration ? _self.targetDuration : targetDuration // ignore: cast_nullable_to_non_nullable
as Duration,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,isEndless: null == isEndless ? _self.isEndless : isEndless // ignore: cast_nullable_to_non_nullable
as bool,doneQuestionsCount: null == doneQuestionsCount ? _self.doneQuestionsCount : doneQuestionsCount // ignore: cast_nullable_to_non_nullable
as int,mistakesCount: null == mistakesCount ? _self.mistakesCount : mistakesCount // ignore: cast_nullable_to_non_nullable
as int,mistakeStreak: null == mistakeStreak ? _self.mistakeStreak : mistakeStreak // ignore: cast_nullable_to_non_nullable
as int,maxMistakeStreak: null == maxMistakeStreak ? _self.maxMistakeStreak : maxMistakeStreak // ignore: cast_nullable_to_non_nullable
as int,failedQuestionsCount: null == failedQuestionsCount ? _self.failedQuestionsCount : failedQuestionsCount // ignore: cast_nullable_to_non_nullable
as int,lastSubmittedAnswer: freezed == lastSubmittedAnswer ? _self.lastSubmittedAnswer : lastSubmittedAnswer // ignore: cast_nullable_to_non_nullable
as String?,currentQuestion: null == currentQuestion ? _self.currentQuestion : currentQuestion // ignore: cast_nullable_to_non_nullable
as Question,nextQuestion: freezed == nextQuestion ? _self.nextQuestion : nextQuestion // ignore: cast_nullable_to_non_nullable
as Question?,
  ));
}


}

// dart format on
