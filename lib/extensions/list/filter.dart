//Purpose is to display notes w.r.t user
// grab hold of contents of stream in our extension
extension Filter<T> on Stream<List<T>> {
  Stream<List<T>> filter(bool Function(T) where) =>
      map((items) => items.where(where).toList());
}
