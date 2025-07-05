class MemeImagesEndPoint {
  static get basePath => "https://api.imgflip.com";

  static getMemeImage() {
    return "$basePath/get_memes";
  }
}
