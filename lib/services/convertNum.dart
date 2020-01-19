convertNum(num) {
  var d = double.parse(num.toString());
  var i = d ~/ 100;
  return d > i * 100 ? (d / 100).toStringAsFixed(2) : i;
}