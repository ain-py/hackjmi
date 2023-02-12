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
      image: 'assets/images/wallet-nbg.png',
      discription:
          "Bringing to you a platform that takes care of your money so that the next time you reach into your pocket, you know where that 100 rupee note went. "),
  UnbordingContent(
      title: 'Fast Delevery',
      image: 'assets/images/logo.png',
      discription:
          "Manage your expenses and savings in a way made easy. Just input what has gone in and out from your budgest into pre-defined categories."),
  UnbordingContent(
      title: 'Reward surprises',
      image: 'images/reward.svg',
      discription:
          "simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the "
          "industry's standard dummy text ever since the 1500s, "
          "when an unknown printer took a galley of type and scrambled it "),
];
