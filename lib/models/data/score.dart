import "package:numly/models/game/game.dart";

typedef GameSetting = ({GameId gameId, int length});

class Score {
  final String gameId;
  final int length; // in number of questions
  final Duration duration;

  Score({
    required this.gameId,
    required this.length,
    required this.duration,
  });

  Score.fromData({
    required this.gameId,
    required this.length,
    required int durationMs,
  }) : duration = Duration(milliseconds: durationMs);
}
