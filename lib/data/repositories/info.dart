//The Core folder will contain our classes, like the CatPhoto class.
// The Services folder will contain classes to make external calls,
// like calls to get photos. These classes don’t care about the UI
// or how the UI wants to display the data. They can throw an exception
// when something goes wrong.
// The Helper folder will contain classes that will convert the raw data
// from Services to the form that is useful in our app. These classes gracefully
// handle exceptions that can occur in Services and convert them to messages which
// will be helpful to UI developers.

//instead of helpers and services i prefer    models and repositories respectively

/*


 let’s convert the raw response of the cat API server to a CatPhoto instance
  through our helper. Create a CatPhotoHelper.dart file in the Helper folder
   and create a CatPhotoHelper class in it.

   class CatPhotoHelper {
  final api = CatPhotoApi();
  Future<Either<Glitch, CatPhoto>> getRandomCatPhoto() async {
    final apiResult = await api.getRandomCatPhoto();
    return apiResult.fold((l) {
      // There can be many types of error, but for simplicity, we are going
      // to assume only NoInternetGlitch
      return Left(NoInternetGlitch());
    }, (r) {
      // the API returns breed, id, url, width, height, category, details, etc.,
      // but we will take only the information we need in our app and ignore
      // the rest
      // here we will decode the API result to CatPhoto
      final photo = CatPhoto.fromMap(jsonDecode(r)[0]);
      return Right(photo);
    });
  }
}
 */
