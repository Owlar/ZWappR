abstract class IFavoriteService {

  // Creating a favorite from swiping/clicking favorite with:
  /// [thingId]
  Future<void> create(String thingId);

}