enum MaxMistakeStreak {
  strict(1),
  retry(2),
  resilient(3),
  persistent(5),
  unlimited(99999);

  final int amount;

  const MaxMistakeStreak(this.amount);
}
