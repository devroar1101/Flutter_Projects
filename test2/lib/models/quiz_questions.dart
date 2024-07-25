class QuizQuestion {
  const QuizQuestion(this.question, this.options);

  final String question;
  final List<String> options;

  List<String> getShuffledAnswer() {
    final shuffleans = List.of(options);
    shuffleans.shuffle();
    return shuffleans;
  }
}
