abstract class IFavoriteService {
  // Creating a favorite with:
  /// [userId]
  Future<void> create(String userId);

  // Deleting my favorite with:
  /// [thingId]
  Future<void> delete(String thingId);
}