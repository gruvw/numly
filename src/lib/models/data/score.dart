class Score {
  final String gameId;
  final int questionCount;
  final Duration duration;

  Score({
    required this.gameId,
    required this.questionCount,
    required this.duration,
  });

  factory Score.fromData({
    required String gameId,
    required int questionCount,
    required int durationMs,
  }) {
    return Score(
      gameId: gameId,
      questionCount: questionCount,
      duration: Duration(
        milliseconds: durationMs,
      ),
    );
  }
}
