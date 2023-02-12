class UnbordingContent {
  final String image;
  final String title;
  final String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Coach Your Cash',
      image: 'assets/images/people.png',
      discription:
          "Bringing to you a platform that takes care of your money so that the next time you reach into your pocket, you know where that 100 rupee note went. "),
  UnbordingContent(
      title: 'Control Your Spending',
      image: 'assets/images/money.png',
      discription:
          "Manage your expenses and savings in a way made easy. Just input what has gone in and out from your budgest into pre-defined categories."),
  UnbordingContent(
      title: 'Fund Your Future',
      image: 'assets/images/phone_girl-nobg.png',
      discription:
          "The hardest part of investing can be thinking of yourself as an investor, and we aim to make this evolution easy for you, by assisting you at the right stages."),
];
