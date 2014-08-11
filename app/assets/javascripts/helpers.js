String.prototype.toInt = function() {
  return parseInt(this);
}

Number.prototype.toTime = function() {
  if (this < 10) {
    return '0' + this;
  } else {
    return this + '';
  }
}

Number.prototype.round5 = function() {
  return ((this)- (this % 5));
}
