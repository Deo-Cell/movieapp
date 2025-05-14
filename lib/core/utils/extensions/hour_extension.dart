extension RuntimeFormat on int {
  String toFormattedString() {
    int hours = this ~/ 60;
    int minutes = this % 60;

    if (hours > 0) {
      if (minutes > 0) {
        return '${hours}h ${minutes}min';
      } else {
        return '${hours}h';
      }
    } else {
      return '${minutes}min';
    }
  }
}
