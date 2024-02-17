class UnbordingContent {
  String image;
  String title;
  String discription;
  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Save',
      image: 'images/Logo.jpeg',
      discription: "Earn Money 💸 From Your Scrap with Scrap Out "
  ),
  UnbordingContent(
      title: 'Sell/Buy',
      image: 'images/sell.jpg',
      discription: "Sell/Buy the Scrap with cheap prices."
  ),
  UnbordingContent(
      title: 'Reward surprises',
      image: 'images/coins.jpg',
      discription: "Get Instanty Paid for your scrap."
  ),
];