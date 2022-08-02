String countFormat(int count) {
  String views = "";
  if (count > 999) {
    views = "${(count / 10000).toStringAsFixed(2)}万";
  } else {
    views = count.toString();
  }
  return views;
}

String dateFormat(int seconds) {
  int m = (seconds / 60).truncate();
  int s = seconds - m * 60;
  if (s < 10) {
    return "$m:0$s";
  }
  return "$m:$s";
}
