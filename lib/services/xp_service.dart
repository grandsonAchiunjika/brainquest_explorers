class XPService {
  int _xp = 0;

  int get currentXP => _xp;

  void addXP(int points) {
    _xp += points;
  }

  void resetXP() {
    _xp = 0;
  }
}
