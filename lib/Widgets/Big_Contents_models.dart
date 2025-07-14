class UnboardingContent {
  String image;
  String title;
  String description;

  UnboardingContent({
    required this.description,
    required this.image,
    required this.title,
  });
}

List<UnboardingContent> contents = [
  //1st screen//
  UnboardingContent(
    description:
        "  Get accurate results with our AI-powered rapid testing \n  solution.\n\n  Using deep-learning and image analysis technology, our tool\n  provides fast and reliable test results. ",
    image: "assets/onboard1.png",
    title: "Rapid Test Solution",
  ),
  //2nd screen//
  UnboardingContent(
    description:
        "  Our AI-powered solution provides accurate and reliable\n  results in just minutes.\n\n  Say goodbye to long wait times and hello to fast, efficient\n  testing.",
    image: "assets/onboard2.png",
    title: "AI-Powered Testing",
  ),
  //3rd screen//
  UnboardingContent(
    description:
        "  Our solution is designed to be user-friendly and easy to\n  use.\n\n  With a simple interface and clear instructions, you can get\n  accurate results in no time.",
    image: "assets/onboard3.png",
    title: "User-Friendly Interface",
  ),
];
