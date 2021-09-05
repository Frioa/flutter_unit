
class LinearSearch {
  static int search<T>(List<T> data, T target) {
    for (int i = 0; i < data.length; i++) {
      if (data[i] == target) return i;
    }

    return -1;
  }
}